<?php
/**
*
*/

require_once(ROOT.'/libs/tokenizer.php');
require_once(ROOT.'/core/acl.php');


class Authentication
{
	var $tokenizer;
	var $db;
	var $acl;
	var $logger;

	function __construct($db,$logger){
		$this->tokenizer = new Token($logger);
		$this->db = $db;
		$this->acl = new Acl($db,$logger);
		$this->logger = $logger;
	}

	function authenticate($controller,$function){
		$ret = array('status' => 'error', 'user' => null, 'msg' => null);
        $headers = apache_request_headers();
        $ret['user'] =  $this->tokenizer->check($headers);
        $this->logger->info("User: ".print_r($ret['user'],true));
        if (count($ret['user']) > 0) {
        	if ($this->acl->check($controller,$function,$ret['user'])){
    			$ret['status'] = 'ok';
    		} else {
    			$ret['msg'] = "No Access";
    		}
    	} else {
            $ret['msg'] = 'Authentication Failed';
    	}
	    return $ret;
	}

}