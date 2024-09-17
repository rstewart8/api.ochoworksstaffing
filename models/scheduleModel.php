<?php

/**
 *
 */

require_once(ROOT . "/models/skillModel.php");
require_once(ROOT . "/models/employeeModel.php");

class ScheduleModel
{
    var $Logger;
    var $Db;
    var $CompanyId;
    var $ClientId;
    var $Skill;
    var $User;
    var $AvatarPath;
    var $DefaultAvatar;
    var $Employee;

    function __construct($db, $logger, $companyId, $clientId, $user=null)
    {
        $this->Db = $db;
        $this->Logger = $logger;
        $this->CompanyId = $companyId;
        $this->ClientId = $clientId;
        $this->Skill = new SkillModel($db, $logger, $companyId);
        $this->Employee = new EmployeeModel($db, $logger, $companyId,null,$user);
        $this->User = $user;
        $this->AvatarPath = AVATARPATH;
        $this->DefaultAvatar = DEFAULTAVATAR;
    }

    function canSchedule($scheduleId) {
        $qry = "select id from schedules where id = ? and company_id = ? and status = 'active';";
        $rows = $this->Db->query($qry,[$scheduleId,$this->CompanyId]);

        if (count($rows) < 1) {
            return false;
        }

        return true;
    }

    function list($data)
    {

        $clientId = $this->ClientId;

        if ($clientId == null) {
            $clientId = array_key_exists('clientId', $data) ? $data['clientId'] : null;
        }

        $jobId = array_key_exists('jobId',$data) ? $data['jobId'] : null;
        $scheduleId = array_key_exists('scheduleId',$data) ? $data['scheduleId'] : null;
        $endBefore = array_key_exists('endBefore',$data) ? $data['endBefore'] : null;
        $startOnAfter = array_key_exists('startOnAfter',$data) ? $data['startOnAfter'] : null;
        $startAfter = array_key_exists('startAfter',$data) ? $data['startAfter'] : null;
        $upcoming = array_key_exists('upcoming',$data) && strtolower($data['upcoming'])  == 'yes' ? true : false;
        $history = array_key_exists('history',$data) && strtolower($data['history'])  == 'yes' ? true : false;


        date_default_timezone_set($this->User['timezoneloc']);
        $now = date('Y-m-d');

        if ($upcoming) {
            $startAfter = $now;
        }

        $avatarPath = AVATARPATH;
        $defaultAvatar = DEFAULTAVATAR;

        $wheres = [];
        $v = [$this->CompanyId];

        $clients = [];
        $jobs = [];

        $qry = "select s.*";
        $qry .= ",c.name as client_name";
        $qry .= ",j.name as job_name";
        $qry .= ",w.name as workday";
        $qry .= " from schedules as s";
        $qry .= " join clients as c on c.id = s.client_id";
        $qry .= " join jobs as j on j.id = s.job_id";
        $qry .= " join workdays w on w.id = s.workday_id";
        $qry .= " where s.company_id = ?";

        if ($clientId != null) {
            $v[] = $clientId;
            $qry .= " and s.client_id = ?";
        }

        if ($jobId != null) {
            $v[] = $jobId;
            $qry .= " and s.job_id = ?";
        }

        if ($scheduleId != null) {
            $v[] = $scheduleId;
            $qry .= " and s.id = ?";
        }

        if ($scheduleId == null && $endBefore == null && $startOnAfter == null && $startAfter == null && $upcoming == null) {
            $v[] = $now;
            $qry .= " and s.end >= ?";
        }

        if ($scheduleId == null && $endBefore != null) {
            $v[] = $endBefore;
            $qry .= " and s.end < ?";
        }

        if ($scheduleId == null && $startOnAfter != null) {
            $v[] = $startOnAfter;
            $qry .= " and s.start >= ?";
        }

        if ($scheduleId == null && $startAfter != null) {
            $v[] = $startAfter;
            $qry .= " and s.start > ?";
        }

        $qryData = qryBuilder($data, 's', 'schedule');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 's.id ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND s.status = ?";
        } else {
            $qry .= " AND s.status = 'active'";
        }

        $rows = $this->Db->query($qry, $values);
        $count = count($rows);
        
        $tmpClients = [];

        foreach ($rows as $row) {
            $clientId = $row['client_id'];
            $jobId = $row['job_id'];

            if (!array_key_exists($clientId,$tmpClients)) {
                $tmpClients[$clientId] = [
                    'id' => $clientId,
                    'name' => $row['client_name'],
                    'jobs' => []
                ];
            }

            if (!array_key_exists($jobId,$tmpClients[$clientId]['jobs'])) {
                $tmpClients[$clientId]['jobs'][$jobId] = [
                    'id' => $jobId,
                    'name' => $row['job_name']
                ];
            }
            
        }

        foreach ($tmpClients as &$t) {
            
            $tmpJobs = [];

            foreach ($t['jobs'] as $j) {
                $tmpJobs[] = $j;
            }

            $t['jobs'] = $tmpJobs;
            $clients[] = $t;
        }

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $schedules = [];

        foreach ($rows as &$row) {
            $scheduleId = $row['id'];
            $workdayId = $row['workday_id'];
            $start = $row['start'];
            $end = $row['end'];

            $row['prettyStartTime'] = date('g:i a', strtotime($row['time_start']));
            $row['prettyEndTime'] = date('g:i a', strtotime($row['time_end']));;

            $scheduleDays = [];
            $days = getWorkdays($this->Db,$workdayId,$start,$end,$history);
            $daysCnt = count($days);

            foreach ($days as $day) {
                $scheduleDays[$day] = [
                    'assigned' => 0,
                    'date' => $day,
                    'percentage' => 0,
                    'employees' => []
                ];
            }
            
            $assigned = 0;
            $assignedCnt = $daysCnt * $row['employee_cnt'];
            $row['daysCnt'] = $daysCnt;
            $row['daysToAssignCnt'] = $assignedCnt;         
            $row['assignment_status'] = 'pending';
            $row['totalWorkdays'] = count($days);

            $qry = "select s.id, s.name";
            $qry .= " from schedule_skills as ss";
            $qry .= " join skills s on s.id = ss.skill_id";
            $qry .= " where ss.schedule_id = ?";

            $skills = $this->Db->query($qry,[$scheduleId]);

            $row['skills'] = $skills;

            $qry = "SELECT sa.id as schedule_assignemt_id,sa.date";
            $qry .= " ,u.id as user_id,u.firstname,u.lastname,u.email,u.photo,u.status";
            $qry .= " ,IF(u.photo IS NULL,CONCAT('$avatarPath','/','$defaultAvatar'),CONCAT('$avatarPath','/',u.photo)) AS avatar";
            $qry .= " FROM schedule_assignments as sa";
            $qry .= " join users u on u.id = sa.user_id and u.status = 'active' and u.company_id = ?";
            $qry .= " where sa.schedule_id = ?";
            $qry .= " and sa.status = 'active';";
            $rows2 = $this->Db->query($qry,[$this->CompanyId,$scheduleId]);

            foreach ($rows2 as $row2) {
                $scheduleDate = $row2['date'];

                if (array_key_exists($scheduleDate,$scheduleDays)) {
                    $assigned++;
                    $scheduleDays[$scheduleDate]['assigned']++;
                    $scheduleDays[$scheduleDate]['employees'][] = $row2;
                    $scheduleDays[$scheduleDate]['percentage'] = assignedPercentage($scheduleDays[$scheduleDate]['assigned'],$daysCnt);
                }
            }

            $assignedPerc = assignedPercentage($assigned,$assignedCnt);

            $row['daysAssigned'] = $assigned;
            $row['assignedPerc'] = $assignedPerc;
            $row['scheduleDays'] = $scheduleDays;

            $canCancel = false;
            date_default_timezone_set($this->User['timezoneloc']);
            $now = date('Y-m-d');
            
            if ($end > $now) {
                $canCancel = true;
            }

            $row['canCancel'] = $canCancel;

        }

        $d = [
            'count' => $count,
            'clients' => $clients,
            'schedules' => $rows,
        ];

        return $d;
    }

    function create($data)
    {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => null
        ];

        $jobId = $data['jobId'];
        $start = $data['start'];
        $workdaysId = $data['workdaysId'];
        $end = (array_key_exists('end', $data)) ? $data['end'] : null;
        $startTime = $data['startTime'];
        $endTime = $data['endTime'];
        $employeeCnt = (array_key_exists('employeeCnt', $data)) ? $data['employeeCnt'] : 0;
        $skillIds = (array_key_exists('skillIds', $data)) ? $data['skillIds'] : [];
        $notes = (array_key_exists('notes', $data)) ? sanitizeForMySQL($data['notes']) : null;

        if ($employeeCnt < 0) {
            $res['status'] = 'error';
            $res['message'] = 'count cannot be less than 0';
            return $res;
        }

        if ($this->ClientId != null) {
            $clientId = $this->ClientId;
        } else {
            $clientId = (array_key_exists('clientId', $data) ? $data['clientId'] : null);
        }

        if ($clientId == null) {
            $res['status'] = 'error';
            $res['message'] = 'missing clientId';
            return $res;
        }

        $qry = "insert into schedules (`company_id`,`client_id`,`job_id`,`start`,`end`, `time_start`, `time_end`,`employee_cnt`, `notes`, `workday_id`) values (?,?,?,?,?,?,?,?,?,?);";
        $values = [$this->CompanyId, $clientId, $jobId, $start, $end, $startTime, $endTime, $employeeCnt, $notes, $workdaysId];

        $scheduleId = $this->Db->insert($qry, $values);

        $this->Skill->setSchedule($scheduleId, $skillIds);

        $res['data'] = [$scheduleId];

        return $res;
    }

    function fetch($data, $clientId = null)
    {
        $values = [$this->CompanyId, $data['id']];

        $qry = "SELECT s.*";
        $qry .= " ,j.name AS job_name";
        $qry .= " , c.name AS client_name";
        $qry .= " FROM schedules AS s";
        $qry .= " JOIN jobs AS j ON j.id = s.job_id";
        $qry .= " JOIN clients AS c ON c.id = j.client_id";
        $qry .= " WHERE j.company_id = ?";
        $qry .= " AND s.id = ?";
        $qry .= " AND j.status = 'active'";

        if ($clientId != null) {
            $qry .= " AND c.id = ?";
            $values[] = $clientId;
        }

        $rows = $this->Db->query($qry, $values);

        if (count($rows) > 0) {
            $rows[0]['assigned'] = 0;
            $rows[0]['assigned_status'] = 'pending';
        }

        $d = $rows;

        return $d;
    }

    function update($data)
    {
        $scheduleId = $data['id'];
        $employeeCnt = $data['employeeCnt'];
        $start = $data['start'];
        $end = $data['end'];
        $workdayId = $data['workdaysId'];
        $skillIds = $data['skillIds'];

        $qry = "update schedules set employee_cnt = ?, start = ?, end = ?, workday_id = ? where id = ? and company_id = ? and status = 'active'";
        $values = [$employeeCnt,$start,$end,$workdayId,$scheduleId,$this->CompanyId];
        $this->Db->update($qry,$values);

        $this->Skill->setSchedule($scheduleId, $skillIds);

        return null;
    }

    function pending($data)
    {
        $date = $data['today'];

        $wheres = [];
        $v = [$this->CompanyId,$date];

        $qryData = qryBuilder($data, 's', 'schedule');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 's.end desc');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "select s.id as schedule_id,s.client_id,s.job_id,s.start,s.end,s.employee_cnt";
        $qry .= ",c.name as client_name";
        $qry .= ",j.name as job_name";
        $qry .= " from schedules as s";
        $qry .= " join clients as c on c.id = s.client_id";
        $qry .= " join jobs as j on j.id = s.job_id";
        $qry .= " where s.company_id = ?";
        $qry .= " and s.end < ?";

        if ($this->ClientId != null){
            $v[] = $this->ClientId;
            $qry .= " and s.client_id = ?";
        }
        
        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND s.status = ?";
        } else {
            $qry .= " AND s.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $schedules = [];

        foreach ($rows as &$row) {
            $employeeCnt = $row['employee_cnt'];
            $days = [];
            $chk = $row['start'];
            $chkTs = strtotime($chk);
            $endTs = strtotime($row['end']);

            $cntr = 0;
            $totalToAssign = 0;
            $totalAssigned = 0;
            $totalDays = 0;

            while ($chkTs <= $endTs && $cntr < 365) {
                $cntr++;
                $day = date('Y-m-d', $chkTs);
                $days[$day] = ['filled' => 0, 'pending' => $employeeCnt];
                $totalToAssign += $employeeCnt;
                $totalDays++;
                $chkTs = strtotime($day . ' +1 day');
            }

            $scheduleId = $row['schedule_id'];
            $qry = "select * from schedule_assignments where schedule_id = ? and status = 'active';";
            $rows2 = $this->Db->query($qry,[$scheduleId]);
            foreach ($rows2 as $row2) {
                if (array_key_exists($day,$days)) {
                    $day = $row2['date'];
                    $totalAssigned++;
                    $days[$day]['filled']++;
                    $days[$day]['pending']--;
                }
            }
            
            $row['totalDays'] = $totalDays;
            $row['requested'] = $totalToAssign;
            $row['assigned'] = $totalAssigned;
            $row['assignment_status'] = 'pending';
            $row['days'] = $days;
        }

        $d = [
            'count' => $count,
            'schedules' => $rows,
        ];

        return $d;
    }

    function status($data)
    {

        $clientId = $this->ClientId;

        if ($clientId == null) {
            $clientId = array_key_exists('clientId', $data) ? $data['clientId'] : null;
        }

        $jobId = array_key_exists('jobId',$data) ? $data['jobId'] : null;
        $scheduleId = array_key_exists('scheduleId',$data) ? $data['scheduleId'] : null;
        $endBefore = array_key_exists('endBefore',$data) ? $data['endBefore'] : null;
        $startOnAfter = array_key_exists('startOnAfter',$data) ? $data['startOnAfter'] : null;
        $startAfter = array_key_exists('startAfter',$data) ? $data['startAfter'] : null;
        $upcoming = array_key_exists('upcoming',$data) && strtolower($data['upcoming'])  == 'yes' ? true : false;
        $history = array_key_exists('history',$data) && strtolower($data['history'])  == 'yes' ? true : false;
        
        if ($upcoming) {
            date_default_timezone_set($this->User['timezoneloc']);
            $startAfter = date('Y-m-d');
        }
        
        $values = [$this->CompanyId];
        
        $qry = "select s.*";
        $qry .= " from schedules as s";
        $qry .= " join clients as c on c.id = s.client_id and c.status = 'active'";
        $qry .= " join jobs as j on j.id = s.job_id and j.status = 'active'";
        $qry .= " where s.company_id = ?";
        $qry .= " and s.status = 'active'";

        if ($clientId != null) {
            $values[] = $clientId;
            $qry .= " and s.client_id = ?";
        }

        if ($jobId != null) {
            $values[] = $jobId;
            $qry .= " and s.job_id = ?";
        }

        if ($scheduleId != null) {
            $values[] = $scheduleId;
            $qry .= " and s.id = ?";
        }

        if ($endBefore != null) {
            $values[] = $endBefore;
            $qry .= " and s.end < ?";
        }

        if ($startOnAfter != null) {
            $values[] = $startOnAfter;
            $qry .= " and s.start >= ?";
        }

        if ($startAfter != null) {
            $values[] = $startAfter;
            $qry .= " and s.start > ?";
        }

        $scheduleIds = [];
        $days = [];
        $totalFilled = 0;
        $totalDays = 0;
        $filledPerc = 0;
        $employeeIds = [];
        $workDaysCnt = 0;
        $scheduleEmployeeCnt = 0;

        $rows = $this->Db->query($qry, $values);

        foreach ($rows as $row) {
            $scheduleId = $row['id'];
            $workdayId = $row['workday_id'];
            $start = $row['start'];
            $end = $row['end'];
            $eCnt = $row['employee_cnt'];
            $scheduleEmployeeCnt += $eCnt;

            $scheduleIds[] = $scheduleId;

            $r = getWorkdays($this->Db,$workdayId,$start,$end,$history);
            $totalDays += count($r)*$eCnt;
            
            $days = array_merge($days,$r);
        }

        $workDaysCnt = count($days);

        if (count($scheduleIds) > 0 && count($days) > 0) {

            $days = array_unique($days);

            $scheduleIdStr = implode(',',$scheduleIds);
            $dayStr = "'".implode("','",$days)."'";

            $qry = "select user_id from schedule_assignments where schedule_id in ($scheduleIdStr) and date in ($dayStr) and status = 'active';";

            $rows2 = $this->Db->query($qry,[]);

            foreach ($rows2 as $row2) {
                $userId = $row2['user_id'];

                if (!in_array($userId,$employeeIds)) {
                    $employeeIds[] = $userId;
                }
            }
            $totalFilled += count($rows2);

            $filledPerc = assignedPercentage($totalFilled,$totalDays);

        }

        $d = [
            'scheduleEmployeeCnt' => $scheduleEmployeeCnt,
            'days' => $totalDays,
            'daysFilled' => $totalFilled,
            'filledPerc' => $filledPerc,
            'employeeCnt' => count($employeeIds),
            'workDaysCnt' => $workDaysCnt
        ];

        return $d;
    }

    function assignment($data) {
        $scheduleId = $data['scheduleId'];
        $nDay = array_key_exists('day',$data) ? $data['day'] : null;
        $firstDayOfWeek = null;
        $lastDayOfWeek = null;

        $d = [
            'scheduleId' => $scheduleId,
            'weeks' => null,
            'currentWeek' => null,
            'scheduleStart' => null,
            'scheduleEnd' => null,
            'today' => null,
            'daysCnt' => 0,
            'days' => []
        ];

        $scheduleId = $data['scheduleId'];

        //// Get week count
        $qry = "select * from schedules where id = ? and company_id = ? and status != 'deleted';";
        $rows = $this->Db->query($qry, [$scheduleId,$this->CompanyId]);

        if (count($rows) < 1) {
            return $d;
        }

        $employeeCnt = $rows[0]['employee_cnt'];
        $workdayId = $rows[0]['workday_id'];
        $d['scheduleStart'] = $scheduleStart = $rows[0]['start'];
        $d['scheduleEnd'] = $scheduleEnd = $rows[0]['end'];

        $daysList = getWorkdays($this->Db,$workdayId,$scheduleStart,$scheduleEnd,true);
        $daysListCnt = count($daysList);
        $d['daysCnt'] = $daysListCnt;

        date_default_timezone_set($this->User['timezoneloc']);

        if ($nDay == null) {
            $nDay = date('Y-m-d');
            $d['today'] = $nDay;
        }
    
        $nDayTs = strtotime($nDay);
        $startTs = strtotime($scheduleStart);
        $endTs = strtotime($scheduleEnd);

        $this->Logger->info("todayTs: $nDayTs startTs: $startTs endTs: $endTs");
        $this->Logger->info("daysList: ".print_r($daysList,true));

        //// Need to find which monday to use for selected weeks
        $selectedMonday = null;
        $chkDayNo = null;
        if ($daysListCnt > 7) {
            if ($nDayTs >= $startTs && $nDayTs <= $endTs) {
                //// Current week is in schedule
                $chkDayNo = date('N',$nDayTs);
                $dayOffset = '-'.($chkDayNo - 1).' day';
                $firstDayOfWeek = $selectedMonday = date('Y-m-d',strtotime($dayOffset,$nDayTs));
                $dayOffset = '+'.(7 - $chkDayNo).' day';
                $lastDayOfWeek = date('Y-m-d',strtotime($dayOffset,$nDayTs));
            } elseif ($nDayTs > $startTs) {
                //// Schedule ended
                $chkDayNo = date('N',$endTs);
                $dayOffset = '-'.($chkDayNo - 1).' day';
                $firstDayOfWeek = $selectedMonday = date('Y-m-d',strtotime($dayOffset,$endTs));
                $dayOffset = '+'.(7 - $chkDayNo).' day';
                $lastDayOfWeek = date('Y-m-d',strtotime($dayOffset,$endTs));
                
            } else {
                //// Schedule hasn't started yet
                $chkDayNo = date('N',$startTs);
                $dayOffset = '-'.($chkDayNo - 1).' day';
                $firstDayOfWeek = $selectedMonday = date('Y-m-d',strtotime($dayOffset,$startTs));
                $dayOffset = '+'.(7 - $chkDayNo).' day';
                $lastDayOfWeek = date('Y-m-d',strtotime($dayOffset,$startTs));
            }
        } else {
            $firstDayOfWeek = $selectedMonday = date('Y-m-d',$startTs);
            $lastDayOfWeek = date('Y-m-d',$endTs);
        }

        $currentWeek = null;
 
        $days = [];
        $sTs = strtotime($firstDayOfWeek);
        $eTs = strtotime($lastDayOfWeek);
        $mTs = strtotime($selectedMonday);

        $tmpFdow = [];
        $weeks = [];

        $cntr = 1;
        foreach ($daysList as $day) {
            $dTs = strtotime($day);
            
            if ($daysListCnt > 7) {
                $chkDayNo = date('N',$dTs);
                $dayOffset = '-'.($chkDayNo - 1).' day';
                $firstDayOfWeek = date('Y-m-d',strtotime($dayOffset,$dTs));
                $dayOffset = '+'.(7 - $chkDayNo).' day';
                $lastDayOfWeek = date('Y-m-d',strtotime($dayOffset,$dTs));

                if (!in_array($firstDayOfWeek,$tmpFdow)) {
                    $tmpFdow[] = $firstDayOfWeek;
                    $tmp = [
                        'first' => $firstDayOfWeek,
                        'last' => $lastDayOfWeek,
                    ];

                    $weeks[$cntr] = $tmp;

                    if ($mTs == strtotime($firstDayOfWeek)) {
                        $currentWeek = $cntr;
                    }

                    $cntr++;
                }

            }

            $this->Logger->info("day: ".date('Y-m-d',$dTs)." start: ".date('Y-m-d',$sTs)." end: ".date('Y-m-d',$eTs));
                      
            if ($dTs >= $sTs && $dTs <= $eTs) {
                $tmp = [
                    'day' => $day,
                    'employeeCnt' => 0,
                    'filledStatus' => 'none',
                    'employees' => []
                ];
                $days[$day] = $tmp;
            }
        }

        $d['employeeCnt'] = $employeeCnt;
        $d['currentWeek'] = $currentWeek;
        $d['weeks'] = $weeks;

        $daysArr = array_keys($days);

        if (count($daysArr) > 0) {
            $str = "'".implode("','",$daysArr)."'";

            $qry = "select sa.date";
            $qry .= " ,u.id as user_id,u.firstname,u.lastname,u.photo";
            $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
            $qry .= " from schedule_assignments as sa";
            $qry .= " join users as u on u.id = sa.user_id and u.status = 'active' and u.company_id = ?";
            $qry .= " where sa.schedule_id = ?";
            $qry .= " and sa.date in ($str)";
            $qry .= " and sa.status = 'active';";
            
            $rows = $this->Db->query($qry,[$this->CompanyId,$scheduleId]);

            foreach ($rows as $row) {
                $day = $row['date'];
                if (array_key_exists($day,$days)) {
                    $days[$day]['employees'][] = $row;
                    $days[$day]['employeeCnt']++;

                    if ($days[$day]['employeeCnt'] == $employeeCnt) {
                        $days[$day]['filledStatus'] = 'filled';
                    } else {
                        $days[$day]['filledStatus'] = 'partial';
                    }
                }


            }

        }

        $d['days'] = $days;
        return $d;
    }

    function assignments($data){
        $scheduleId = $data['scheduleId'];

        $wheres = [];
        $v = [$this->CompanyId,$scheduleId,$this->CompanyId];

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "select sa.user_id";
        $qry .= " ,u.id as user_id,u.firstname, u.lastname ";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " from schedule_assignments sa";
        $qry .= " join users u on u.id = sa.user_id and u.company_id = ?";
        $qry .= " join schedules s on s.id = sa.schedule_id and s.status = 'active'";
        $qry .= " where sa.schedule_id = ?";
        $qry .= " and s.company_id = ?";
        $qry .= " AND u.identity_id = 3";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND sa.status = ?";
        } else {
            $qry .= " AND sa.status = 'active'";
        }

        $qry .= " group by sa.user_id";

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        foreach ($rows as &$row) {
            $userId = $row['user_id'];
            list($x,$y) = $this->Employee->scheduleStatus($userId,$scheduleId);
            $row['filled'] = $x;
            $row['totalDays'] = $y;
            list($x,$y) = $this->Employee->remainingcheduleStatus($userId,$scheduleId);
            $row['remainingFilled'] = $x;
            $row['remainingDays'] = $y;
       }

        $d = [
            'count' => $count,
            'employees' => $rows,
        ];

        return $d;
    }

    function days($data) {
        $d = [
            'start' => null,
            'workDays' => [],
            'workDaysCnt' => 0
        ];

        $scheduleId = $data['scheduleId'];
        $history = array_key_exists('history',$data) && strtolower($data['history'])  == 'yes' ? true : false;
        $missing = array_key_exists('missing',$data) && strtolower($data['missing'])  == 'yes' ? true : false;
        $filled = array_key_exists('filled',$data) && strtolower($data['filled'])  == 'yes' ? true : false;
        $start = array_key_exists('start',$data) ? $data['start'] : null;

        $d['start'] = $start;
        $v = [$this->CompanyId];
        $qry = "select s.id,s.workday_id, s.start, s.end, s.employee_cnt";
        $qry .= " from schedules s";
        $qry .= " where s.status = 'active'";
        $qry .= " and s.company_id = ?";

        if ($scheduleId != null) {
            $v[] = $scheduleId;
            $qry .= " and s.id = ?";
        }

        $rows = $this->Db->query($qry,$v);

        if (count($rows) < 1) {
            return $d;
        }

        if ($start == null) {
            $start = $rows[0]['start'];
        }

        $end = $rows[0]['end'];
        $workdayId = $rows[0]['workday_id'];
        $employeeCnt = $rows[0]['employee_cnt'];
        $workDays = getWorkdays($this->Db,$workdayId,$start,$end,$history);
        
        foreach ($workDays as $day) {
            $qry = "select *";
            $qry .= " from schedule_assignments sa";
            $qry .= " join users u on u.id = sa.user_id and u.status = 'active' and u.company_id = ?";
            $qry .= " where sa.date = ?";
            $qry .= " and sa.schedule_id = ?";
            $qry .= " and sa.status = 'active'";

            $rows = $this->Db->query($qry,[$this->CompanyId,$day,$scheduleId]);
            $filledCnt = count($rows);

            $tmp = [
                'filled' => $filledCnt,
                'total' => $employeeCnt,
                'percentage' => assignedPercentage($filledCnt,$employeeCnt)
            ];

            if ($missing && $filledCnt < $employeeCnt) {
                $d['workDays'][$day] = $tmp;
                $d['workDaysCnt']++;
            } elseif ($filled && $filledCnt >= $employeeCnt) {
                $d['workDays'][$day] = $tmp;
                $d['workDaysCnt']++;
            } elseif(!$missing && !$filled) {
                $d['workDays'][$day] = $tmp;
                $d['workDaysCnt']++;
            }
            
        }

        $d['days'] = $rows;
        
        return $d;
    }

    function unFilledScheduleDays($scheduleId,$history) {
        $d = [];
        $qry = "select employee_cnt,workday_id,start,end from schedules where id = ? and company_id = ? and status = 'active'";
        $rows = $this->Db->query($qry,[$scheduleId,$this->CompanyId]);

        if (count($rows) < 1) {
            $this->Logger->info("no schedule");
            return $d;
        }

        $employeeCnt = $rows[0]['employee_cnt'];
        $workdayId = $rows[0]['workday_id'];
        $start = $rows[0]['start'];
        $end = $rows[0]['end'];

        $workdays = getWorkdays($this->Db,$workdayId,$start,$end,$history);

        if (count($workdays) < 1) {
            $this->Logger->info("returning with no workdays");
            return $d;
        }

        $daysStr = "'".implode("','",$workdays)."'";

        $qry = "select date,count(date) as count from schedule_assignments where date in ($daysStr) and schedule_id = ? and status = 'active' group by date order by date asc";
        $rows = $this->Db->query($qry,[$scheduleId]);

        foreach ($rows as $row) {
            if ($row['count'] >= $employeeCnt) {
                $workdays = array_diff($workdays,[$row['date']]);
            }
        }

        $d = [];

        foreach ($workdays as $w){
            $d[] = $w;
        }

        return $d;
    }

    function deleteScheduleAssignment($data) {
        foreach($data['assignments'] as $assignment) {
            $userId = $assignment['userId'];
            $scheduleId = $assignment['scheduleId'];

            if (!$this->canSchedule($scheduleId)) { 
                $this->Db->setErrrors('no access schedule');
                return 'no access schedule';
            }

            foreach($assignment['days'] as $day) {
                $qry = "update schedule_assignments set modified = now(), status = 'deleted' where schedule_id = ? and user_id = ? and date = ?;";
                $this->Db->update($qry,[$scheduleId,$userId,$day]);
                
            }
        }
    }

    function getUpdate($data){
        $scheduleId = $data['scheduleId'];

        $d = [
            'employeeCnt' => null,
            'start' => null,
            'end' => null,
            'workdays' => [],
            'skills' => [],
            'employeeCntMin' => 1,
            'hasScheduledEmployees' => false,
            'maxStartDate' => null,
            'minEndDate' => null
        ];

        //// Get schedule data
        $qry = "select s.id,s.start,s.end,s.employee_cnt";
        $qry .= ",sk.id as skill_id,sk.name as skill_name";
        $qry .= ",w.id as workday_id,w.name as workday_name";
        $qry .= " from schedules as s";
        $qry .= " join schedule_skills ss on ss.schedule_id = s.id";
        $qry .= " join skills as sk on sk.id = ss.skill_id";
        $qry .= " join workdays as w on w.id = s.workday_id";
        $qry .= " where s.id = ?";
        $qry .= " and s.company_id = ?";
        $qry .= " and s.status = 'active'";

        $rows = $this->Db->query($qry,[$scheduleId,$this->CompanyId]);

        if (count($rows) < 1){
            return $d;
        }

        $d['employeeCnt'] = $rows[0]['employee_cnt'];
        $d['start'] = $rows[0]['start'];
        $d['end'] = $rows[0]['end'];

        $workdayIds = [];
        $skillIds = [];

        foreach ($rows as $row) {
            $workdayId = $row['workday_id'];
            $skillId = $row['skill_id'];

            if (!in_array($workdayId,$workdayIds)) {
                $workdayIds[] = $workdayId;
                $d['workdays'][] = ['id' => $workdayId,'name' => $row['workday_name']];
            }

            if (!in_array($skillId,$skillIds)) {
                $skillIds[] = $skillId;
                $d['skills'][] = ['id' => $skillId, 'name' => $row['skill_name']];
            }
        }

        $hasScheduleEmployees = false;
        $maxStartDate = null;
        $minEndDate = null;

        //// Get minimum employee count
        $qry = "select date,count(date) as count from schedule_assignments where schedule_id = ? and status = 'active' group by date order by count desc";
        $rows = $this->Db->query($qry,[$scheduleId]);
        if (count($rows) > 0) {
            $d['employeeCntMin'] = $rows[0]['count'];
            $hasScheduleEmployees = true;
        }

        foreach ($rows as $row) {
            $dt = $row['date'];
            $dTs = strtotime($dt);
            if ($maxStartDate == null) {
                $maxStartDate = $dt;
            } elseif (strtotime($maxStartDate) > $dTs) {
                $maxStartDate = $dt;
            }
            if ($minEndDate == null) {
                $minEndDate = $dt;
            } elseif (strtotime($minEndDate) < $dTs) {
                $minEndDate = $dt;
            }
        }

        $d['hasScheduledEmployees'] = $hasScheduleEmployees;
        $d['maxStartDate'] = $maxStartDate;
        $d['minEndDate'] = $minEndDate;
        return $d;
    }

    function delete($data) {
        $scheduleId = $data['id'];

        if (!$this->canSchedule($scheduleId)) {
            return null;
        }

        $qry = "update schedule_assignments set status = 'deleted', modified = now() where schedule_id = ? and status = 'active';";
        $this->Db->update($qry,[$scheduleId]);

        $qry = "update schedules set status = 'deleted', modified = now() where id = ? and status = 'active';";
        $this->Db->update($qry,[$scheduleId]);

    }

    function reportData($data) {
        $d = [
            'attenion' => [],
            'daysList' => [],
            'days' => [],
            'requested' => 0,
            'filled' => 0,
            'requestedList' => [],
            'filledList' => [],
            'maxRequested' => 0
        ];

        $start = $data['start'];
        $end = $data['end'];

        $chk = $start;
        $chkTs = strtotime($chk);
        $endTs = strtotime($end);
        $cntr = 0;

        $daysList = [];
        $days = [];
        $scheduleWorkdays = [];
        $maxReq = 0;

        while ($chkTs <= $endTs && $cntr < 365) {
            $cntr++;
            $day = date('Y-m-d', $chkTs);

            $qry = "select sa.date";
            $qry .= ",s.id as schedule_id,s.employee_cnt as requested";
            $qry .= " from schedules s";
            $qry .= " left join schedule_assignments sa on s.id = sa.schedule_id and sa.status = 'active' and sa.date = ?";
            $qry .= " where (s.start <= ? and s.end >= ?)";
            $qry .= " and s.company_id = ?";
            $scheduleIds = [];
            $requestedCnt = 0;
            $filledCnt = 0;

            $rows = $this->Db->query($qry,[$day,$day,$day,$this->CompanyId]);

            foreach ($rows as $row) {
                $scheduleId = $row['schedule_id'];
                $requested = $row['requested'];

                if (!in_array($scheduleId,$scheduleIds)) {
                    $workdays = getWorkdays($this->Db,null,null,null,true,$scheduleId);
                    
                    $scheduleIds[] = $scheduleId;

                    if (in_array($day,$workdays)) {
                        $requestedCnt += $requested;
                    }
                }

                if ($row['date'] != null) {
                    $filledCnt++;
                }
                $days[] = $row;
            }

            $d['requested'] += $requestedCnt;
            $d['filled'] += $filledCnt;
            $d['requestedList'][] = $requestedCnt;
            $d['filledList'][] = $filledCnt;
            $daysList[] = $day;

            if ($requestedCnt > $maxReq) {
                $maxReq = $requestedCnt;
            }

            $chkTs = strtotime($day . ' +1 day');
        }
        $d['maxRequested'] = $maxReq;
        $d['daysList'] = $daysList;
        $d['days'] = $days;
        return $d;
    }

    function clientReportByDay($data, $clientId=null) {
        $d = [
            'count' => 0,
            'clients' => [],
            'requested' => 0,
            'filled' => 0,
            'clientList' => [],
            'requestedList' => [],
            'filledList' => [],
            'maxRequested' => 0
        ];


        date_default_timezone_set($this->User['timezoneloc']);
        $now = date('Y-m-d');

        $day = array_key_exists('day', $data) ? $data['day'] : $now;

        $v = [$this->CompanyId];

        $qry = "SELECT c.id,c.name";
        $qry .= ",group_concat(s.id) as schedule_ids";
        $qry .= " FROM clients c";
        $qry .= " join schedules s on s.client_id = c.id and s.status = 'active'";
        $qry .= " where s.company_id = ?";

        if ($clientId != null) {
            $qry .= " and c.id = ?";
            $v[] = $clientId;
        }

        $qry .= " and (";
        $qry .= " (s.start <= ? and s.end >= ?)";
        $qry .= " or (s.start >= ? and s.start <= ?)";
        $qry .= " or (s.end >= ? and s.end <= ?)";
        $qry .= " )";
        
        $v = array_merge($v, [$day,$day,$day,$day,$day,$day]);
        $qryData = qryBuilder($data, 'c', 'client');
        
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'c.name asc');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND c.status = ?";
        } else {
            $qry .= " AND c.status = 'active'";
        }

        $qry .= " group by c.id";

        $rows = $this->Db->query($qry, $values);
        $count = count($rows);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";
        
        $rows = $this->Db->query($qry, $values);
        foreach ($rows as &$row){
            
            $scheduleIds = $row['schedule_ids'];
  
            $qry = "select id,workday_id, employee_cnt from schedules where id in ($scheduleIds)";
            $rows2 = $this->Db->query($qry,[]);
            $requested = 0;
            $filled = 0;

            foreach ($rows2 as $row2){
                $scheduleId = $row2['id'];
                $workdays = getWorkdays($this->Db,$row2['workday_id'],$day,$day);

                if (in_array($day, $workdays)){
                    $requested += $row2['employee_cnt'];

                    $qry = "select id from schedule_assignments where schedule_id = ? and date = ? and status = 'active'";
                    $rows3 = $this->Db->query($qry,[$scheduleId,$day]);
                    $filled += count($rows3);
                } 
            }

            $d['clientList'][] = $row['name'];
            $d['requestedList'][] = $requested;
            $d['filledList'][] = $filled;
            $d['requested'] += $requested;

            if ($requested > $d['maxRequested']) {
                $d['maxRequested'] = $requested;
            }
        }
        
        $d['count'] = $count;
        $d['clients'] = $rows;

        return $d;
    }

    function scheduleStatusByRange($data,$clientId=null){
        $d = [
            'daysList' => [],
            'days' => [],
            'requested' => 0,
            'filled' => 0,
            'requestedList' => [],
            'filledList' => [],
            'maxRequested' => 0
        ];
        $requested = 0;
        $filled = 0;
        $maxRequested = 0;
        $daysList = [];
        $requestedList = [];
        $filledList = [];

        date_default_timezone_set($this->User['timezoneloc']);
        $now = date('Y-m-d');

        $start = array_key_exists('start',$data) ? $data['start'] : $now;
        $end = array_key_exists('end', $data) ? $data['end'] : $now;

        //// Get all schedules in date range
        $values = [$this->CompanyId];

        $qry = "select s.id as schedule_id, s.job_id, s.workday_id, s.start, s.end,s.employee_cnt";
        $qry .= " , j.client_id,j.name as job_name";
        $qry .= " , c.name as client_name";
        $qry .= " from schedules s";
        $qry .= " join jobs j on j.id = s.job_id and j.status = 'active'";
        $qry .= " join clients c on c.id = j.client_id and c.status = 'active'";
        $qry .= " where s.company_id = ?";

        if ($clientId != null) {
            $qry .= " and c.id = ?";
            $values[] = $clientId;
        }
        $qry .= " and (";
        $qry .= " (s.start <= ? and s.end >= ?)";
        $qry .= " or (s.start >= ? and s.start <= ?)";
        $qry .= " or (s.end >= ? and s.end <= ?)";
        $qry .= " )";
        $qry .= " and s.status = 'active'";

        $values = array_merge($values,[$start,$end,$start,$end,$start,$end]);

        $rows = $this->Db->query($qry,$values);

        $workdaysList = [];

        $chk = $start;
        $chkTs = strtotime($chk);
        $endTs = strtotime($end);
        $cntr = 0;


        while ($chkTs <= $endTs && $cntr < 365) {
            $cntr++;
            $day = date('Y-m-d', $chkTs);
            $daysList[] = $day;
            $request = 0;
            $fill = 0;
            //// Get schedules that fall on $day
            foreach ($rows as $row) {
                $scheduleId = $row['schedule_id'];
                $scheduleStartTs = strtotime($row['start']);
                $schedueleEndTs = strtotime($row['end']);
                $workdayId = $row['workday_id'];
                $employeeCnt = $row['employee_cnt'];

                $this->Logger->info("++++ scheduleId: $row[schedule_id] day: $day workdayId: $workdayId employeeCnt: $employeeCnt");

                if ($chkTs >= $scheduleStartTs && $chkTs <= $schedueleEndTs) { 
                    if (!in_array($workdayId,$workdaysList)) {
                        $workdays = getWorkdays($this->Db,$workdayId,$start,$end);
                        $workdaysList[$workdayId] = $workdays;
                    }
                    
                    if (in_array($day,$workdaysList[$workdayId])) {
                        $this->Logger->info("++++ adding employee cnt");
                        $request += $employeeCnt;

                        //// Now get the filled requests for the day
                        $qry = "select * from schedule_assignments where schedule_id = ? and date = ? and status = 'active'";
                        $rows2 = $this->Db->query($qry, [$scheduleId, $day]);
                        $fill += count($rows2);
                    }

                }
            }

            if ($request > $maxRequested) {
                $maxRequested = $request;
            }

            $requested += $request;
            $filled += $fill;

            $requestedList[] = $request;
            $filledList[] = $fill;

            $chkTs = strtotime($day . ' +1 day');
        }

        $d['requested'] = $requested;
        $d['filled'] = $filled;
        $d['maxRequested'] = $maxRequested;
        $d['daysList'] = $daysList;
        $d['requestedList'] = $requestedList;
        $d['filledList'] = $filledList;

        return $d;
    }

    function jobReportByDay($data, $clientId=null) {
        $d = [
            'count' => 0,
            'jobs' => [],
            'requested' => 0,
            'filled' => 0,
            'jobList' => [],
            'requestedList' => [],
            'filledList' => [],
            'maxRequested' => 0
        ];


        date_default_timezone_set($this->User['timezoneloc']);
        $now = date('Y-m-d');

        $day = array_key_exists('day', $data) ? $data['day'] : $now;

        $v = [$this->CompanyId];

        $qry = "select j.id as job_id, j.name as job_name,group_concat(s.id) as schedule_ids ";
        $qry .= " from jobs j";
        $qry .= " join schedules s on s.job_id = j.id and s.status = 'active'";
        $qry .= " where j.company_id = ?";

        if ($clientId != null) {
            $qry .= " and j.client_id = ?";
            $v[] = $clientId;
        }
        
        $qry .= " and ( (s.start <= ? and s.end >= ?) ";
        $qry .= " or (s.start >= ? and s.start <= ?) ";
        $qry .= " or (s.end >= ? and s.end <= ?) ) ";
        
        $v = array_merge($v, [$day,$day,$day,$day,$day,$day]);
        $qryData = qryBuilder($data, 'j', 'j');
        
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'j.name asc');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND j.status = ?";
        } else {
            $qry .= " AND j.status = 'active'";
        }

        $qry .= " group by j.id";

        $rows = $this->Db->query($qry, $values);
        $count = count($rows);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";
        
        $rows = $this->Db->query($qry, $values);
        foreach ($rows as &$row){
            
            $scheduleIds = $row['schedule_ids'];
  
            $qry = "select id,workday_id, employee_cnt from schedules where id in ($scheduleIds)";
            $rows2 = $this->Db->query($qry,[]);
            $requested = 0;
            $filled = 0;

            foreach ($rows2 as $row2){
                $scheduleId = $row2['id'];
                $workdays = getWorkdays($this->Db,$row2['workday_id'],$day,$day);

                if (in_array($day, $workdays)){
                    $requested += $row2['employee_cnt'];

                    $qry = "select id from schedule_assignments where schedule_id = ? and date = ? and status = 'active'";
                    $rows3 = $this->Db->query($qry,[$scheduleId,$day]);
                    $filled += count($rows3);
                } 
            }

            $d['jobList'][] = $row['job_name'];
            $d['requestedList'][] = $requested;
            $d['filledList'][] = $filled;
            $d['requested'] += $requested;

            if ($requested > $d['maxRequested']) {
                $d['maxRequested'] = $requested;
            }
        }
        
        $d['count'] = $count;
        $d['jobs'] = $rows;

        return $d;
    }

    function getNote($data) {
        $scheduleId = $data['id'];
        $qry = "select id, notes from schedules where id = ? and status != 'deleted' and company_id = ?;";
        $values = [$scheduleId, $this->CompanyId];

        return $this->Db->query($qry,$values);
    }

    function updateNote($data){
        $scheduleId = $data['id'];
        $notes = array_key_exists('notes', $data) && trim($data['notes']) != '' ? trim($data['notes']) : null;

        $qry = "update schedules set notes = ?, modified = now() where id = ? and company_id = ?;";
        $values = [$notes, $scheduleId, $this->CompanyId];

        $this->Db->update($qry,$values);

        return null;
    }

}
