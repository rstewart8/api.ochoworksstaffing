<?php
/**
*
*/
class JobModel
{
	var $Logger;
    var $Db;
    var $CompanyId;
    var $ClientId;

	function __construct($db,$logger=null,$companyId,$clientId=null)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->CompanyId = $companyId;
        $this->ClientId = $clientId;
	}

    function isFieldValueUnique($field, $value, $clientId, $id = null)
    {
        $values = [$clientId, $value];
        $qry = "select id from jobs where client_id = ? and status != 'deleted' and $field = ?";

        if ($id != null) {
            $qry .= " and id != ?";
            array_push($values, $id);
        }

        if (count($this->Db->query($qry, $values)) > 0) {
            return false;
        }

        return true;
    }

	function list($data){
        $d = [
            'count' => 0,
            'jobs' => [],
        ];
		$wheres = [];

        if ($this->ClientId != null) {
            $clientId = $this->ClientId;
        } else {
            $clientId = ( array_key_exists('clientId',$data) ? $data['clientId'] : null);
        }

        if ($clientId == null) {
            $this->Logger->info("missing clientId");
            return $d;
        }
        $v = [$this->CompanyId,$clientId];

        $qryData = qryBuilder($data, 'j', 'job');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'j.name ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "SELECT j.*";
        $qry .= " FROM jobs AS j";
        $qry .= " WHERE j.company_id = ?";
        $qry .= " AND j.client_id = ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND j.status = ?";
        } else {
            $qry .= " AND j.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d['count'] = $count;
        $d['jobs'] = $rows;

        return $d;
	}

    function create($data)
	{
		$res = [
            'status' => 'ok',
            'message' => null,
            'data' => null
        ];
        
        $name = $data['name'];
		$address = $data['address'];
		$city = trim($data['city']);
		$state = $data['state'];
        $zip = (array_key_exists('zip',$data)) ? $data['zip'] : null;
		
        if ($this->ClientId != null) {
            $clientId = $this->ClientId;
        } else {
            $clientId = ( array_key_exists('clientId',$data) ? $data['clientId'] : null);
        }

        if ($clientId == null) {
            $res['status'] = 'error';
            $res['message'] = 'missing clientId';
            return $res;
        }


		if (!$this->isFieldValueUnique('name',$name,$clientId)) {
            $res['status'] = 'error';
            $res['message'] = 'job already created';
            return $res;
		}
        

		$qry = "insert into jobs (`company_id`,`client_id`,`name`,`address`,`city`,`state`,`zip`) values (?,?,?,?,?,?,?);";
		$values = [$this->CompanyId,$clientId,$name,$address,$city,$state,$zip];

		$res['data'] = $this->Db->insert($qry, $values);

        return $res;
	}

    function fetch($data,$clientId=null){
        $values = [$this->CompanyId,$data['id']];

        $qry = "SELECT j.id,j.name,j.address,j.city,j.state,j.zip,j.created,j.status";
		$qry .= " ,c.id AS client_id, c.name AS client_name";
        $qry .= " FROM jobs AS j";
		$qry .= " JOIN clients AS c ON c.id = j.client_id AND c.status = 'active'";
        $qry .= " WHERE j.company_id = ?";
        $qry .= " AND j.id = ?";
		$qry .= " AND j.status = 'active'";

        if ($clientId != null) {
            $qry .= " AND j.client_id = ?";
            $values[] = $clientId;
        }

        $rows = $this->Db->query($qry, $values);

        $d = $rows;

        return $d;
	}

    function update($data)
    {
        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => null
        ];

        $id = $data['id'];
        $clientId = $this->ClientId;

        if ($clientId == null) {
            $qry = "select client_id from jobs where id = ? and status = 'active'";
            $rows = $this->Db->query($qry,[$id]);

            if (count($rows) > 0) {
                $clientId = $rows[0]['client_id'];
            }
        }

        if ($clientId == null) {
            $res['status'] = 'error';
            $res['message'] = 'job not found';
            return $res;
        }

        
        $name = (array_key_exists('name', $data)) ?trim($data['name']) : null;
		$address = (array_key_exists('address', $data)) ? $data['address'] : null;
        $city = (array_key_exists('city', $data)) ? $data['city'] : null;
        $state = (array_key_exists('state', $data)) ? strtolower($data['state']) : null;
        $zip = (array_key_exists('zip', $data)) ? $data['zip'] : null;
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

        if ($name != null && !$this->isFieldValueUnique('name',$name,$clientId,$id)) {
            $res['status'] = 'error';
            $res['message'] = 'job name already exists';
            return $res;
        }

        $values[] = $id;
        $values[] = $this->CompanyId;
        $values[] = $clientId;

        $setStr = implode(',', $sets);

        $qry = "update jobs set $setStr where id = ? and company_id = ? and client_id = ?";

        $this->Db->update($qry, $values);

        return $res;
    }
}
?>