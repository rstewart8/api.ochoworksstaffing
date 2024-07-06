<?php
/**
*
*/
class UtilitiesModel
{
	var $Logger;
    var $Db;
	var $CompanyId;

	function __construct($db,$logger,$companyId)
	{
		$this->Db = $db;
		$this->Logger = $logger;
		$this->CompanyId = $companyId;
	}

	function states(){
		$qry = "SELECT * FROM states;";
		$values = [];
		return $this->Db->query($qry,$values);
	}

	function isValidState($state) {
		$qry = "SELECT id FROM states WHERE abbr = ?";
		$values = [$state];
		$rows = $this->Db->query($qry,$values);

		if (count($rows) < 1) {
			return false;
		}

		return true;
	}

	function roles($ids=[]){
		$qry = "SELECT * FROM roles";
		if (count($ids) > 0) {
			$qry .= " WHERE id in (".implode(',',$ids).")";
		}
		$values = [];
		return $this->Db->query($qry,$values);
	}

	function shifts(){
		$qry = "SELECT * FROM shifts ORDER BY shift_id ASC";
		$values = [];
		return $this->Db->query($qry,$values);
	}

	function paymentMethods(){
		$qry = "SELECT * FROM payment_methods ORDER BY payment_method_id ASC";
		$values = [];
		return $this->Db->query($qry,$values);
	}

	function companys() {
		$qry = "SELECT id,location_name,address,city,state,zip,email,phone FROM companys WHERE status = 'active' ORDER BY location_name ASC;";
		return $this->Db->query($qry,[]);
	}

	function weekdays(){
		$qry = "SELECT * FROM weekdays ORDER BY `no` ASC";
		$values = [];
		$rows = $this->Db->query($qry,$values);

		foreach ($rows as &$row) {
			$toggle = true;
			$color = 'primary';

			if ($row['no'] == 0 || $row['no'] == 6){
				$toggle = false;
				$color = 'basic';
			}
			$row['toggle'] = $toggle;
			$row['color'] = $color;
		}

		return $rows;
	}

	function holidays(){
		$qry = "SELECT * FROM holidays WHERE company_id IS NULL OR company_id = ? ORDER BY id ASC";
		$values = [$this->CompanyId];
		$rows = $this->Db->query($qry,$values);

		foreach ($rows as &$row) {
			$row['toggle'] = true;
			$row['color'] = 'primary';
		}

		return $rows;
	}

	function workdays(){
		$qry = "SELECT * FROM workdays WHERE company_id = ? AND status = 'active' ORDER BY name ASC";
		$values = [$this->CompanyId];
		$rows = $this->Db->query($qry,$values);

		return $rows;
	}

	function scheduleTimes(){
		$chkTs = strtotime('00:00:00');
		$endTs = strtotime('23:59:59');
		$cntr = 0;
		$d = [];

		while ($chkTs <= $endTs && $cntr < 100) {
			$cntr++;
			$time = date('H:i:s', $chkTs);
			$t = date('g:i a', $chkTs);

			$tmp = ['time' => $time, 'prettyTime' => $t];
			$d[] = $tmp;
			$chkTs = strtotime($time . ' +15 minute');
		}

		return $d;
	}
}
?>