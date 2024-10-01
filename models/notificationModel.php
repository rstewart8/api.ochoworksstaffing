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
            $qry .= " join company_notifications cn on cn.notification_id = n.id and cn.status = 'active'";
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

	function queueUp($data) {
        $userId = (array_key_exists('userId', $data['data'])) ? $data['data']['userId'] : null;
        $scheduleId = (array_key_exists('scheduleId', $data['data'])) ? $data['data']['scheduleId'] : null;
        $which = (array_key_exists('which',$data)) ? $data['which'] : null;
        $data = (array_key_exists('data', $data)) ? json_encode($data['data']) : null;

        if ($userId != null) {
            $qry = "select id from users where id = ? and company_id = ? and status = 'active';";
            $rows = $this->Db->query($qry,[$userId,$this->CompanyId]);
            if (count($rows) < 1) {
                $this->Logger->info("invalid notification user");
                return null;
            }
        }

        if ($scheduleId != null) {
            $qry = "select id from schedules where id = ? and company_id = ? and status = 'active';";
            $rows = $this->Db->query($qry,[$scheduleId,$this->CompanyId]);
            if (count($rows) < 1) {
                $this->Logger->info("invalid notification schedule");
                return null;
            }
        }

        $qry = "select notification_queue_id from user_schedule_notifications where user_id = ? and schedule_id = ? and which = ? and status = 'pending' order by id desc limit 1;";
        $rows = $this->Db->query($qry,[$userId,$scheduleId,$which]);
        
        if (count($rows) > 0) {
            $this->Logger->info("duplicate notification");
            return $rows[0]['notification_queue_id'];
        }

        $qry = "insert into notification_queue (which,data) values (?,?);";
        $notificationQueueId = $this->Db->insert($qry,[$which,$data]);

        if ($userId != null && $scheduleId != null && $which != null && $notificationQueueId != null) {
            $qry = "insert into user_schedule_notifications (user_id,schedule_id,notification_queue_id,which) values(?,?,?,?);";
            $this->Db->insert($qry,[$userId,$scheduleId,$notificationQueueId,$which]);
        }

        return $notificationQueueId;
    }
}
?>