<?php

/**
 *
 */

require_once(ROOT . "/models/clientModel.php");
require_once(ROOT . "/models/userModel.php");

class Client
{
	var $Res;
	var $Logger;
	var $User;
	var $Client;
	var $Usr;

	function __construct($db, $logger = null, $user = null)
	{
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->Client = new ClientModel($db, $logger, $this->User['companyid']);
		$this->Usr = new UserModel($db, $logger, $this->User['companyid']);
	}

	public function list($data = null)
	{
		$this->Res['data'] = $this->Client->get($data);
		return $this->Res;
	}

	function create($data = null)
	{
		$d = $data['clients'][0];
		$email = $d['email'];

		//// Check for unique email
		if (!$this->Usr->isEmailUnique($email)) {
			$this->Res['status'] = 'error';
			$this->Res['message'] = 'Email already in use';
			return $this->Res;
		}

		return $this->Client->create($d);
	}

	function fetch($data = null)
	{
		$identityId = $this->User['identityid'];

		switch ($identityId) {
			case '2':
				$clientId = $this->User['clientid'];
				$data['id'] = $clientId;
				break;
			
			default:
				break;
		}
		
		$this->Res['data'] = $this->Client->fetch($data);
		return $this->Res;
	}

	function update($data = null)
	{
		return $this->Client->update($data['clients'][0]);
	}

	function users($data = null)
	{
		$this->Res['data'] = $this->Usr->getForClient($data);
		return $this->Res;
	}

	function workdays($data)
	{
		switch ($_SERVER['REQUEST_METHOD']) {
			case 'POST':
				return $this->Client->createWorkday($data['workdays'][0]);
				break;

			case 'GET':
				$this->Res['data'] = $this->Client->listWorkdays($data);
				return $this->Res;
				break;

			default:
				$this->Res['status'] = 'error';
				$this->Res['message'] = 'invalid request';
				return $this->Res;
				break;
		}
	}
}
