<?php
/**
*
*/
class CompanyModel
{
	var $Logger;
    var $Db;
    var $AvatarPath;
    var $DefaultAvatar;

	function __construct($db,$logger=null)
	{
		$this->Db = $db;
		$this->Logger = $logger;
        $this->AvatarPath = AVATARPATH;
        $this->DefaultAvatar = DEFAULTAVATAR;
	}

	function fetch($data,$companyId){
		
        $qry = "select c.id, c.name, c.address, c.city, c.state, c.zip";
        $qry .= ", s.id as state_id, s.name as state_name";
        $qry .= " from companys c";
        $qry .= " left join states s on lower(s.abbr) = lower(c.state)";
        $qry .= " where c.id = ?";
        $qry .= " and status = 'active';";
        return $this->Db->query($qry,[$companyId]);
	}

    function update($data,$companyId)
    {
        $sets = [];
        $values = [];

        $name = trim($data['name']);
        $sets[] = 'name = ?';
        $values[] = $name;

        if (array_key_exists('address', $data)) {
            $address = trim($data['address']);
            $sets[] = $address === '' ? 'address = null' : 'address = ?';
            if ($address !== '') {
                $values[] = $address;
            }
        }

        if (array_key_exists('city', $data)) {
            $city = trim($data['city']);
            $sets[] = $city === '' ? 'city = null' : 'city = ?';
            if ($city !== '') {
                $values[] = $city;
            }
        }

        if (array_key_exists('state', $data)) {
            $state = trim($data['state']);
            $sets[] = $state === '' ? 'state = null' : 'state = ?';
            if ($state !== '') {
                $values[] = strtoupper($state);
            }
        }

        if (array_key_exists('zip', $data)) {
            $zip = trim($data['zip']);
            $sets[] = $zip === '' ? 'zip = null' : 'zip = ?';
            if ($zip !== '') {
                $values[] = $zip;
            }
        }

        if (count($sets) < 1) {
            $res['status'] = 'error';
            $res['message'] = 'data not found';
            return $res;
        }

        $sets[] = 'modified = now()';

        $values[] = $companyId;

        $setStr = implode(',', $sets);

        $qry = "update companys set $setStr where id = ?";

        return $this->Db->update($qry, $values);
    }

    function users($data,$userId,$companyId) {
        $qry = "select u.id, u.firstname, u.lastname, u.email, u.photo";
        $qry .= " ,IF(u.photo IS NULL,CONCAT('$this->AvatarPath','/','$this->DefaultAvatar'),CONCAT('$this->AvatarPath','/',u.photo)) AS avatar";
        $qry .= " ,r.id as role_id, r.name as role_name";
        $qry .= " from users u";
        $qry .= " left join roles r on r.id = u.role_id";
        $qry .= " where u.company_id = ?";
        $qry .= " and u.id != ?";
        $qry .= " and u.identity_id = 1";
        $qry .= " and u.status = 'active';";

        $rows = $this->Db->query($qry,[$companyId,$userId]);
        return [
            'count' => count($rows),
            'users' => $rows
        ];
    }
}
?>