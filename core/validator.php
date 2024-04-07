<?php

class Validator 
{
	var $Logger;
	var $Controller;
	var $Function;
	var $Method;
	var $Params;
	var $Param;
	var $Errors;

	function __construct($logger,$controller,$function,$method){
		$this->Logger = $logger;
		$this->Controller = $controller;
		$this->Function = $function;
		$this->Method = $method;
		$this->Params = [];
		$this->Param = null;
		$this->Errors = [];
		set_error_handler(array($this, 'warning_handler'), E_WARNING);
	}

	function __destruct() {
       restore_error_handler();
    }

	function warning_handler($errno, $errstr) { 
		$this->Errors[] = "Fatal param error";
	}

	function validate($sentParams,$param){
		$this->Logger->info("Validator recieved sentParams: ".print_r($sentParams,true));
		$this->Logger->info("Validator recieved params: ".print_r($param,true));
		$ret = array("status" => "ok","msg" => "", "data" => []);
		$this->Params = $sentParams;
		$this->Param = $param;

		if (strpos($param, '_')) {
			$param = lcfirst(str_replace('_', '', ucwords($param, '_')));

		}

		//// Get the validator json
		$this->Logger->info("Validator Json: $param");
		$file = ROOT."/core/validators/".$param.".json";

		if (file_exists($file)) {
			$json = file_get_contents($file);
			$validator = json_decode($json, true);
			try {
				$this->validateParams($validator['params']);
			} catch (Exception $e) {
				$this->Logger->Error("Params are invalid ERROR: $e");
				$this->Errors[] = "Param are invalid";
			}

			
		} else {
			$this->Logger->info("No validator found for $param");
			$this->Errors[] = "Missing Validator: $param";
		}

		if (count($this->Errors) > 0) {
			$ret['status'] = 'error';
			$ret['data'] = $this->Errors;
		}

		return $ret;

	}

	function validateParams($validator){
		
		if (!is_array($this->Params)) {
			$this->Errors[] = "Invalid json";
			return;
		}

		$types = array_keys($this->Params);

		$route = $this->Controller.'|'.$this->Function.'|'.$this->Method;
		foreach ($validator as $type => $value) {
			
			if (in_array($route,$value['required'])) {
				if (!array_key_exists($type,$this->Params)){
					$this->Errors[] = "missing required: $this->Param:$type";
					return;
				}
			}
			if (in_array($route,$value['exclude'])) {
				if (array_key_exists($type,$this->Params)){
					$this->Errors[] = "Param not allowed: $this->Param:$type";
					return;
				} else {
					continue;
				}
			}

			if (($k = array_search($type, $types)) !== false) {
			    unset($types[$k]);
			}
			
			if (in_array($route,$value['novalidate'])) {
				if (array_key_exists($type,$this->Params)){
					continue;
				}
			}
			
			if ($value['allowNull'] == 1 && array_key_exists($type, $this->Params) && $this->Params[$type] == null) {
				continue;
			}

			if ($value['type'] == 'json') {
				$this->validate($this->Params[$type],$this->Param."_$type");
			} else {
				if (array_key_exists($type,$this->Params)) {
					//// Check for harmful characters
					if (is_string($this->Params[$type]) && $this->Params[$type] != strip_tags($this->Params[$type])) {
						$this->Errors[] = "$type has invalid characters";
						continue;
					}

					$funct = "check".ucfirst($value['type']);
					if(method_exists($this, $funct)){
						$this->$funct($type,$this->Params[$type]);						
					} else {
						$this->Logger->Error("Missing validator type function '$funct'");
						$this->Errors[] = "Missing validator type function";
					}
				}
			}

			foreach ($value['properties'] as $property => $val) {
				if (array_key_exists($type,$this->Params)) {
					if(method_exists($this, $property)){
						$this->$property($type,$val);
					} else {
						$this->Logger->Error("Missing validator function '$property'");
						$this->Errors[] = "Missing validator function";
					}
				}
			}	
		}
		if (count($types) > 0){
			$this->Errors[] = "Invalid params: ".implode(',',$types);
		}
	}

	//// VALIDATE FUNCTIONS ////

	function checkInteger($key,$value){
		if (!ctype_digit((string)$value)) {
			$this->Errors[] = "$key is invalid";
		}
	}

	function checkMysqlDate($key, $value)
	{
		try {
			$dArr = explode('-', $value);

			if (count($dArr) != 3) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$year = $dArr[0];
			$month = $dArr[1];
			$day = $dArr[2];

			if (strlen($year) != 4 || strlen($month) != 2 || strlen($day) != 2) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			if (!checkdate($month, $day, $year)) {
				$this->Errors[] = "$key is invalid";
				return;
			}

		} catch (\Throwable $th) {
			$this->Errors[] = "$key is invalid";
		}
	}

	function checkMysqlDateTime($key, $value)
	{
		try {
			$tmp = explode(' ', $value);

			if (count($tmp) != 2) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$dArr = explode('-', $tmp[0]);

			if (count($dArr) != 3) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$year = $dArr[0];
			$month = $dArr[1];
			$day = $dArr[2];

			if (strlen($year) != 4 || strlen($month) != 2 || strlen($day) != 2) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			if (!checkdate($month, $day, $year)) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$tArr = explode(':', $tmp[1]);

			if (count($tArr) != 3) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$hour = $tArr[0];
			$minute = $tArr[1];
			$second = $tArr[2];

			if (strlen($hour) != 2 || strlen($minute) != 2 || strlen($second) != 2) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			$h = (int)$hour;
			$m = (int)$minute;
			$s = (int)$second;

			if ($h < 0 || $h > 23) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			if ($m < 0 || $m > 59) {
				$this->Errors[] = "$key is invalid";
				return;
			}

			if ($s < 0 || $s > 59) {
				$this->Errors[] = "$key is invalid";
				return;
			}
		} catch (\Throwable $th) {
			$this->Errors[] = "$key is invalid";
		}
	}

	function checkCommaSeparatedInts($key, $value)
	{
		$arr = explode(',', $value);
		foreach ($arr as $a) {
			if (!ctype_digit((string)$a)) {
				$this->Errors[] = "$key is invalid";
				return;
			}
		}
	}

	function checkString($key,$value){
		if (gettype($value) === 'double' || gettype($value) === 'integer') {
			return;
		}
		if (gettype($value) !== 'string') {
			$this->Errors[] = "$key is invalid";
		}
	}

	function checkPassword($key,$value){
		if(!preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&=_\+()\-])[A-Za-z\d@$!%*?&=_\+()\-]{1,50}$/', $value)) {
			$this->Errors[] = "$key is invalid";	
		}	
	}
	function checkEmail($key,$value){
		if(!preg_match('/^(?!(?:(?:\x22?\x5C[\x00-\x7E]\x22?)|(?:\x22?[^\x5C\x22]\x22?)){255,})(?!(?:(?:\x22?\x5C[\x00-\x7E]\x22?)|(?:\x22?[^\x5C\x22]\x22?)){65,}@)(?:(?:[\x21\x23-\x27\x2A\x2B\x2D\x2F-\x39\x3D\x3F\x5E-\x7E]+)|(?:\x22(?:[\x01-\x08\x0B\x0C\x0E-\x1F\x21\x23-\x5B\x5D-\x7F]|(?:\x5C[\x00-\x7F]))*\x22))(?:\.(?:(?:[\x21\x23-\x27\x2A\x2B\x2D\x2F-\x39\x3D\x3F\x5E-\x7E]+)|(?:\x22(?:[\x01-\x08\x0B\x0C\x0E-\x1F\x21\x23-\x5B\x5D-\x7F]|(?:\x5C[\x00-\x7F]))*\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-[a-z0-9]+)*\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-[a-z0-9]+)*)|(?:\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\]))$/iD', $value)) {
			$this->Errors[] = "$key is invalid";	
		}
	}

	function checkCodeStr($key,$value) {
		if(!preg_match('/^[a-zA-Z0-9-_]+$/', $value)) {
			$this->Errors[] = "$key is invalid";	
		}
	}

	function checkNameStr($key,$value) {
		if(!preg_match('/^[a-zA-Z0-9-_&| ]+$/', $value)) {
			$this->Errors[] = "$key is invalid";	
		}
	}

	function checkArray($key,$value) {
		if(!is_array($value)) {
			$this->Errors[] = "$key is invalid";	
		}
	}

	function minLength($type,$val) {
		if (!isset($this->Params[$type])) {
			$this->Errors[] = "Missing param for $type";
			return;
		}
		if (strlen($this->Params[$type]) < $val) {
			$this->Errors[] = "$type needs to be at least $val characters";
		}
	}

	function maxLength($type,$val) {
		if (!isset($this->Params[$type])) {
			$this->Errors[] = "Missing param for $type";
			return;
		}
		if (strlen($this->Params[$type]) > $val) {
			$this->Errors[] = "$type needs to be at less than $val characters";
		}
	}

	function enum($type,$val) {
		$enums = explode('|', $val);
		if (!in_array($this->Params[$type], $enums)) {
			$this->Errors[] = "$type is invalid";
		}
	}

	function minArraylength($type,$val) {
		if (!isset($this->Params[$type])) {
			$this->Errors[] = "Missing param for $type";
			return;
		}

		if (!is_array($this->Params[$type])) {
			$this->Errors[] = "Invalid type for $type";
			return;
		}
	
		if (count($this->Params[$type]) < $val) {
			$this->Errors[] = "$type count need to be greater than $val items";
		}
	}

	function arrayItemType($type,$val) {
		if (!isset($this->Params[$type])) {
			$this->Errors[] = "Missing param for $type";
			return;
		}

		if (!is_array($this->Params[$type])) {
			$this->Errors[] = "Invalid type for $type";
			return;
		}
	
		if (count($this->Params[$type]) > 0) {
			foreach ($this->Params[$type] as $key => $value) {
				$funct = "check".ucfirst($val);
				if(method_exists($this, $funct)){
					$this->$funct($type,$value);
				} else {
					$this->Logger->Error("Missing validator type function '$funct'");
					$this->Errors[] = "Missing validator type function";
				}
			}
		}
	}

	//// END OF VALIDATE FUNCTIONS ////

}
?>