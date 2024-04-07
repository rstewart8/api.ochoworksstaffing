<?php

function qryBuilder($data,$pre,$fields) {
    
    //// These fields will need to be set up when models are built.
    switch ($fields) {
        case 'user':
            $searchFields = unserialize(USERSEARCHFIELDS);
            $orderFields = unserialize(USERORDERFIELDS);
            break;

        case 'job':
            $searchFields = unserialize(JOBSEARCHFIELDS);
            $orderFields = unserialize(JOBORDERFIELDS);
            break;

        case 'client':
            $searchFields = unserialize(CLIENTSEARCHFIELDS);
            $orderFields = unserialize(CLIENTORDERFIELDS);
            break;

        case 'schedule':
            $searchFields = unserialize(SCHEDULESEARCHFIELDS);
            $orderFields = unserialize(SCHEDULEORDERFIELDS);
            break;

        case 'skill':
            $searchFields = unserialize(SKILLSEARCHFIELDS);
            $orderFields = unserialize(SKILLORDERFIELDS);
            break;

        case 'workday':
            $searchFields = unserialize(WORKDAYSEARCHFIELDS);
            $orderFields = unserialize(WORKDAYORDERFIELDS);
            break;

        default:
            break;
    }

    $page = (isset($data['page']) ? $data['page'] : 0);
    $limit = (isset($data['pagesize']) ? $data['pagesize'] : null);
    $search = (isset($data['search']) ? $data['search'] : null);
    $searchBy = (isset($data['searchby']) ? $data['searchby'] : null);
    $filter = (isset($data['filter']) ? $data['filter'] : null);
    $orderBy = (isset($data['orderby']) ? $data['orderby'] : null);
    $status = (isset($data['status']) ? $data['status'] : null);
    $separator = 'or';
    $orderField = null;
    $dir = null;

    $wheres = [];
    $values = [];

    if ($filter) {
        $separator = 'and';
        $searchAbles = explode(',',$filter);
        foreach ($searchAbles as $searchAble) {
            $v = explode('=',$searchAble);

            if (!in_array($v[0],$searchFields) ) {
                continue;
            }

            if (count($v) < 2) {
                continue;
            }

            $val = "$v[1]";
            
            array_push($wheres,"$pre.$v[0] LIKE ?");
            array_push($values,$val);
        }
    } elseif ($search) {
        foreach ($searchFields as $field ) {
            if ($field != 'status') {
                array_push($wheres,"$pre.$field LIKE ?");
                array_push($values,"%$search%");
            }
        }
    } elseif ($searchBy) {
        $searchAbles = explode(',',$searchBy);
        foreach ($searchAbles as $searchAble) {
            $v = explode('=',$searchAble);

            if (!in_array($v[0],$searchFields) ) {
                continue;
            }

            $val = "%$v[1]%";

            if ($v[0] == 'status') {
                $val = $v[1];
            }
            
            array_push($wheres,"$pre.$v[0] LIKE ?");
            array_push($values,$val);
        }
    }

    $l = ($limit == null || $limit > MAXQRYLIMIT ? MAXQRYLIMIT : $limit);
    $offset = ($page == null ? 0 : $page);
    $offset = $offset * $l;

    if ($orderBy) {
        $dir = 'ASC';
        $v = explode('=',$orderBy);

        if (in_array($v[0],$orderFields) ) {
            if (count($v) == 2) {
                $v[1] = strtoupper($v[1]);
                if ($v[1] == 'ASC' || $v[1] == 'DESC') {
                    $dir = $v[1];
                }
            }
            $orderField = "$pre.$v[0] $dir";
        }
    }

    return [
        'wheres' => $wheres,
        'values' => $values,
        'limit' => $l,
        'order' => $orderField,
        'offset' => $offset,
        'separator' => $separator,
        'status' => $status
    ];
}
?>