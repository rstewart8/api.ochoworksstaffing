<?php
/**
*
*/

require_once(ROOT."/models/userModel.php");
require_once(ROOT."/models/employeeModel.php");
require_once(ROOT."/models/scheduleModel.php");

class Employee {
	var $Res;
	var $Logger;
	var $User;
	var $CompanyId;
	var $Usr;
	var $Employee;
	var $Schedule;

	function __construct($db,$logger=null,$user=null){
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->CompanyId = $user['companyid'];
		$this->Usr = new UserModel($db,$logger,$user['companyid']);
		$this->Schedule = new ScheduleModel($db,$logger,$this->CompanyId,null,null);
		$this->Employee = new EmployeeModel($db,$logger,$user['companyid'],$this->Schedule);
		
	}

	public function list($data=null){
        $this->Res['data'] = $this->Usr->getEmployees($data);
		return $this->Res;
	}

	function create($data=null){ 
		$ret = array('status' => 'error','message' => '','data' => '' );
		$d = $data['users'][0];

		$d['roleId'] = 3;
		$d['identityId'] = 3;
		
		$msg = $this->Usr->create($d);

		if ($msg != null) {
			$ret['message'] = $msg;
			return $ret;
		}

		$ret['status'] = 'ok';
		return $ret;
	}

	public function available($data=null){
        $this->Res['data'] = $this->Employee->available($data);
		return $this->Res;
	}

	function assignments($data) {
		$this->Res['data'] = $this->Employee->assignments($data);
		return $this->Res;
	}
}