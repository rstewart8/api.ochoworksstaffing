<?php
/**
*
*/
require_once(ROOT.'/vendor/autoload.php');
use \Firebase\JWT\JWT;

class Token
{
	var $logger;
	var $key;
	
	function __construct($logger=null)
	{
		$this->key = TOKENKEY;
		$this->logger = $logger;
	}

	function generate($d=[],$expSecs=null){
		if ($expSecs== null) {
			$expSecs = 86400; //expires in 24hrs
		}
		$tokenId    = generateRandomString(10);
		$issuedAt   = time();
		$notBefore  = $issuedAt;
		$expire     = $notBefore + $expSecs;
		$data = array(
			"iat"	=> $issuedAt,
			"nbf"	=> $notBefore,
			"exp"	=> $expire,
			"iss"	=> HOST,
			"jti"	=> $tokenId,
			"data"	=> $d
		);
		$j = JWT::encode($data, $this->key);
		return  $j;
	}

	function check($headers=null){
		// echo print_r($headers,true);
		// exit;
		$user = array();

		if(!isset($headers['Access'])){return array();}
		try{
			$decoded = JWT::decode($headers['Access'], $this->key, array('HS256'));
		}catch (Exception $e){
			return array();
		}
		$d = (array) $decoded;
		
		$this->logger->info("decoded: ".print_r($d,true));

		return (array) $d['data'];
	}
}
?>