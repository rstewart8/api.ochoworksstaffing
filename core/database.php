<?php
/**
*
*/
class Database
{
	var $errors;
	var $isTransaction;

	var $logger;
	var $host;
	var $user;
	var $password;
	var $db; 	
	var $dsn;
	var $options;
	var $conn;

	function __construct($logger=null) {

		$this->errors = [];
		$this->isTransaction = false;
	
		$this->logger = $logger;
		$this->host 		= DBHOST;
		$this->user 		= DBUSER;
		$this->password 	= DBPASS;
		$this->db 			= DBNAME;

		$this->dsn = "mysql:host=$this->host;dbname=$this->db;charset=utf8mb4";
		$this->options = [
			PDO::ATTR_EMULATE_PREPARES   => false, // turn off emulation mode for "real" prepared statements
			PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, //turn on errors in the form of exceptions
			PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, //make the default fetch be an associative array
		];

		$this->conn = null;

		$this->createConn();
	}
		

	function __destruct() {
		if (count($this->errors) > 0) {
			$this->rollBackTransaction();
		} else {
			$this->commitTransaction();
		}
		$this->conn = null;
	}

	function createConn(){
		try {
			$this->conn = new PDO($this->dsn, $this->user, $this->password, $this->options);
			$this->conn->beginTransaction();
			$this->isTransaction = true;

		} catch (Exception $e) {
			if ($this->logger != null) {
				$this->logger->error("Db connnect error: ".$e->getMessage());
			} else {
				echo "Db connnect error: ".$e->getMessage();
			}
			
		}

		return $this->conn;
	}
	

	function commitTransaction() {
		if (!$this->isTransaction) {
			return;
		}
		$this->isTransaction = false;
		$this->logger->info('Committing Transaction');

		if ($this->conn != null) {
			$this->conn->commit();
		}
	}

	function rollBackTransaction() {
		if (!$this->isTransaction) {
			return;
		}
		$this->isTransaction = false;
		$msg = implode(',', $this->errors);
		$this->logger->info($msg);
		$this->logger->info('RollBack Transaction');

		if ($this->conn !== null) {
			$this->conn->rollBack();
		}
	}

	function setErrrors($error) {
		$this->errors[] = $error;
	}

	function insert($qry,$values = []){
		$insertId = null;
		$this->logger->info("++++ insert qry $qry values: ".print_r($values,true));
		$rows =[];

		if ($this->conn !== null) {
			$stmt = $this->conn->prepare($qry);
			$stmt->execute($values);
			$insertId = $this->conn->lastInsertId();
			
			$stmt = null;
		}

		return $insertId;
	}

	function update($qry,$values = []){
		$this->logger->info("++++ update $qry values: ".print_r($values,true));
		try {
			$rows =[];
			$stmt = $this->conn->prepare($qry);
			$stmt->execute($values);
		} catch (Exception $e) {
			echo "error ".$e->getMessage();
			$this->logger->error("Db update error: ".$e->getMessage());
		}
		return $stmt->rowCount();
	}

	function delete($qry,$values = []){
		$this->logger->info("++++ delete $qry values: ".print_r($values,true));
		try {
			$rows =[];
			$stmt = $this->conn->prepare($qry);
			$stmt->execute($values);
		} catch (Exception $e) {
			echo "error ".$e->getMessage();
			$this->logger->error("Db delete error: ".$e->getMessage());
		}
		return;
	}

	function query($qry,$values = []){
		$this->logger->info("++++ qry $qry values: ".print_r($values,true));
		try {
			$rows =[];
			$stmt = $this->conn->prepare($qry);
			$stmt->execute($values);
			$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
			
			$stmt = null;
			
			return $rows;
		} catch (Exception $e) {
			$this->logger->error("Db query error: ".$e->getMessage());
		}
		
	}
}
?>