<?php
/**
*
*/

require_once(ROOT."/models/companyModel.php");

class Company {
	var $Res;
	var $Logger;
	var $User;
	var $CompanyId;
	var $Company;

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
	}

	public function fetch($data=null){
        $this->Res['data'] = $this->Company->fetch($data,$this->CompanyId);
        return $this->Res;
	}

	public function update($data=null){
        $this->Res['data'] = $this->Company->update($data['companys'][0],$this->CompanyId);
        return $this->Res;
	}
}