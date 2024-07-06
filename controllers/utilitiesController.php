<?php

/**
 *
 */

require_once(ROOT . "/models/utilitiesModel.php");

class Utilities
{
    var $Res;
    var $Logger;
    var $User;
    var $Utilities;
    var $CompanyId;

    function __construct($db, $logger = null, $user = null)
    {
        $this->Res = [
            'status'         => 'ok',
            'message'        => null,
            'data'            => []
        ];
        $this->Logger = $logger;
        $this->User = $user;
        $this->CompanyId = $user['companyid'];
        $this->Utilities = new UtilitiesModel($db, $logger, $this->CompanyId);
    }

    function states()
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->states();
        return $ret;
    }

    function roles()
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->roles();
        return $ret;
    }

    function payWeeks($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        if (isset($data['day'])) {
            $d = $data['day'];
            $x = date("w", strtotime($d));
            if ($x == 0) {
                $x = 7;
            }
            $lastDay = date("Y-m-d", strtotime($d . "+" . (7 - $x) . " days"));
        } else {
            $d = date("Y-m-d", strtotime("- 1 year"));
            $x = date('w');
            if ($x == 0) {
                $x = 7;
            }
            $lastDay = date("Y-m-d", strtotime("+" . (7 - $x) . " days"));
        }

        $x = date("w", strtotime($d));
        if ($x == 0) {
            $x = 7;
        }


        $offset = $x - 1;
        $dStr = "$d - $offset days";

        //$firstOfWeek = date("Y-m-d", strtotime($d. " - ".($x - 1)." days"));
        $firstOfWeek = date("Y-m-d", strtotime($dStr));
        $endOfWeek = date("Y-m-d", strtotime($firstOfWeek . " + 6 days"));

        $weeks = [];
        $cntr = 0; //// Just in case
        while ($lastDay >= $endOfWeek && $cntr < 60) {
            $cntr++;
            $weeks[] =
                [
                    'week' => $cntr,
                    'firstOfWeek' => $firstOfWeek,
                    'endOfWeek' => $endOfWeek,
                    'prettyFirstOfWeek' => standardDate($firstOfWeek),
                    'prettyEndOfWeek' => standardDate($endOfWeek)
                ];

            $firstOfWeek = date("Y-m-d", strtotime($firstOfWeek . " + 7 days"));
            $endOfWeek = date("Y-m-d", strtotime($endOfWeek . " + 7 days"));
        }

        $ret['data'] = $weeks;
        return $ret;
    }

    function shifts($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->shifts();
        return $ret;
    }

    function paymentMethods($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->paymentMethods();
        return $ret;
    }

    function companys($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => []);

        $ret['data']['companys'] = $this->Utilities->companys();
        return $ret;
    }

    function weekdays($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->weekdays();
        return $ret;
    }

    function holidays($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->holidays();
        return $ret;
    }

    function workdays($data = null)
    {
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->workdays();
        return $ret;
    }

    function scheduleTimes($data=null){
        $ret = array('status' => 'ok', 'message' => '', 'data' => '');

        $ret['data'] = $this->Utilities->scheduleTimes();
        return $ret;
    }
}
