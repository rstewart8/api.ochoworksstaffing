<?php
/**
*
*/

require_once(ROOT."/models/jobModel.php");

class Job {
	var $Res;
	var $Logger;
	var $User;
	var $Job;
	var $CompanyId;
	var $ClientId;

	function __construct($db,$logger=null,$user=null){
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->CompanyId = $user['companyid'];
		$this->Job = new JobModel($db,$logger,$user['companyid'],$user['clientid']);
	}

	public function list($data=null){
		$this->Res['data'] = $this->Job->list($data);
		return $this->Res;
	}

	function create($data=null){ 
		$d = $data['jobs'][0];

		$clientId = $this->User['clientid'];
		$identityId = $this->User['identityid'];
		
		if ($clientId !== null && array_key_exists('clientId',$d) && $clientId != $d['clientId']) {
			$this->Res['status'] = 'error';
			$this->Res['message'] = 'no job access';
			return $this->Res;
		}

		return $this->Job->create($d);
	}

	function fetch($data=null){ 
		$clientId = $this->User['clientid'];

		$this->Res['data'] = $this->Job->fetch($data,$clientId);

		return $this->Res;
	 }

	 function update($data=null){
		$clientId = $this->User['clientid'];
		return $this->Job->update($data['jobs'][0],$clientId);
	 }
}