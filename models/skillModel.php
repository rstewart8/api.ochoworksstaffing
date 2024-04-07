<?php
/**
*
*/
class SkillModel
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

    function isFieldValueUnique($field, $value, $id = null)
    {
        $values = [$this->CompanyId, $value];
        $qry = "select id from skills where company_id = ? and status != 'deleted' and $field = ?";

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
		$wheres = [];
        $v = [$this->CompanyId];

        $qryData = qryBuilder($data, 's', 'skill');

        $offset = $qryData['offset'] * $qryData['limit'];
        $wheres = $qryData['wheres'];
        $separator = $qryData['separator'];
        $values = array_merge($v, $qryData['values']);
        $orderBy = ($qryData['order'] != null ? $qryData['order'] : 's.name ASC');
        $status = ($qryData['status'] != null ? $qryData['status'] : null);

        $qry = "SELECT s.*";
        $qry .= " FROM skills AS s";
        $qry .= " WHERE s.company_id = ?";

        if (count($wheres) > 0) {
            $qry .= " AND (" . implode(" $separator ", $wheres) . ")";
        }

        if ($status != null) {
            $values = array_merge($values, [$status]);
            $qry .= " AND s.status = ?";
        } else {
            $qry .= " AND s.status = 'active'";
        }

        $c = $this->Db->query($qry, $values);
        $count = count($c);

        $qry .= " ORDER BY $orderBy";
        $qry .= " LIMIT $qryData[limit]";
        $qry .= " OFFSET $qryData[offset];";

        $rows = $this->Db->query($qry, $values);

        $d = [
            'count' => $count,
            'skills' => $rows,
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

        $name = trim($data['name']);

        if (!$this->isFieldValueUnique('name', $name)) {
            $res['status'] = 'error';
            $res['message'] =  "Skill alreay exists";
            return $res;
        }

        $values = [$this->CompanyId, $name];
        $qry = "insert into skills (`company_id`,`name`) VALUES (?,?)";

        $skillId = $this->Db->insert($qry, $values);

        $res['data'] = [$skillId];

        return $res;
    }

    function delete($id) {
        $qry = "update skills set status = 'deleted', modified=now() where id = ? and company_id = ?;";
        $values = [$id,$this->CompanyId];

        $this->Db->update($qry,$values);

        return true;
    }

    function setSchedule($scheduleId,$ids) {
        $qry = "delete from schedule_skills where schedule_id = ?;";
        $this->Db->delete($qry,[$scheduleId]);

        $idStr = implode(',',$ids);
        $qry = "select id from skills where company_id = ? and id in ($idStr) and status = 'active';";
        $values = [$this->CompanyId];

        $sets = [];

        $rows = $this->Db->query($qry,$values);
        foreach ($rows as $row) {
            $sets[] = "($scheduleId,$row[id])";
        }

        if (count($sets) < 1){
            return;
        }

        $setStr = implode(',',$sets);

        $qry = "insert into schedule_skills (`schedule_id`,`skill_id`) values $setStr;";
        $this->Db->insert($qry,[]);

        return;
    }

    function setEmployee($userId,$ids) {
        $qry = "delete from employee_skills where user_id = ?;";
        $this->Db->delete($qry,[$userId]);

        $idStr = implode(',',$ids);
        $qry = "select id from skills where company_id = ? and id in ($idStr) and status = 'active';";
        $values = [$this->CompanyId];

        $sets = [];

        $rows = $this->Db->query($qry,$values);
        foreach ($rows as $row) {
            $sets[] = "($userId,$row[id])";
        }

        if (count($sets) < 1){
            return;
        }

        $setStr = implode(',',$sets);

        $qry = "insert into employee_skills (`user_id`,`skill_id`) values $setStr;";
        $this->Db->insert($qry,[]);

        return;
    }
}
?>