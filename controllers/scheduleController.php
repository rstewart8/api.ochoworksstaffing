<?php

/**
 *
 */

require_once(ROOT . "/models/scheduleModel.php");
require_once(ROOT . "/models/employeeModel.php");

class Schedule
{
	var $Res;
	var $Logger;
	var $User;
	var $IdentityId;
	var $CompanyId;
	var $ClientId;
	var $Schedule;
	var $Employee;

	function __construct($db, $logger = null, $user = null)
	{
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->IdentityId = $user['identityid'];
		$this->CompanyId = $user['companyid'];
		$this->ClientId = $user['clientid'];
		$this->Schedule = new ScheduleModel($db, $logger, $user['companyid'], $this->ClientId, $user);
		$this->Employee = new EmployeeModel($db, $logger, $user['companyid'],$this->Schedule);
	}

	public function list($data = null)
	{
		$this->Res['data'] = $this->Schedule->list($data);
		return $this->Res;
	}

	function create($data)
	{
		return $this->Schedule->create($data['schedules'][0]);
	}

	function fetch($data = null)
	{
		$clientId = $this->User['clientid'];

		$this->Res['data'] = $this->Schedule->fetch($data, $clientId);

		return $this->Res;
	}

	function pending($data = null)
	{
		$clientId = $this->User['clientid'];

		$this->Res['data'] = $this->Schedule->pending($data);

		return $this->Res;
	}

	public function status($data = null)
	{
		$this->Res['data'] = $this->Schedule->status($data);
		return $this->Res;
	}

	public function assignment($data) {
		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'GET':
				$this->Res['data'] = $this->Schedule->assignment($data);
				return $this->Res;
				break;

			case 'POST':
				$ret = $this->Employee->createAssignment($data);
				if ($ret != null) {
					$this->Res['status'] = 'error';
					$this->Res['message'] = $ret;
				}
				return $this->Res;
				break;

				case 'DELETE':
					$ret = $this->Schedule->deleteScheduleAssignment($data);
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

	public function assignments($data) {
		$this->Res['data'] = $this->Schedule->assignments($data);
		return $this->Res;
	}

	public function days($data) {
		$this->Res['data'] = $this->Schedule->days($data);
		return $this->Res;
	}

	public function update($data) {
		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'GET':
				$this->Res['data'] = $this->Schedule->getUpdate($data);
				return $this->Res;
				break;

			case 'PUT':
				foreach ($data['schedules'] as $d) {
					$this->Schedule->update($d);	
				}
				return $this->Res;
			
			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}
	}

	public function delete($data) {
		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'DELETE':
				foreach ($data['schedules'] as $d) {
					$this->Schedule->delete($d);	
				}
				return $this->Res;
			
			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}
	}

	public function clientReportByDay($data) {
		$this->Res['data'] = $this->Schedule->clientReportByDay($data);
		return $this->Res;
	}

	public function reportData($data) {
		$this->Res['code'] = 500;
		$this->Res['status'] = 'error';
		$this->Res['message'] = 'Returns garbage data.';
		return $this->Res;
	}

	public function scheduleStatusByRange($data) {
		$this->Res['data'] = $this->Schedule->scheduleStatusByRange($data);
		return $this->Res;
	}
}
