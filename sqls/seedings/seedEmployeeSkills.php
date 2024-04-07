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

$qry = "select id from skills where status = 'active'";
$rows = $db->query($qry,[]);

$qry = "select id from users where identity_id = 3 and status = 'active';";
$users = $db->query($qry,[]);
$logger->info("users ".print_r($users,true));
foreach ($users as $user) {
    $id = $user['id'];
    $qry = "delete from schedule_assignments where user_id = ?";
    $db->delete($qry,[$id]);

    $qry = "delete from employee_skills where user_id = ?";
    $db->delete($qry,[$id]);

    $numberOfSkills = random_int(1,count($rows));
    $skills = randomSelectFromArray($rows,$numberOfSkills);
    $logger->info("skills ".print_r($skills,true));
    foreach ($skills as $skill) {
        $skillId = $skill['id'];
        $logger->info("skill ",print_r($skill,true));
        $qry = "insert into employee_skills (user_id,skill_id) values (?,?)";
        $db->insert($qry,[$id,$skillId]);
    }

}

?>