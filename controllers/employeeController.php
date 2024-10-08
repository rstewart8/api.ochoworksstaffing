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
		$this->Employee = new EmployeeModel($db,$logger,$user['companyid'],$this->Schedule,$this->User);
		
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

	function assignmentDetails($data) {
		$identityId = $this->User['identityid'];
		$userId = ($identityId == 3) ? $this->User['userid'] : null;

		$this->Res['data']['assignments'] = $this->Employee->assignmentDetails($data,$userId);
		return $this->Res;
	}

	function fetch($data = null)
	{
		$this->Res['data'] = $this->Employee->fetch($data);
		return $this->Res;
	}

	function update($data = null)
	{
		return $this->Employee->update($data['users'][0]);
	}

	public function workDays($data) {
		$identityId = $this->User['identityid'];
		$userId = ($identityId == 3) ? $this->User['userid'] : null;

		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'GET':
				$this->Res['data'] = $this->Employee->getWorkdays($data,$userId);
				return $this->Res;
				break;

			case 'POST':
				$ret = $this->Employee->setEmployeeWorkdays($data['employeeWorkDays'][0]);
				if ($ret != null) {
					$this->Res['status'] = 'error';
					$this->Res['message'] = $ret;
				}
				return $this->Res;
				break;
			
			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}
	}

	public function skills($data) {
		$identityId = $this->User['identityid'];
		$userId = ($identityId == 3) ? $this->User['userid'] : null;

		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'GET':
				$this->Res['data'] = $this->Employee->getSkills($data,$userId);
				return $this->Res;
				break;

			case 'POST':
				$ret = $this->Employee->setEmployeeSkills($data['employeeSkills'][0]);
				if ($ret != null) {
					$this->Res['status'] = 'error';
					$this->Res['message'] = $ret;
				}
				return $this->Res;
				break;
			
			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}
	}

	function forClientByDays($data){

		$identityId = $this->User['identityid'];
		$clientId = null;

		switch ($identityId) {
			case '2':
				$clientId = $this->User['clientid'];
				break;
			
			default:
				break;
		}

		$this->Res['data'] = $this->Employee->forClientByDays($data, $clientId);
		return $this->Res;
	}

}