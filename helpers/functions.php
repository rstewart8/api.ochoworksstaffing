<?php

function numberToTime($number)
{
	$hr = floor($number);
	$min = fmod($number, 1) * 60;
	$pm = 'am';

	if ($hr >= 12) {
		$pm = 'pm';
	}

	if ($hr === 0) {
		$hr = 12;
	}

	if ($hr > 12 && $pm === 'pm') {
		$hr = $hr - 12;
	}

	$minStr = strval($min);

	if (strlen($minStr) < 2) {
		$minStr = "$minStr" . "0";
	}

	if ($number === 24) {
		$pm = 'am';
	}
	return $hr . ':' . $minStr . $pm;

}

function cmp($a, $b) {
	//// Do not change this other functions dependant on it
	$a = date('Y-m-d', strtotime($a));
	$b = date('Y-m-d', strtotime($b));

	if ($a == $b) {
		return 0;
	}
	return ($a < $b) ? -1 : 1;
}

function sortDateArrayAsc($dateArr) {
	usort($dateArr, "cmp");
	return $dateArr;
}

function nowToTimezone($loc) {
	$date = new DateTime("now", new DateTimeZone($loc) );
	return $date->format('Y-m-d');
}

function dateToTimezone($dt,$loc) {
	$d = new DateTime($dt, new DateTimeZone('UTC') );
	$d->setTimezone(new DateTimeZone($loc));
	$dStr = $d->format('Y-m-d H:i:s');
	return $dStr;
}

function dateTimeZoneToUtc($dt,$loc) {
	$d = new DateTime($dt, new DateTimeZone($loc) );
	$d->setTimezone(new DateTimeZone('UTC'));
	$dStr = $d->format('Y-m-d H:i:s');
	return $dStr;
}

function prettyDateToTimezone($dt,$loc) {
	$d = new DateTime($dt, new DateTimeZone('UTC') );
	$d->setTimezone(new DateTimeZone($loc));
	$dStr = $d->format('D M d,Y g:i A');
	return $dStr;
}

function fullStandardDate($date) {
	return date('m/d/Y', strtotime($date));
}

function standardDate($date) {
	return date('n/j/Y', strtotime($date));
}

function mediumDate($date) {
	return date('D M d,Y', strtotime($date));
}

function mediumTime($date) {
	return date('g:ia', strtotime($date));
}

function validateDate($date, $format = 'Y-m-d') {
	$d = DateTime::createFromFormat($format, $date);
	// The Y ( 4 digits year ) returns TRUE for any integer with any number of digits so changing the comparison from == to === fixes the issue.
	return $d && $d->format($format) === $date;
}

function isInDateRange($startDate,$endDate,$checkDate) {
	$t1 = strtotime($startDate);
	$t2 = strtotime($endDate);
	$ck = strtotime($checkDate);
	
	if ($ck >= $t1 && $ck <= $t2) {
		return true;
	}

	return false;
}

function timeDiffInMins($start,$end) {
	$start = new DateTime($start);
	$diff = $start->diff(new DateTime($end));
	$minutes = ($diff->days * 24 * 60) + ($diff->h * 60) + $diff->i;
	return $minutes;
}

function timeDiffInHours($start,$end) {
	$start = new DateTime($start);
	$diff = $start->diff(new DateTime($end));
	$hours = ($diff->days * 24) + ($diff->h) + ($diff->i / 60);
	return $hours;
}

function divideFloat($a, $b, $precision=2) {
	$a*=pow(10, $precision);
	$result=(int)($a / $b);
	if (strlen($result)==$precision) {
	   return '0.' . $result;
	}
	return preg_replace('/(\d{' . $precision . '})$/', '.\1', $result);
}

function dateTimeToUtc($dt=null,$loc=null) {
	if ($dt == null) {
		$d = new DateTime('now', new DateTimeZone('UTC') );
	} else {
		$d = new DateTime($dt, new DateTimeZone($loc) );
		$d->setTimezone(new DateTimeZone('UTC'));
		
	}
	$dStr = $d->format('Y-m-d H:m:s');
	return $dStr;
}

function utcStartOfDay($day,$loc){
	$d = new DateTime($day, new DateTimeZone($loc));
	$d = $d->setTime(0,0,0);
	$d = $d->setTimezone(new DateTimeZone('UTC'));
	$d = $d->format('Y-m-d H:m:s');
	return $d;
}

function utcEndOfDay($day,$loc){
	$d = new DateTime($day, new DateTimeZone($loc));
	$d = $d->setTime(23,59,59);
	$d = $d->setTimezone(new DateTimeZone('UTC'));
	$d = $d->format('Y-m-d H:m:s');
	return $d;
}

function timeToNumber($time) {
	//// $time needs to be in this format 1:15pm

	$offset = 0;
	$mer = substr($time,-2);
	if ($mer == 'pm') {
		$offset = 12;
	}

	$time = substr($time,0,-2);

	$timeArr = explode(':',$time);
	$hour = $timeArr[0];
	$minute = $timeArr[1];

	if ($hour < 12) {
		$hour = $hour + $offset;
	} else if ($hour == 12 && $mer == 'am') {
		$hour = $hour - 12;
	}

	$x = (ceil((($minute/60) + $hour) * 4))/4;

	return $x;
}

function numberToMysqlTime($number) {
	$h = floor($number);
	$x = ($number - $h);
	$m = (string) ($x * 60);
	$h = (string) ($h);

	if (strlen($h) == 1) {
		$h = "0$h";
	}

	if (strlen($m) == 1) {
		$m = "0$m";
	}

	return "$h:$m:00";
}

function firstDayOfWeek($date) {
	$d = date("Y-m-d",strtotime($date)); 
	$x = date("w",strtotime($d));

	if ($x == 0) {
		$x = 7;
	}
	
	return date("Y-m-d", strtotime($d. " - ".($x - 1)." days"));
}

function lastDayOfWeek($date) {
	$d = date("Y-m-d",strtotime($date)); 
	$x = date("w",strtotime($d));

	if ($x == 0) {
		$x = 7;
	}

	return date("Y-m-d", strtotime($d. " + ".(7 - $x)." days"));
}

function mysqlDate($date) {
	$d = null;
	if (!strtotime($date)) {
		return $d;
	}
	try {
		$dt = date_create($date);
		$d = date_format($dt,'Y-m-d');
	} catch (\Throwable $th) {
		//throw $th;
	}
	
	return $d;
}

function stringToNumber($str) {
	//// This removes all non number characters and returns only numbers
	$number = null;
    for ($i = 0;$i < strlen($str); $i++) {
        if (is_numeric($str[$i])) {
            $number = $number.$str[$i];
        }
	}
	
	return $number;
}

function nonNumericFromStr($str) {
	return preg_replace("/[^0-9]/", "", $str );
}

function encryptString($str) {
	$key = SECRETSALT;
	// Remove the base64 encoding from our key
    $encryption_key = base64_decode($key);
    // Generate an initialization vector
    $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length('aes-256-cbc'));
    // Encrypt the data using AES 256 encryption in CBC mode using our encryption key and initialization vector.
    $encrypted = openssl_encrypt($str, 'aes-256-cbc', $encryption_key, 0, $iv);
    // The $iv is just as important as the key for decrypting, so save it with our encrypted data using a unique separator (::)
    return base64_encode($encrypted . '::' . $iv);
}

function decryptString($str) {
	$key = SECRETSALT;
	// Remove the base64 encoding from our key
	$encryption_key = base64_decode($key);
	// To decrypt, split the encrypted data from our IV - our unique separator used was "::"
	list($encrypted_data, $iv) = explode('::', base64_decode($str), 2);
	return openssl_decrypt($encrypted_data, 'aes-256-cbc', $encryption_key, 0, $iv);
}

function prettyAddress($address,$city,$state,$zip){
	$addrArr = [];
	$ctyStZp = null;

	if ($address != null) {
		$addrArr[] = ucwords($address);
	}

	if ($city != null) {
		$ctyStZp = $city;
	}
	
	if ($state != null) {
		if (strlen($state) == 2) {
			$state = strtoupper($state);
		} else {
			$state = ucwords($state);
		}
		$ctyStZp = $ctyStZp.' '.$state;
	}

	if ($zip != null) {
		$ctyStZp = $ctyStZp.' '.$zip;
	}

	if ($ctyStZp != null) {
		$addrArr[] = $ctyStZp;
	}

	return implode(', ',$addrArr);
}

function prettyPhone($number)
{
	// Allow only Digits, remove all other characters.
	$number = preg_replace("/[^\d]/","",$number);

	// get number length.
	$length = strlen($number);

	// if number = 10
	if($length == 10) {
		$number = preg_replace("/^1?(\d{3})(\d{3})(\d{4})$/", "($1) $2-$3", $number);
	}

	return $number;
}

function getHolidayDate($name,$calc,$year) {
	$name = strtolower($name);
	if ($name == 'easter') {
		return easter_date($year);
	}

	$str = str_replace('*yr*',$year,$calc);

	return date('Y-m-d', strtotime($str));

}

function getWorkdays($db,$workdayId,$start,$end,$history=true,$scheduleId=null) {
	$days = [];

	if ($workdayId == null && $scheduleId != null) {
		$qry = "select start,end,workday_id from schedules where id = ?";
		$rows = $db->query($qry,[$scheduleId]);
		if (count($rows) > 0) {
			$workdayId = $rows[0]['workday_id'];

			if ($start == null) {
				$start = $rows[0]['start'];
			}

			if ($end == null) {
				$end = $rows[0]['end'];
			}
		}
	}

	if ( $start == null || $end == null || $workdayId == null) {
		return $days;
	}

	$n = date('Y-m-d');
	if (!$history && strtotime($n) > strtotime($start)) {
		$start = $n;
	}
	$weekdays = [];
	$holidays = [];

	$qry = "select w.no";
	$qry .= " from workday_weekdays as ww";
	$qry .= " join weekdays as w on w.id = ww.weekday_id";
	$qry .= " where ww.workday_id = ?";

	$rows = $db->query($qry,[$workdayId]);

	foreach ($rows as $row) {
		$weekdays[] = $row['no'];
	}

	$qry = "select h.name,h.date";
	$qry .= " from workday_holidays as wh";
	$qry .= " join holidays as h on h.id = wh.holiday_id";
	$qry .= " where wh.workday_id = ?";

	$rows = $db->query($qry,[$workdayId]);

	$chkYear = date("Y",strtotime($start));
	$endYear = date("Y",strtotime($end));

	$cntr = 0;
	while ($chkYear <= $endYear && $cntr < 10) {
		$cntr++;
		foreach ($rows as $row) {
			$holidays[] = getHolidayDate($row['name'],$row['date'],$chkYear);
		}
		$chkYear++;
	}
		
	$chk = $start;
	$chkTs = strtotime($chk);
	$endTs = strtotime($end);
	$cntr = 0;

	while ($chkTs <= $endTs && $cntr < 365) {
		$cntr++;
		$day = date('Y-m-d', $chkTs);
		$dow = date('w',strtotime($day));
		if (!in_array($day,$holidays) && in_array($dow,$weekdays)) {
			$days[] = $day;
		}

		$chkTs = strtotime($day . ' +1 day');
	}

	return $days;
}

function assignedPercentage($filled,$days) {
	if ($days == 0) {
		$filledPerc = 0;
	} elseif ($filled == $days) {
		$filledPerc = 100;

	} elseif ($filled > $days) {
		$filledPerc = ceil($filled/$days*100);
	} else {
		$filledPerc = floor($filled/$days*100);
	}

	if ($filledPerc == 0 && $filled > 0) {
		$filledPerc = 1;
	}

	return $filledPerc;
}

function sanitizeForMySQL($input) {
    // Remove characters that might be harmful in MySQL
    $sanitized = preg_replace('/[^\w\s@.-]/', '', $input);
    return $sanitized;
}

