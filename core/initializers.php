<?php
$dir = ROOT.'/helpers/*';
foreach(glob($dir) as $file) {
    if(!is_dir($file)) { require_once($file);}
}
?>