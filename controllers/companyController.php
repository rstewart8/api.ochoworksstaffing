<?php
/**
*
*/

require_once(ROOT."/models/companyModel.php");
require_once(ROOT."/models/userModel.php");

class Company {
	var $Res;
	var $Logger;
	var $User;
	var $CompanyId;
	var $Company;
	var $Usr;

	function __construct($db,$logger=null,$user=null){
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->CompanyId = $user['companyid'];
		$this->Company = new CompanyModel($db,$logger,$user['companyid']);
		$this->Usr = new UserModel($db, $logger, $this->User['companyid']);
	}

	public function fetch($data=null){
        $this->Res['data'] = $this->Company->fetch($data,$this->CompanyId);
        return $this->Res;
	}

	public function update($data=null){
        $this->Res['data'] = $this->Company->update($data['companys'][0],$this->CompanyId);
        return $this->Res;
	}

	public function users($data=null){
        $this->Res['data'] = $this->Usr->getForCompany($data,$this->User['userid']);
        return $this->Res;
	}
}