<?php
/**
*
*/

require_once(ROOT."/models/notificationModel.php");

class Notification {
	var $Res;
	var $Logger;
	var $User;
	var $Notification;

	function __construct($db,$logger=null,$user=null){
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->Notification = new NotificationModel($db,$logger,$this->User['companyid']);

	}

	public function list($data=null){
		$which = null;

		$identityId = $this->User['identityid'];
		switch ($identityId) {
			case '3':
				$which = 'employee';
				break;
			
			default:
				$which = 'company';
				break;
		}

		$this->Res['data'] = $this->Notification->list($data,$which);
		return $this->Res;
	}

    function companyToggle($data) {
        $this->Res['data'] = $this->Notification->companyToggle($data['notifications'][0]);
        return $this->Res;
    }

	function employeeToggle($data) {
		$employeeId = null;

		$identityId = $this->User['identityid'];
		switch ($identityId) {
			case '3':
				$employeeId = $this->User['userid'];
				break;
			
			default:
				break;
		}
        $this->Res['data'] = $this->Notification->employeeToggle($data['notifications'][0],$employeeId);
        return $this->Res;
    }

}