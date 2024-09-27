<?php
/**
*
*/
class NotificationModel
{
	var $Logger;
    var $Db;
    var $CompanyId;

	function __construct($db,$logger,$companyId)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->CompanyId = $companyId;
	}

    function list($data,$whch=null) {
        $which = ($whch != null) ? $whch : null;

        if ($which == null) {
            $which = (array_key_exists('which',$data)) ? $data['which'] : 'company';
        }

        $qry = "select n.id, n.notification_type, n.name";
        if ($which == 'company') {
            $qry .= ",cn.id as company_notification_id";
        } elseif ($which == 'employee') {
            $qry .= ",en.id as employee_notification_id";
        }
        $qry .= " from notifications n";
        if ($which == 'company') {
            $qry .= " left join company_notifications cn on cn.notification_id = n.id and cn.status = 'active'";
        } elseif ($which == 'employee') {
            $qry .= " left join employee_notifications en on en.notification_id = n.id and en.status = 'active'";
        }
        $qry .= " where n.status = 'active'";
        $qry .= " order by n.id asc;";
        return [
            'notifications' => $this->Db->query($qry,[])
        ];
    }

    function companyToggle($data) {
        $notificationId = $data['notificationId'];
        $isOn = (strtolower($data['toggle']) == 'yes') ? true : false;

        $companyNotificationId = null;
        $companyNotificationStatus = 'active';

        $qry = "select id from notifications where id = ? and status = 'active';";
        $rows = $this->Db->query($qry,[$notificationId]);

        if (count($rows) < 1) {
            $this->Logger->info("invalid notification id");
            return null;
        }

        $qry = "select * from company_notifications where company_id = ? and notification_id = ?";
        $rows = $this->Db->query($qry,[$this->CompanyId,$notificationId]);
        
        if (count($rows) > 0) {
            $companyNotificationId = $rows[0]['id'];
        }

        if (!$isOn) {
            $companyNotificationStatus = 'deleted';
        }

        if ($companyNotificationId) {
            $qry = "update company_notifications set status = ?, modified = now() where id = ?;";
            $this->Db->update($qry,[$companyNotificationStatus,$companyNotificationId]);
        } else {
            $qry = "insert into company_notifications (company_id,notification_id) values (?,?);";
            $this->Db->insert($qry,[$this->CompanyId,$notificationId]);
        }

        return null;
    }

    function employeeToggle($data,$emplyId=null) {
        $notificationId = $data['notificationId'];
        $employeeId = ($emplyId != null) ? $emplyId : null;

        if ($employeeId == null) {
            $employeeId = (array_key_exists('employeeId',$data)) ? $data['employeeId'] : null;
        }

        if ($employeeId == null) {
            $this->Logger->info("missing employeeId");
            return null;
        }

        //// Make sure employee belongs to company
        $qry = "select id from users where id = ? and company_id = ? and identity_id = 3 and status = 'active';";
        $rows = $this->Db->query($qry,[$employeeId,$this->CompanyId]);

        if (count($rows) < 1) {
            $this->Logger->info("invalid user id");
            return false;
        }
        $isOn = (strtolower($data['toggle']) == 'yes') ? true : false;

        $employeeNotificationId = null;
        $employeeNotificationStatus = 'active';

        $qry = "select id from notifications where id = ? and status = 'active';";
        $rows = $this->Db->query($qry,[$notificationId]);

        if (count($rows) < 1) {
            $this->Logger->info("invalid notification id");
            return null;
        }

        $qry = "select * from employee_notifications where user_id = ? and notification_id = ?";
        $rows = $this->Db->query($qry,[$employeeId,$notificationId]);
        
        if (count($rows) > 0) {
            $employeeNotificationId = $rows[0]['id'];
        }

        if (!$isOn) {
            $employeeNotificationStatus = 'deleted';
        }

        if ($employeeNotificationId) {
            $qry = "update employee_notifications set status = ?, modified = now() where id = ?;";
            $this->Db->update($qry,[$employeeNotificationStatus,$employeeNotificationId]);
        } else {
            $qry = "insert into employee_notifications (user_id,notification_id) values (?,?);";
            $this->Db->insert($qry,[$employeeId,$notificationId]);
        }

        return null;
    }

	// function list($data){
	// 	$wheres = [];
    //     $v = [$this->CompanyId];

    //     $qryData = qryBuilder($data, 's', 'skill');

    //     $offset = $qryData['offset'] * $qryData['limit'];
    //     $wheres = $qryData['wheres'];
    //     $separator = $qryData['separator'];
    //     $values = array_merge($v, $qryData['values']);
    //     $orderBy = ($qryData['order'] != null ? $qryData['order'] : 's.name ASC');
    //     $status = ($qryData['status'] != null ? $qryData['status'] : null);

    //     $qry = "SELECT s.*";
    //     $qry .= " FROM skills AS s";
    //     $qry .= " WHERE s.company_id = ?";

    //     if (count($wheres) > 0) {
    //         $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
    //     }

    //     if ($status != null) {
    //         $values = array_merge($values, [$status]);
    //         $qry .= " AND s.status = ?";
    //     } else {
    //         $qry .= " AND s.status = 'active'";
    //     }

    //     $c = $this->Db->query($qry, $values);
    //     $count = count($c);

    //     $qry .= " ORDER BY $orderBy";
    //     $qry .= " LIMIT $qryData[limit]";
    //     $qry .= " OFFSET $qryData[offset];";

    //     $rows = $this->Db->query($qry, $values);

    //     $d = [
    //         'count' => $count,
    //         'skills' => $rows,
    //     ];

    //     return $d;
	// }

    // function create($data)
    // {
    //     $res = [
    //         'status' => 'ok',
    //         'message' => null,
    //         'data' => null
    //     ];

    //     $name = trim($data['name']);

    //     if (!$this->isFieldValueUnique('name', $name)) {
    //         $res['status'] = 'error';
    //         $res['message'] =  "Skill alreay exists";
    //         return $res;
    //     }

    //     $values = [$this->CompanyId, $name];
    //     $qry = "insert into skills (`company_id`,`name`) VALUES (?,?)";

    //     $skillId = $this->Db->insert($qry, $values);

    //     $res['data'] = [$skillId];

    //     return $res;
    // }

    // function delete($id) {
    //     $qry = "update skills set status = 'deleted', modified=now() where id = ? and company_id = ?;";
    //     $values = [$id,$this->CompanyId];

    //     $this->Db->update($qry,$values);

    //     return true;
    // }

    // function setSchedule($scheduleId,$ids) {
    //     $qry = "delete from schedule_skills where schedule_id = ?;";
    //     $this->Db->delete($qry,[$scheduleId]);

    //     $idStr = implode(',',$ids);
    //     $qry = "select id from skills where company_id = ? and id in ($idStr) and status = 'active';";
    //     $values = [$this->CompanyId];

    //     $sets = [];

    //     $rows = $this->Db->query($qry,$values);
    //     foreach ($rows as $row) {
    //         $sets[] = "($scheduleId,$row[id])";
    //     }

    //     if (count($sets) < 1){
    //         return;
    //     }

    //     $setStr = implode(',',$sets);

    //     $qry = "insert into schedule_skills (`schedule_id`,`skill_id`) values $setStr;";
    //     $this->Db->insert($qry,[]);

    //     return;
    // }

    // function setEmployee($userId,$ids) {
    //     $qry = "delete from employee_skills where user_id = ?;";
    //     $this->Db->delete($qry,[$userId]);

    //     $idStr = implode(',',$ids);
    //     $qry = "select id from skills where company_id = ? and id in ($idStr) and status = 'active';";
    //     $values = [$this->CompanyId];

    //     $sets = [];

    //     $rows = $this->Db->query($qry,$values);
    //     foreach ($rows as $row) {
    //         $sets[] = "($userId,$row[id])";
    //     }

    //     if (count($sets) < 1){
    //         return;
    //     }

    //     $setStr = implode(',',$sets);

    //     $qry = "insert into employee_skills (`user_id`,`skill_id`) values $setStr;";
    //     $this->Db->insert($qry,[]);

    //     return;
    // }
}
?>