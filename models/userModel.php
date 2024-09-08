<?php
/**
*
*/
require_once(ROOT."/models/skillModel.php");

class UserModel
{
	var $Logger;
	var $Db;
	var $CompanyId;
    var $Skill;
    var $AvatarPath;
    var $DefaultAvatar;

	function __construct($db,$logger,$companyId)
	{
		$this->Db = $db;
		$this->Logger = $logger;
		$this->CompanyId = $companyId;
        $this->Skill = new SkillModel($db,$logger,$companyId);
        $this->AvatarPath = AVATARPATH;
        $this->DefaultAvatar = DEFAULTAVATAR;
	}

	function login($data){
		$email = $data['email'];
		$password = md5($data['password']);

		$qry = "SELECT u.id, u.firstname, u.lastname, u.role_id,u.identity_id,u.client_id,u.timezone_id";
		$qry .= ",c.id AS company_id,c.name AS company_name";
		$qry .= ",cl.id AS client_id,cl.name AS client_name";
        $qry .= ",ti.location AS timezone_location";
		$qry .= " FROM users AS u";
		$qry .= " JOIN companys AS c ON c.id = u.company_id";
        $qry .= " JOIN timezones ti on ti.id = u.timezone_id";
		$qry .= " LEFT JOIN clients AS cl ON cl.id = u.client_id";
		$qry .= " WHERE u.email=?"; 
		$qry .= " AND u.password=?";
		$qry .= " AND u.status != 'deleted'";
		$qry .= " AND u.status != 'inactive'";
		$values = [$email,$password];

		$d = $this->Db->query($qry,$values);
		return $d;
	}

	function isEmailUnique($email, $id = null)
	{
		$qry = "select id from users where email = ? and status != 'deleted'";
		$values = [trim($email)];

		if ($id != null) {
			$qry .= " and id != ?";
			$values[] = $id;
		}

		$rows = $this->Db->query($qry, $values);

		if (count($rows) > 0) {
			return false;
		}

		return true;
	}

	function create($data)
	{
		$firstName = $data['userFirstName'];
		$lastName = $data['userLastName'];
		$email = trim($data['email']);
		$roleId = $data['roleId'];
		$identityId = $data['identityId'];
		$clientId = (array_key_exists('clientId', $data)) ? $data['clientId'] : null;
        $phone = (array_key_exists('phone', $data)) ? $data['phone'] : null;
        $cell = (array_key_exists('cell', $data)) ? $data['cell'] : null;
        $gender = (array_key_exists('gender', $data)) ? strtolower($data['gender']) : 'male';

		if (!$this->isEmailUnique($email)) {
			return 'Email is already in use';
		}

		$env = ENV;
		$p = generateRandomString(8);

		if ($env == 'development') {
			$p = 'password';
		}

		$this->Logger->info("p: $p $env");

		$p = md5($p);

		$qry = "insert into users (`company_id`,`identity_id`,`client_id`,`firstname`,`lastname`,`phone`,`cell`,`email`,`role_id`,`gender`,`password`) values (?,?,?,?,?,?,?,?,?,?,?);";
		$values = [$this->CompanyId,$identityId,$clientId,$firstName, $lastName, $phone, $cell, $email, $roleId, $gender, $p];

		$userId = $this->Db->insert($qry, $values);

        if ($identityId == 3 && array_key_exists('skillIds',$data)) {
            $this->Skill->setEmployee($userId,$data['skillIds']);
        } 

        if ($identityId == 3 && array_key_exists('workdayIds',$data)) {
            $this->setEmployeeWorkdays($userId,$data['workdayIds']);
        }

		return null;
	}

	function getForClient($data,$clntId=null,$userId=null) {
        $clientId = ($clntId == null) ? $data['clientId'] : $clntId;
		$wheres = [];
        $v = [$this->CompanyId,$clientId];

        if ($userId != null) {
            $v[] = $userId;
        }

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "select u.id,u.firstname,u.lastname,u.email";
        $qry .= " ,r.id as role_id, r.name as role_name";
		$qry .= " from users as u";
        $qry .= " join roles as r on r.id = u.role_id";
		$qry .= " where u.company_id = ?";
        $qry .= " and u.client_id = ?";

        if ($userId != null) {
            $qry .= " and u.id != ?";
        }

        $qry .= " and u.identity_id = 2";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND u.status = ?";
        } else {
            $qry .= " AND u.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = [
            'count' => $count,
            'users' => $rows,
        ];

        return $d;
	}

	function fetch($data,$clientId=null){
        $values = [$this->CompanyId,$data['id']];

        $qry = "SELECT u.id,u.firstname,u.lastname,u.email,u.address,u.city,u.state,u.zip,u.phone,u.cell";
		$qry .= " ,c.id AS client_id, c.name AS client_name";
        $qry .= " ,r.id AS role_id, r.name AS role_name";
        $qry .= " FROM users AS u";
		$qry .= " LEFT JOIN clients AS c ON c.id = u.client_id";
        $qry .= " JOIN roles AS r ON r.id = u.role_id";
        $qry .= " WHERE u.company_id = ?";
        $qry .= " AND u.id = ?";
		$qry .= " AND u.status = 'active'";

		if ($clientId != null) {
			$values[] = $clientId;
			$qry .= " AND u.client_id = ?";
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
            'data' => $data
        ];

        $id = $data['id'];
        $firstName = (array_key_exists('userFirstName', $data)) ?trim($data['userFirstName']) : null;
		$lastName = (array_key_exists('userLastName', $data)) ?trim($data['userLastName']) : null;
        $address = (array_key_exists('address', $data)) ? $data['address'] : null;
        $city = (array_key_exists('city', $data)) ? $data['city'] : null;
        $state = (array_key_exists('state', $data)) ? strtolower($data['state']) : null;
        $zip = (array_key_exists('zip', $data)) ? $data['zip'] : null;
        $email = (array_key_exists('email', $data)) ? $data['email'] : null;
        $phone = (array_key_exists('phone', $data)) ? $data['phone'] : null;
        $cell = (array_key_exists('cell', $data)) ? $data['cell'] : null;
        $status = (array_key_exists('status', $data)) ? $data['status'] : null;
        $roleId = (array_key_exists('roleId',$data)) ? $data['roleId'] : null;

        $sets = [];
        $values = [];

        if ($firstName != null) {
            $sets[] = 'firstname = ?';
            $values[] = $firstName;
        }

		if ($lastName != null) {
            $sets[] = 'lastname = ?';
            $values[] = $lastName;
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

        if ($roleId != null) {
            $sets[] = 'role_id = ?';
            $values[] = $roleId;
        }

        if (count($sets) < 1) {
            $res['status'] = 'error';
            $res['message'] = 'data not found';
            return $res;
        }

        $sets[] = 'modified = now()';

        if ($email != null && !$this->isEmailUnique($email, $id)) {
            $res['status'] = 'error';
            $res['message'] = 'email already exists';
            return $res;
        }

        $values[] = $id;
        $values[] = $this->CompanyId;

        $setStr = implode(',', $sets);

        $qry = "update users set $setStr where id = ? and company_id = ?";

        $this->Db->update($qry, $values);

        return $res;
    }

    function getEmployees($data){
		$wheres = [];
        $v = [$this->CompanyId];

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);
        
        $qry = "SELECT u.id,u.firstname,u.lastname,u.email,u.gender,u.photo,u.status";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " FROM users AS u";
        $qry .= " WHERE u.company_id = ?";
        $qry .= " AND u.identity_id = 3";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND u.status = ?";
        } else {
            $qry .= " AND u.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        foreach ($rows as &$row) {
            $qry = "select s.name";
            $qry .= " from employee_skills es";
            $qry .= " join skills s on s.id = es.skill_id";
            $qry .= " where es.user_id = ?";

            $skills = [];

            $rows2 = $this->Db->query($qry,[$row['id']]);
            foreach ($rows2 as $row2) {
                $skills[] = $row2['name'];
            }

            $row['skillsList'] = implode(', ',$skills);
        }

        $d = [
            'count' => $count,
            'employees' => $rows,
        ];

        return $d;
	}

    function setEmployeeWorkdays($userId,$ids) {
        $qry = "delete from employee_weekdays where user_id = ?;";
        $this->Db->delete($qry,[$userId]);

        $idStr = implode(',',$ids);
        $qry = "select id from weekdays where id in ($idStr);";
        $values = [];

        $sets = [];

        $rows = $this->Db->query($qry,$values);
        foreach ($rows as $row) {
            $sets[] = "($userId,$row[id])";
        }

        if (count($sets) < 1){
            return;
        }

        $setStr = implode(',',$sets);

        $qry = "insert into employee_weekdays (`user_id`,`weekday_id`) values $setStr;";
        $this->Db->insert($qry,[]);

        return;
    }

    function getProfile($data=null,$userId) {
        $qry = "SELECT u.id,u.firstname,u.lastname,u.address,u.city,u.state,u.zip,u.email,u.phone,u.cell,u.gender,u.photo,u.timezone_id";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " ,t.name as timezone_name";
        $qry .= " ,s.name as state_name";
        $qry .= " FROM users u";
        $qry .= " left join timezones t on t.id = u.timezone_id";
        $qry .= " left join states s on lower(s.abbr) = lower(u.state)";
        $qry .= " where u.id = ?";
        $qry .= " and u.status = 'active';";

        $rows = $this->Db->query($qry,[$userId]);

        return ['users' => $rows];
    }

    function updateProfile($data,$userId) {

        $res = [
            'status' => 'ok',
            'message' => null,
            'data' => $data
        ];

        $firstName = (array_key_exists('userFirstName', $data)) ?trim($data['userFirstName']) : null;
		$lastName = (array_key_exists('userLastName', $data)) ?trim($data['userLastName']) : null;
        $email = (array_key_exists('email', $data)) ?trim($data['email']) : null;

        $sets = [];
        $values = [];

        if ($firstName != null) {
            $sets[] = 'firstname = ?';
            $values[] = $firstName;
        }

		if ($lastName != null) {
            $sets[] = 'lastname = ?';
            $values[] = $lastName;
        }

        if ($email != null) {
            $sets[] = 'email = ?';
            $values[] = $email;
        }

        if (count($sets) < 1) {
            $res['status'] = 'error';
            $res['message'] = 'data not found';
            return $res;
        }

        $sets[] = 'modified = now()';

        if ($email != null && !$this->isEmailUnique($email, $userId)) {
            $res['status'] = 'error';
            $res['message'] = 'email already exists';
            return $res;
        }

        $values[] = $userId;
        $values[] = $this->CompanyId;

        $setStr = implode(',', $sets);

        $qry = "update users set $setStr where id = ? and company_id = ?";

        $this->Db->update($qry, $values);

        return $res;
    }

    function getForCompany($data,$userId) {

		$wheres = [];
        $v = [$this->CompanyId,$userId];

        $qryData = qryBuilder($data, 'u', 'user');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 'u.firstname ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "select u.id,u.firstname,u.lastname,u.email";
        $qry .= " ,r.id as role_id, r.name as role_name";
		$qry .= " from users as u";
        $qry .= " join roles as r on r.id = u.role_id";
		$qry .= " where u.company_id = ?";
		$qry .= " and u.identity_id = 1";
        $qry .= " and u.id != ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND u.status = ?";
        } else {
            $qry .= " AND u.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = [
            'count' => $count,
            'users' => $rows,
        ];

        return $d;
	}


}

?>