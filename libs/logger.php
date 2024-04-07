<?php
/**
*
*/
class Logger
{
	var $path;
	var $ident;
	var $errorPath;
	
	function __construct()
	{
		//Check if logger directorys exists
		$this->path = LOGGERPATH;
		$this->errorPath = ERRORPATH;
		
		if(!file_exists($this->path)){
			header('Content-Type: application/json');
            echo json_encode(array('status' => 'error','message' => 'Error code: 12et5e','data' => '' ));
            exit;
		}
		if(!file_exists($this->errorPath)){
			header('Content-Type: application/json');
            echo json_encode(array('status' => 'error','message' => 'Error code: 9s99s','data' => '' ));
            exit;
		}
		$this->ident = generateRandomString();
	}

	function info($message){
		$file = fopen($this->path, "a") or die("Unable to open file");
		$d = gmdate('Y-m-d H:i:s');
		$msg = "$d ".$this->ident.": INFO.... $message\n";
		fwrite($file,$msg);
		fclose($file);
	}

	function error($message){
		$file = fopen($this->errorPath, "a") or die("Unable to open file");
		$d = gmdate('Y-m-d H:i:s');
		$msg = "$d ".$this->ident.": ERROR.... $message\n";
		fwrite($file,$msg);
		fclose($file);
	}

	function warn($message){
		$file = fopen($this->path, "a") or die("Unable to open file");
		$d = gmdate('Y-m-d H:i:s');
		$msg = "$d ".$this->ident.": WARN.... $message\n";
		fwrite($file,$msg);
		fclose($file);
	}

}

?>