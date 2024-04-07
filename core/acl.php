<?php
Class Acl {

	private $user_empty = false;

	var $db;
	var $logger;

	//initialize the database object here
	function __construct($db,$logger=null) {
		$this->db = $db;
		$this->logger = $logger;
	}

	function check($controller,$function,$user) {
		$method = strtolower($_SERVER['REQUEST_METHOD']);
		//we check the user permissions first
		// If($this->user_permissions($controller,$function,$method,$user)) {
		// 	return true;
		// }

		if(!$this->role_permissions($controller,$function,$method,$user)) {
			return false;
		}

		if(!$this->identity_permissions($controller,$function,$method,$user)) {
			return false;
		}

		return true;
	}

	function user_permissions($controller,$function,$method,$user) {	
		$qry = "SELECT id FROM user_permissions WHERE `user_id`=? AND `controller`=? AND `function`=? AND `$method`=1;";
		$values = [$user['userid'],$controller,$function];

		$r = $this->db->query($qry,$values);
		
		If(count($r) > 0) {
			return true;
		}
		return false;
	}

	function role_permissions($controller,$function,$method,$user) {
		$qry = "SELECT id FROM role_permissions WHERE `role_id`=? AND `controller`=? AND `function`=? AND `$method`=1;";
		$values = [$user['userrole'],$controller,$function];

		$r = $this->db->query($qry,$values);

		If(count($r) > 0) {
			return true;
		}
		return false;
	}

	function identity_permissions($controller,$function,$method,$user) {
		$qry = "SELECT id FROM identity_permissions WHERE `identity_id`=? AND `controller`=? AND `function`=? AND `$method`=1;";
		$values = [$user['identityid'],$controller,$function];

		$r = $this->db->query($qry,$values);

		If(count($r) > 0) {
			return true;
		}
		return false;
	}
}
?>