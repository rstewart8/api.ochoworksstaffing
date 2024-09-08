<?php
/**
*
*/
require_once(ROOT."/models/userModel.php");

class ClientModel
{
	var $Logger;
    var $Db;
    var $CompanyId;
    var $user;

	function __construct($db,$logger,$companyId)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->CompanyId = $companyId;
        $this->user = new UserModel($db,$logger,$companyId);
	}

    function isFieldValueUnique($field, $value, $id = null)
    {
        $values = [$this->CompanyId, $value];
        $qry = "select id from clients where company_id = ? and status != 'deleted' and $field = ?";

        if ($id != null) {
            $qry .= " and id != ?";
            array_push($values, $id);
        }

        if (count($this->Db->query($qry, $values)) > 0) {
            return false;
        }

        return true;
    }

	function get($data){
		$wheweekdays = [];
        $v = [$this->CompanyId];

        $qryData = qryBuilder($data, 'c', 'client');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'c.name ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "SELECT c.*";
        $qry .= " FROM clients AS c";
        $qry .= " WHERE c.company_id = ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND c.status = ?";
        } else {
            $qry .= " AND c.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = [
            'count' => $count,
            'clients' => $rows,
        ];

        return $d;
	}

    function create($data)
    {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => null
        ];

        $name = (array_key_exists('clientName', $data)) ? trim($data['clientName']) : null;
        $address = (array_key_exists('clientAddress', $data)) ? $data['clientAddress'] : null;
        $city = (array_key_exists('clientCity', $data)) ? $data['clientCity'] : null;
        $state = (array_key_exists('clientState', $data)) ? strtolower($data['clientState']) : null;
        $zip = (array_key_exists('clientZip', $data)) ? $data['clientZip'] : null;
        $email = (array_key_exists('clientEmail', $data)) ? $data['clientEmail'] : null;
        $phone = (array_key_exists('clientPhone', $data)) ? $data['clientPhone'] : null;
        $cell = (array_key_exists('clientCell', $data)) ? $data['clientCell'] : null;


        if (!$this->isFieldValueUnique('name', $name)) {
            $res['status'] = 'error';
            $res['message'] =  "Client name alreay exists";
            return $res;
        }

        $values = [$this->CompanyId, $name, $address, $city, $state, $zip, $email, $phone, $cell];
        $qry = "insert into clients (`company_id`,`name`, `address`,`city`,`state`,`zip`,`email`,`phone`,`cell`) VALUES (?,?,?,?,?,?,?,?,?)";

        $clientId = $this->Db->insert($qry, $values);

        $data['roleId'] = 1;
        $data['identityId'] = 2;
        $data['clientId'] = $clientId;

        $this->user->create($data);

        $res['data'] = [$clientId];

        return $res;
    }

    function fetch($data){
        $clientId = array_key_exists('id',$data) ? $data['id'] : null;

        if ($clientId == null) {
            return [];
        }
		$wheres = [];
        $v = [$this->CompanyId,$data['id']];

        $qryData = qryBuilder($data, 'c', 'client');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'c.name ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "SELECT c.*";
        $qry .= " FROM clients AS c";
        $qry .= " WHERE c.company_id = ?";
        $qry .= " AND c.id = ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND c.status = ?";
        } else {
            $qry .= " AND c.status = 'active'";
        }

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = $rows;

        return $d;
	}

    function update($data,$clientId=null)
    {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => $data
        ];

        $id = $data['id'];
        $name = (array_key_exists('clientName', $data)) ?trim($data['clientName']) : null;
        $address = (array_key_exists('address', $data)) ? $data['address'] : null;
        $city = (array_key_exists('city', $data)) ? $data['city'] : null;
        $state = (array_key_exists('state', $data)) ? strtolower($data['state']) : null;
        $zip = (array_key_exists('zip', $data)) ? $data['zip'] : null;
        $email = (array_key_exists('email', $data)) ? $data['email'] : null;
        $phone = (array_key_exists('phone', $data)) ? $data['phone'] : null;
        $cell = (array_key_exists('cell', $data)) ? $data['cell'] : null;
        $status = (array_key_exists('status', $data)) ? $data['status'] : null;

        $sets = [];
        $values = [];

        if ($name != null) {
            $sets[] = 'name = ?';
            $values[] = $name;
        }

        if ($address != null) {
            $sets[] = 'address = ?';
            $values[] = $address;
        }

        if ($city != null) {
            $sets[] = 'city = ?';
            $values[] = $city;
        }

        if ($state != null) {
            $sets[] = 'state = ?';
            $values[] = strtoupper($state);
        }

        if ($zip != null) {
            $sets[] = 'zip = ?';
            $values[] = $zip;
        }

        if ($email != null) {
            $sets[] = 'email = ?';
            $values[] = $email;
        }

        if ($phone != null) {
            $sets[] = 'phone = ?';
            $values[] = $phone;
        }

        if ($cell != null) {
            $sets[] = 'cell = ?';
            $values[] = $cell;
        }

        if ($status != null) {
            $sets[] = 'status = ?';
            $values[] = $status;
        }

        if (count($sets) < 1) {
            $res['status'] = 'error';
            $res['message'] = 'data not found';
            return $res;
        }

        $sets[] = 'modified = now()';

        if ($name != null && !$this->isFieldValueUnique('name', $name, $id)) {
            $res['status'] = 'error';
            $res['message'] = 'business name already exists';
            return $res;
        }

        $values[] = $id;
        $values[] = $this->CompanyId;

        $setStr = implode(',', $sets);

        $qry = "update clients set $setStr where id = ? and company_id = ?";

        $this->Db->update($qry, $values);

        if ($status == 'deleted') {
            $qry = "update users set status = 'deleted', modified = now() where client_id = ? and status != 'deleted';";
            $this->Db->update($qry,[$id]);

            $qry = "update jobs set status = 'deleted', modified = now() where client_id = ? and status != 'deleted';";
            $this->Db->update($qry,[$id]);
        }

        return $res;
    }

    function createWorkday($data) {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => null
        ];

        $name = trim($data['name']);
        $weekdays = $data['weekdays'];
        $holidays = $data['holidays'];

        $qry = "select id from workdays where company_id = ? and name = ? and status = 'active';";
        $rows = $this->Db->query($qry,[$this->CompanyId,$name]);

        if (count($rows) > 0) {
            $res['status'] = 'error';
            $res['message'] = 'workday name already exists';
            return $res;
        }

        $qry = "insert into workdays (company_id,name) values (?,?);";

        $workdaysId = $this->Db->insert($qry,[$this->CompanyId,$name]);

        $sets = [];

        foreach ($weekdays as $day) {
            $sets[] = "($workdaysId,$day)";
        }

        if (count($sets) > 0){
            $qry = "insert into workday_weekdays (workday_id,weekday_id) values " . implode(',',$sets);
            $this->Db->insert($qry,[]);
        }

        $sets = [];

        foreach ($holidays as $day) {
            $sets[] = "($workdaysId,$day)";
        }

        if (count($sets) > 0){
            $qry = "insert into workday_holidays (workday_id,holiday_id) values " . implode(',',$sets);
            $this->Db->insert($qry,[]);
        }

        return $res;
    }

    function listWorkdays($data){
		$wheres = [];
        $v = [$this->CompanyId];

        $qryData = qryBuilder($data, 'w', 'workday');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'w.name ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "SELECT w.*";
        $qry .= " FROM workdays AS w";
        $qry .= " WHERE w.company_id = ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND w.status = ?";
        } else {
            $qry .= " AND w.status = 'active'";
        }

        $count = count($this->Db->query($qry,$values));

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        foreach ($rows as &$row) {
            $workdayId = $row['id'];

            $qry = "select w.id,w.day";
            $qry .= " from workday_weekdays as ww";
            $qry .= " join weekdays as w on w.id = ww.weekday_id";
            $qry .= " where ww.workday_id = ?";

            $row['weekdays'] = $this->Db->query($qry,[$workdayId]);

            $qry = "select h.id,h.name";
            $qry .= " from workday_holidays as wh";
            $qry .= " join holidays as h on h.id = wh.holiday_id";
            $qry .= " where wh.workday_id = ?";

            $row['holidays'] = $this->Db->query($qry,[$workdayId]);

        }

        $d = [
            'count' => $count,
            'workdays' => $rows
        ];

        return $d;
	}
    
}
?>