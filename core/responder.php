<?php
/**
*
*/
class Res {
	function __construct($logger)
	{
		$this->res = [
			'status' 	=> 'ok',
			'msg'		=> null,
			'data'		=> []
		];
		$this->logger = $logger;
	}

	public function send($code=200,$status,$msg=null,$data=[]){
		$this->res['status']	= $status;
		$this->res['msg']		= $msg;
		$this->res['data']		= $data;

		if ($status != 'ok') {
			$this->logger->error("Response error: $msg");
		}
		
		switch ($code) {
			case '400':
				header("HTTP/1.1 400 Bad Request");
				break;
			case '401':
				header("HTTP/1.1 401 Unauthorized");
				break;				
			default:
			header("HTTP/1.1 200 OK");
				break;
		}


		header('Content-type: application/json');
		echo json_encode($this->res);
		exit;
	}
}