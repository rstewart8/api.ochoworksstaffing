<?php
/**
*
*/

class EmployeeModel
{
	var $Logger;
    var $Db;
    var $CompanyId;
    var $AvatarPath;
    var $DefaultAvatar;
    var $Schedule;

	function __construct($db,$logger,$companyId,$schedule=null)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->AvatarPath = AVATARPATH;
        $this->DefaultAvatar = DEFAULTAVATAR;
        $this->CompanyId = $companyId;
        $this->Schedule = $schedule;
	}

	function forSchedule($data=null){
        $scheduleId = (array_key_exists('scheduleId', $data)) ? $data['schedule'] : null;

		$count = 0;
        $rows = [];

        $d = [
            'count' => $count,
            'employees' => $rows,
        ];
        return $d;
	}

    function scheduleStatus($userId,$scheduleId) {
        $ret = [0,0];
        $qry = "select *";
        $qry .= " from schedules s";
        $qry .= " join schedule_assignments sa on sa.schedule_id = s.id and sa.status = 'active'";
        $qry .= " where s.id = ?";
        $qry .= " and sa.user_id = ?";

        $rows = $this->Db->query($qry,[$scheduleId,$userId]);

        if (count($rows) > 0) {
            $workdayId = $rows[0]['workday_id'];
            $start = $rows[0]['start'];
            $end = $rows[0]['end'];
            $workdays = getWorkdays($this->Db,$workdayId,$start,$end,true);
            $ret = [count($rows),count($workdays)];
        }

        return $ret;
    }

    function remainingcheduleStatus($userId,$scheduleId) {
        $ret = [0,0];

        $qry = "select s.workday_id,s.start,s.end";
        $qry .= ",sa.date";
        $qry .= " from schedules s";
        $qry .= " left join schedule_assignments sa on sa.schedule_id = s.id and sa.status = 'active'";
        $qry .= " where s.id = ?";
        $qry .= " and sa.user_id = ?";

        $rows = $this->Db->query($qry,[$scheduleId,$userId]);

        if (count($rows) < 1) {
            return $ret;
        }

        $filled = [];
        $workdayId = $rows[0]['workday_id'];
        $start = $rows[0]['start'];
        $end = $rows[0]['end'];
        $workdays = getWorkdays($this->Db,$workdayId,$start,$end,false);

        foreach ($rows as $row) {
            if (in_array($row['date'],$workdays)) {
                $filled[] = $row['date'];
            }
        }

        $this->Logger->info("+++++ workdays ".print_r($workdays,true));
        $ret = [count($filled),count($workdays)];
        

        return $ret;
    }

    function available($data){
        $scheduleId = $data['scheduleId'];
        $start = array_key_exists('start',$data) ? $data['start'] : null;
        $end = array_key_exists('end',$data) ? $data['end'] : null;
        $history = array_key_exists('history',$data) && strtolower($data['history'])  == 'yes' ? true : false;

        $d = [
            'count' => 0,
            'employees' => []
        ];

        //// Get Workdays
        $workDays = $this->Schedule->unFilledScheduleDays($scheduleId,$history);
        //$workDays = getWorkdays($this->Db,null,$start,$end,$history,$scheduleId);

        //// Find unfilled workdays


        $workDayCnt = count($workDays);

        if ($workDayCnt < 1) {
            $this->Logger->info('no workdays found');
            return $d;
        }
        $workDayStr = "'".implode("','",$workDays)."'";
        $d['workDays'] = $workDays;

        $qry = "select * from schedule_skills where schedule_id = ?;";
        $rows = $this->Db->query($qry,[$scheduleId]);
        $skillCnt = count($rows);
        $skills = [];

        if ($skillCnt < 1) {
            $this->Logger->info("no skills found");
            return $d;
        }

        foreach ($rows as $row) {
            $skills[] = $row['skill_id'];
        }

        $skillsStr = "'".implode("','",$skills)."'";

        $wheres = [];
        $v = [$this->CompanyId];

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "select u.id as user_id,u.firstname, u.lastname";
        $qry .= " ,(select count(id) from schedule_assignments where user_id = u.id and date in ($workDayStr) and status = 'active') as sa_count";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " ,(select count(skill_id) from employee_skills where user_id = u.id and skill_id in ($skillsStr)) as es_count";
        $qry .= " from users u";
        $qry .= " where u.identity_id = 3";
        $qry .= " and u.status = 'active'";
        $qry .= " and u.company_id = ?";
        

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND u.status = ?";
        } else {
            $qry .= " AND u.status = 'active'";
        }

        $qry .= " group by u.id";
        $qry .= " having sa_count < $workDayCnt and es_count = $skillCnt";

        $c = $this->Db->query($qry, $values);
        $d['count'] = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        foreach ($rows as &$row) {
            $assignedDays = [];
            $availableDays = [];
            $scheduledDays = [];
            $availability = 'partial';

            $userId = $row['user_id'];
            $qry = "select schedule_id,date from schedule_assignments where user_id = ? and status = 'active';";
            $rows2 = $this->Db->query($qry,[$userId]);
            foreach($rows2 as $row1) {
                $scheduledDays[] = $row1['date'];
                if ($scheduleId == $row1['schedule_id']) {
                    $assignedDays[] = $row1['date'];
                }
            }

            foreach($workDays as $day) {
                if (!in_array($day,$scheduledDays)) {
                    $availableDays[] = $day;
                }
            }

            if (count($availableDays) == count($workDays)) {
                $availability = 'all';
            }
            
            $row['assignedDays'] = $assignedDays;
            $row['availableDays'] = $availableDays;
            $row['availability'] = $availability;
        }

        $d['employees'] = $rows;
        $d['workDaysCnt'] = $workDayCnt;
        return $d;
    }

    function validateAssignment($data,$history=true) {
        $scheduleId = $data['scheduleId'];
        $userId = $data['userId'];
        $days = $data['days'];
        //// First check skills match
        $scheduleSkills = [];
        $employeeSkills = [];
        $qry = "select skill_id from schedule_skills where schedule_id = ?";
        $rows = $this->Db->query($qry,[$scheduleId]);

        foreach ($rows as $row) {
           $scheduleSkills[] = $row['skill_id'];
        }

        $qry = "select skill_id from employee_skills where user_id = ?";
        $rows = $this->Db->query($qry,[$userId]);

        foreach ($rows as $row) {
           $employeeSkills[] = $row['skill_id'];
        }

        foreach ($scheduleSkills as $skill) {
            if (!in_array($skill,$employeeSkills)) {
                return 'user missing skills';
            }
        }
        //// Next employee days availability
        $daysStr = "'".implode("','",$days)."'";
        $qry = "select id from schedule_assignments where user_id = ? and date in ($daysStr) and status = 'active'";
        $rows = $this->Db->query($qry,[$userId]);
        
        if (count($rows) > 0) {
            return 'not all days can be scheduled';
        }

        //// Finally check schedule days needed
        $unFilledDays = $this->Schedule->unFilledScheduleDays($scheduleId,$history);

        foreach ($days as $day) {
            if (!in_array($day,$unFilledDays)) {
                return 'not all days available';
            }
        }

        return null;
    }

    function createAssignment($data) {
        foreach ($data['assignments'] as $d) {
            $scheduleId = $d['scheduleId'];
            $userId = $d['userId'];
            $days = $d['days'];

            $chck = $this->validateAssignment($d);

            if ($chck != null) {
                $this->Db->setErrrors('invalid create assignment data');
                return $chck;
            }
            $values = [];
            foreach($days as $day) {
                $values[] ="($scheduleId,$userId,'$day')";
            }

            $qry = "insert into schedule_assignments (schedule_id,user_id,date) values ".implode(",",$values).";";
            $this->Db->insert($qry,[]);
        }
        return null;
    }

    function assignments($data) {
        $userId = $data['userId'];
        $scheduleId = array_key_exists('scheduleId',$data) ? $data['scheduleId'] : null;

        $v = [$this->CompanyId,$userId];

        $qry = "select sa.date,sa.status";
        $qry .= " from schedule_assignments sa";
        $qry .= " join users u on u.id = sa.user_id and u.company_id = ?";
        $qry .= " where sa.user_id = ?";
        $qry .= " and sa.status = 'active'";

        if ($scheduleId != null) {
            $v[] = $scheduleId;
            $qry .= " and sa.schedule_id = ?";
        }
        $qry .= " order by sa.date asc;";

        $rows = $this->Db->query($qry,$v);

        return ['days' => $rows];
    }
}
?>