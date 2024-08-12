<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$path = realpath(__DIR__ . '/../..');
require_once($path.'/configs/constants.php');
require_once($path.'/libs/logger.php');
require_once($path.'/libs/randomStringifier.php');
require_once($path.'/core/database.php');
$logger = new Logger();	
$db = new Database($logger);

function randomSelectFromArray($array, $n) {
    $keys = array_rand($array, $n);
    $randomItems = array();
    if (!is_array($keys)) {
        $keys = array($keys);
    }
    foreach ($keys as $key) {
        $randomItems[] = $array[$key];
    }
    return $randomItems;
}

$qry = "select id from weekdays";
$rows = $db->query($qry,[]);

$qry = "select id from users where identity_id = 3 and status = 'active';";
$users = $db->query($qry,[]);
$logger->info("users ".print_r($users,true));
foreach ($users as $user) {
    $id = $user['id'];
    $qry = "delete from schedule_assignments where user_id = ?";
    $db->delete($qry,[$id]);

    $qry = "delete from employee_weekdays where user_id = ?";
    $db->delete($qry,[$id]);

    $numberOfWeekdays = random_int(1,count($rows));
    $weekdays = randomSelectFromArray($rows,$numberOfWeekdays);
    $logger->info("weekdays: ".print_r($weekdays,true));
    foreach ($weekdays as $weekday) {
        $weekdayId = $weekday['id'];
        $logger->info("weekday: ",print_r($weekday,true));
        $qry = "insert into employee_weekdays (user_id,weekday_id) values (?,?)";
        $db->insert($qry,[$id,$weekdayId]);
    }

}

?>