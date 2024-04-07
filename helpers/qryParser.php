<?php

function qryParser($data) {
    return [
        'page' => (isset($data['page']) ? $data['page'] : null),
        'limit' => (isset($data['pagesize']) ? $data['pagesize'] : null),
        'search' => (isset($data['search']) ? $data['search'] : null),
        'searchBy' => (isset($data['searchby']) ? $data['searchby'] : null),
        'filter' => (isset($data['filter']) ? $data['filter'] : null),
        'orderBy' => (isset($data['orderby']) ? $data['orderby'] : null) 
    ];
}
?>