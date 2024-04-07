<?php
/**
*
*/

require_once(ROOT."/models/skillModel.php");

class Skill {
	var $Res;
	var $Logger;
	var $User;
	var $Skill;
	var $Usr;

	function __construct($db,$logger=null,$user=null){
		$this->Res = [
			'status' 		=> 'ok',
			'message'		=> null,
			'data'			=> []
		];
		$this->Logger = $logger;
		$this->User = $user;
		$this->Skill = new SkillModel($db,$logger,$this->User['companyid']);

	}

	public function list($data=null){
		$this->Res['data'] = $this->Skill->list($data);
		return $this->Res;
	}

	function create($data=null){ 
		$d = $data['skills'][0];
        return $this->Skill->create($d);
	}

    function delete($data) {
        $this->Skill->delete($data['skills'][0]['ids'][0]);
        return $this->Res;
    }

}