<?php
require_once(ROOT."/models/UserModel.php");
require_once(ROOT."/libs/tokenizer.php");

class User {

	var $Logger;
	var $Usr;
	var $T;
	var $User;
	var $Res;

	function __construct($db,$logger=null,$user=null){	
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];

		$companyId = ($user != null) ? $user['companyid'] : null;	
		$this->Logger = $logger;
		$this->Usr = new UserModel($db,$logger,$companyId);
		$this->T = new Token($logger);
		$this->User = $user;
	}

	public function login($data=null){
		$ret = array('status' => 'error','message' => '','data' => '' );
		$res = $this->Usr->login($data['users']);
		
		if(count($res) > 0){
			$d = array(
				'userid' => $res[0]['id'],
				'userrole' => $res[0]['role_id'],
				'identityid' => $res[0]['identity_id'],
				'companyid' => $res[0]['company_id'],
				'clientid' => $res[0]['client_id'],
				'timezoneid' => $res[0]['timezone_id'],
				'timezoneloc' => $res[0]['timezone_location']
			);

			$token = $this->T->generate($d);
			$ret['status'] = 'ok';
			$ret['data'] = array(
				'user' => array(
					'id' => $res[0]['id'],
					'username' => $res[0]['firstname'].' '.$res[0]['lastname'],
					'firstname' => $res[0]['firstname'],
					'lastname' => $res[0]['lastname'],
					'roleId' => $res[0]['role_id'],
					'identityId' => $res[0]['identity_id'],
					'token' => $token,
					'timezoneLoc' => $res[0]['timezone_location']
				),
				'company' => [
					'id' => $res[0]['company_id'],
					'name' => $res[0]['company_name']
				],
				'client' => [
					'id' => $res[0]['client_id'],
					'name' => $res[0]['client_name']
				]
			);
			$this->Logger->info("Loggin UserId: ".$res[0]['id']);
		} else {
			$ret['code'] = 401;
			$ret['status'] = 'error';
			$ret['message'] = 'Invalid password or username.';
			$this->Logger->warn("Invalid Loggin");
		}
		// $u = new UserModel($this->Logger);
		// $ress = $this->Usr->login($data);
		return $ret;
	}

	function create($data=null){ 
		$ret = array('status' => 'error','message' => '','data' => '' );
		$d = $data['users'][0];

		$clientId = $this->User['clientid'];
		$identityId = $this->User['identityid'];

		if ($identityId == 2) {
			if (!array_key_exists('clientId',$d)) {
				$ret['message'] = 'missing clientId';
				return $ret;
			}

			if ($d['identityId'] != 2) {
				$ret['message'] = 'no access identity';
				return $ret;
			}
		}

		if ($clientId !== null && array_key_exists('clientId',$d) && $clientId != $d['clientId']) {
			$ret['message'] = 'no access client';
			return $ret;
		}
		
		$msg = $this->Usr->create($d);

		if ($msg != null) {
			$ret['message'] = $msg;
			return $ret;
		}

		$ret['status'] = 'ok';
		return $ret;
	}

	function fetch($data=null){ 
		$ret = array('status' => 'ok','message' => '','data' => '' );
		$clientId = $this->User['clientid'];

		$ret['data'] = $this->Usr->fetch($data,$clientId);

		return $ret;
	 }

	 function update($data=null){
		$clientId = $this->User['clientid'];
		return $this->Usr->update($data['users'][0],$clientId);
	 }

	 function profile($data=null){
		$userId = $this->User['userid'];
		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'GET':				
				$this->Res['data'] = $this->Usr->getProfile($data,$userId);
				return $this->Res;
				break;

			case 'PUT':
				return $this->Res['data'] = $this->Usr->updateProfile($data['users'][0],$userId);
				break;

			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}
	 }

	 function photo($data=null){
		$userId = $this->User['userid'];

		switch ($_SERVER["REQUEST_METHOD"]) {
			case 'POST':
				$this->Res['data'] = $this->Usr->updatePhoto($data,$userId);
				break;

			default:
				$this->Res['code'] = 500;
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'Request method not supported.';
				return $this->Res;
				break;
		}

		return $this->Res;
	 }

	 function resetPassword($data) {
		$identityId = $this->User['identityid'];
		$roleId = $this->User['userrole'];
		$userId = ($identityId == 3 || $roleId == 3) ? $this->User['userid'] : null;

		$d = $data['users'][0];

		if ($userId == null && !array_key_exists('userId',$d)) {
			$userId = $this->User['userid'];
		}

		$r = $this->Usr->updatePassword($d,$userId);

		if ($r != null) {
			$this->Res['status'] = 'error';
			$this->Res['message'] = $r;
		}

		return $this->Res;
	 }
}