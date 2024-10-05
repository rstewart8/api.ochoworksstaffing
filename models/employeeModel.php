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
    var $User;

	function __construct($db,$logger,$companyId,$schedule=null,$user=null)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->AvatarPath = AVATARPATH;
        $this->DefaultAvatar = DEFAULTAVATAR;
        $this->CompanyId = $companyId;
        $this->Schedule = $schedule;
        $this->User = $user;
	}

    function isFieldValueUnique($field, $value, $id = null)
    {
        $values = [$this->CompanyId, $value];
        $qry = "select id from users where company_id = ? and status != 'deleted' and $field = ?";

        if ($id != null) {
            $qry .= " and id != ?";
            array_push($values, $id);
        }

        if (count($this->Db->query($qry, $values)) > 0) {
            return false;
        }

        return true;
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
        
        if (count($workDays) < 1) {
            return $d;
        }
        
        // Start the query
        $union = "SELECT '" . $workDays[0] . "' AS day";

        // Append each subsequent date with UNION ALL
        for ($i = 1; $i < count($workDays); $i++) {
            $union .= " UNION ALL SELECT '" . $workDays[$i] . "'";
        }

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
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'available_count DESC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $availableCountSubQry = <<<SQL
            WITH workdays AS (
                $union
            ),
            filtered_workdays AS (
                SELECT wd.day
                FROM workdays wd
                LEFT JOIN schedule_assignments sa
                    ON wd.day = sa.date AND sa.user_id = u.id and sa.status = 'active'
                WHERE sa.date IS NULL
            )
            SELECT 
                COUNT(*) AS record_count
            FROM 
                filtered_workdays
            JOIN 
                weekdays ON LOWER(weekdays.day) = CASE DAYOFWEEK(filtered_workdays.day)
                    WHEN 1 THEN 'sunday'
                    WHEN 2 THEN 'monday'
                    WHEN 3 THEN 'tuesday'
                    WHEN 4 THEN 'wednesday'
                    WHEN 5 THEN 'thursday'
                    WHEN 6 THEN 'friday'
                    WHEN 7 THEN 'saturday'
                END
            JOIN
                employee_weekdays ON employee_weekdays.weekday_id = weekdays.id AND employee_weekdays.user_id = u.id
        SQL;

        $qry = "select u.id as user_id,u.firstname, u.lastname";
        $qry .= " ,($availableCountSubQry) as available_count";
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
        $qry .= " having available_count > 0 and es_count = $skillCnt";

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
            $weekdayNos = [];

            $userId = $row['user_id'];
            $qry = "select schedule_id,date from schedule_assignments where user_id = ? and status = 'active';";
            $rows2 = $this->Db->query($qry,[$userId]);
            foreach($rows2 as $row1) {
                $scheduledDays[] = $row1['date'];
                if ($scheduleId == $row1['schedule_id']) {
                    $assignedDays[] = $row1['date'];
                }
            }

            //// Get user workday no
            $qry ="select w.no";
            $qry .= " from employee_weekdays ew";
            $qry .= " join weekdays w on w.id = ew.weekday_id";
            $qry .= " where ew.user_id = ?";

            $rows2 = $this->Db->query($qry,[$userId]);
            foreach($rows2 as $row1) {
                $weekdayNos[] = $row1['no'];
            }

            foreach($workDays as $day) {
                
                $dayOfWeekNumber = date('w', strtotime($day));
                if (!in_array($day,$scheduledDays) && in_array($dayOfWeekNumber,$weekdayNos)) {
                    $availableDays[] = $day;
                }
            }

            if (count($availableDays) == count($workDays)) {
                $availability = 'all';
            }

            $notificationsList = [];
            $qry = "SELECT n.id as notification_id, n.notification_type, n.name as notification_name";
            $qry .= " FROM employee_notifications en";
            $qry .= " join notifications n on n.id = en.id";
            $qry .= " join company_notifications cn on cn.notification_id = en.notification_id and cn.status = 'active'";
            $qry .= " where en.user_id = ?";
            $qry .= " and en.status = 'active'";

            $notificationsList = $this->Db->query($qry,[$userId]);

            $notifications = [];

            $qry = "select notification_queue_id,which,message,status from user_schedule_notifications where user_id = ? and schedule_id = ? order by id desc limit 1;";
            $notifications = $this->Db->query($qry,[$userId,$scheduleId]);
            
            $row['assignedDays'] = $assignedDays;
            $row['availableDays'] = $availableDays;
            $row['availability'] = $availability;
            $row['notifications'] = $notifications;
            $row['notificationsList'] = $notificationsList;
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

    function assignmentDetails($data, $usrId=null) {
        $userId = ($usrId == null) ? $data['userId'] : $usrId;
        $start = $data['start'];
        $end = $data['end'];

        $qry = "select sa.id as schedule_assignment_id,sa.date as schedule_assignment_date";
        $qry .= ",u.id as user_id, u.firstname, u.lastname";
        $qry .= ", s.id as schedule_id, s.time_start, s.time_end";
        $qry .= ", j.id as job_id, j.name as job_name, j.address as job_address, j.city, j.state";
        $qry .= ", c.name as client_name";
        $qry .= " from schedule_assignments sa";
        $qry .= " join users u on u.id = sa.user_id and u.status = 'active'";
        $qry .= " join schedules s on s.id = sa.schedule_id and s.status = 'active' and s.company_id = ?";
        $qry .= " join jobs j on j.id = s.job_id and j.status = 'active'";
        $qry .= " join clients c on c.id = j.client_id";
        $qry .= " where sa.user_id = ?";
        $qry .= " and sa.date between ? and ?";
        $qry .= " and sa.status = 'active'";
        $qry .= " order by sa.date asc";

        $rows =  $this->Db->query($qry,[$this->CompanyId,$userId,$start,$end]);

        foreach ($rows as &$row) {
            $row['pretty_start'] = mediumTime($row['time_start']);
            $row['pretty_end'] = mediumTime($row['time_end']);
            $row['address'] = prettyAddress($row['job_address'],$row['city'],$row['state'],null);
        }

        return $rows;

    }

    function fetch($data){
        $d = [
            'employee' => []
        ];

        $userId = $data['id'];
        $values = [$this->CompanyId,$userId];

        $qry = "SELECT u.id, u.firstname, u.lastname, u.address, u.city, u.state, u.zip, u.email, u.phone, u.cell, u.gender, u.photo, u.timezone_id, u.status ";
        $qry .= " , t.name as timezone";
        $qry .= " , s.name as statename";
        $qry .= " FROM users u";
        $qry .= " LEFT JOIN timezones t on t.id = u.timezone_id";
        $qry .= " LEFT JOIN states s on s.abbr = UPPER(u.state)";
        $qry .= " WHERE u.company_id = ?";
        $qry .= " AND u.id = ?";
        $qry .= " AND u.identity_id = 3";
        $qry .= " AND u.status != 'deleted'";
        
        $d['employee'] = $this->Db->query($qry, $values);

        return [$d];
	}

    function update($data)
    {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => $data
        ];

        $sets = [];
        $values = [];

        $id = $data['id'];

        $firstName = (array_key_exists('userFirstName', $data)) ?trim($data['userFirstName']) : null;
        if ($firstName != null) {
            $sets[] = 'firstname = ?';
            $values[] = $firstName;
        }

        $lastName = (array_key_exists('userLastName', $data)) ?trim($data['userLastName']) : null;
        if ($lastName != null) {
            $sets[] = 'lastname = ?';
            $values[] = $lastName;
        }
        
        if (array_key_exists('address', $data)) {
            $address = trim($data['address']);
            $sets[] = $address === '' ? 'address = null' : 'address = ?';
            if ($address !== '') {
                $values[] = $address;
            }
        }

        if (array_key_exists('city', $data)) {
            $city = trim($data['city']);
            $sets[] = $city === '' ? 'city = null' : 'city = ?';
            if ($city !== '') {
                $values[] = $city;
            }
        }

        if (array_key_exists('state', $data)) {
            $state = trim($data['state']);
            $sets[] = $state === '' ? 'state = null' : 'state = ?';
            if ($state !== '') {
                $values[] = strtoupper($state);
            }
        }

        if (array_key_exists('zip', $data)) {
            $zip = trim($data['zip']);
            $sets[] = $zip === '' ? 'zip = null' : 'zip = ?';
            if ($zip !== '') {
                $values[] = $zip;
            }
        }

        $email = null;
        if (array_key_exists('email', $data)) {
            $email = trim($data['email']);
            $sets[] = $email === '' ? 'email = null' : 'email = ?';
            if ($email !== '') {
                $values[] = $email;
            }
        }

        if (array_key_exists('phone', $data)) {
            $phone = trim($data['phone']);
            $sets[] = $phone === '' ? 'phone = null' : 'phone = ?';
            if ($phone !== '') {
                $values[] = $phone;
            }
        }

        if (array_key_exists('cell', $data)) {
            $cell = trim($data['cell']);
            $sets[] = $cell === '' ? 'cell = null' : 'cell = ?';
            if ($cell !== '') {
                $values[] = $cell;
            }
        }

        if (array_key_exists('gender', $data)) {
            $gender = trim($data['gender']);
            $sets[] = $gender === '' ? 'gender = null' : 'gender = ?';
            if ($gender !== '') {
                $values[] = $gender;
            }
        }

        $timezoneId = (array_key_exists('timezoneId', $data)) ? $data['timezoneId'] : null;
        if ($timezoneId != null) {
            $sets[] = 'timezone_id = ?';
            $values[] = $timezoneId;
        }

        $status = (array_key_exists('status', $data)) ? $data['status'] : null;
        if ($status != null) {
            $sets[] = 'status = ?';
            $values[] = $status;
        }

        if (count($sets) < 1) {
            $res['status'] = 'error';
            $res['message'] = 'data not found';
            return $res;
        }

        $sets[] = 'modified = now()';

        if ($email != null && !$this->isFieldValueUnique('email', $email, $id)) {
            $res['status'] = 'error';
            $res['message'] = 'email already exists';
            return $res;
        }

        $values[] = $id;
        $values[] = $this->CompanyId;

        $setStr = implode(',', $sets);

        $qry = "update users set $setStr where id = ? and identity_id = 3 and company_id = ?";

        $this->Db->update($qry, $values);

        return $res;
    }

    function getWorkdays($data,$usrId=null) {
        $userId = ($usrId == null) ? $data['userId'] : $usrId;
        $d = ['workDays' => []];

        //// Get workdays
        $qry = "select w.id as weekday_id, w.no, w.day";
        $qry .= " ,ew.user_id";
        $qry .= " from weekdays as w";
        $qry .= " left join employee_weekdays as ew on ew.weekday_id = w.id and ew.user_id = ?";

        $values = [$userId];
        $d['workDays'] = $this->Db->query($qry, $values);

        return $d;
    }

    function setEmployeeWorkdays($data) {

        $userId = $data['userId'];
        $weekdayIds = $data['weekdayIds'];

        $qry = "delete from employee_weekdays where user_id = ?;";
        $this->Db->delete($qry,[$userId]);

        $idStr = implode(',',$weekdayIds);
        $qry = "select id from weekdays where id in ($idStr);";
        $values = [];

        $sets = [];

        $rows = $this->Db->query($qry,$values);
        foreach ($rows as $row) {
            $sets[] = "($userId,$row[id])";
        }

        if (count($sets) < 1){
            return;
        }

        $setStr = implode(',',$sets);

        $qry = "insert into employee_weekdays (`user_id`,`weekday_id`) values $setStr;";
        $this->Db->insert($qry,[]);

        return;
    }

    function getSkills($data,$usrId=null) {
        $userId = ($usrId == null) ? $data['userId'] : $usrId;
        $d = ['skills' => []];

        //// Get skills
        $qry = "select s.id as skill_id,s.name,s.status";
        $qry .= " ,es.user_id ";
        $qry .= " from skills as s";
        $qry .= " left join employee_skills as es on es.skill_id = s.id and es.user_id = ?";
        $qry .= " where s.company_id = ?";

        $values = [$userId, $this->CompanyId];
        $d['skills'] = $this->Db->query($qry, $values);

        return $d;
    }

    function setEmployeeSkills($data) {

        $userId = $data['userId'];
        $skillIds = $data['skillIds'];

        $qry = "delete from employee_skills where user_id = ?;";
        $this->Db->delete($qry,[$userId]);

        $idStr = implode(',',$skillIds);
        $qry = "select id from skills where id in ($idStr) and company_id = ?;";
        $values = [$this->CompanyId];

        $sets = [];

        $rows = $this->Db->query($qry,$values);
        foreach ($rows as $row) {
            $sets[] = "($userId,$row[id])";
        }

        if (count($sets) < 1){
            return;
        }

        $setStr = implode(',',$sets);

        $qry = "insert into employee_skills (`user_id`,`skill_id`) values $setStr;";
        $this->Db->insert($qry,[]);

        return;
    }

    function forClientByDays($data,$clntId=null) {
        date_default_timezone_set($this->User['timezoneloc']);
        $today = date('Y-m-d');
        
        $start = (array_key_exists('start',$data)) ? $data['start'] : $today;
        $end = (array_key_exists('end', $data)) ? $data['end'] : $start;
        $clientId = ($clntId != null) ? $clntId : $data['clientId'];

        $v = [$clientId,$this->CompanyId,$start,$end];

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);


        $qry = "SELECT u.id as user_id,u.firstname,u.lastname";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " ,sa.date";
        $qry .= " ,j.id as job_id,j.name as job_name";
        $qry .= " FROM users u";
        $qry .= " join schedule_assignments sa on sa.user_id = u.id and sa.status = 'active'";
        $qry .= " join schedules s on s.id = sa.schedule_id";
        $qry .= " join jobs j on j.id = s.job_id and j.client_id = ?";
        $qry .= " where u.company_id = ?";
        $qry .= " and sa.date >= ?";
        $qry .= " and sa.date <= ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        $qry .= " AND u.status = 'active'";

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = [
            'count' => $count,
            'users' => $rows,
        ];

        return $d;
    }

}
?>