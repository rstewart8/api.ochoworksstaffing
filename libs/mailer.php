<?php
/**
 * 
 */

// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
require_once(ROOT.'/vendor/autoload.php');

class Mailer {
	
	function __construct($logger=null) {
		$this->logger = $logger;

		try {
			$this->mail = new PHPMailer(true); 		//Passing true enables exceptions
			$this->mail->SMTPDebug = 2;				// Enable verbose debug output
			$this->mail->isSMTP();					// Set mailer to use SMTP
			$this->mail->Host = MAILERHOST;			// Specify main and backup SMTP servers
			$this->mail->SMTPAuth = true;			// Enable SMTP authentication
			$this->mail->Username = MAILERUSER;		// SMTP username
			$this->mail->Password = MAILERPASSWORD; // SMTP password
			$this->mail->SMTPSecure = 'tls';		// Enable TLS encryption, `ssl` also accepted
			$this->mail->Port = MAILERPORT;			// TCP port to connect to
			$this->mail->setFrom('reply@srammer.com');
			$this->mail->isHTML(true);
		} catch (Exception $e) {
			$this->logger->error("Mailer Error: ".$this->mail->ErrorInfo);
			return false;
		} 

		return true;                        
	}

	public function setFrom($from) {
		
	}

	public function addAddress($address,$recipient=null) {
		try{
			$this->mail->addAddress($address,$recipient);     // Add a recipient
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function addReplyTo($address,$recipient=null) {
		try{
			$this->mail->addReplyTo($address,$recipient);
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function addCC($address) {
		try{
			$this->mail->addCC($address);
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function addBcc($address) {
		try{
			$this->mail->addBCC($address);
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function addAttachment($attachment,$name=null) {
		try{
			$this->mail->addAttachment($attachment,$name);         // Add attachments
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function isHtml($isHtml) {
		try{
			if ($isHtml) {
				$this->mail->isHTML(true);
			}
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function subject($subject) {
		try{
			$this->mail->Subject = $subject;
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function body($body) {
		try{
			$this->mail->Body = $body;
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function altBody($altBody) {
		try{
			$this->mail->AltBody = $altBody;
		} catch (Exception $e) {
			$this->logger->error("mail create Error: ".$this->mail->ErrorInfo);
			return false;
		}
		return true;
	}

	public function sendIt() {
		$ret = ['status' => 'error','message' => 'WTF, email not sent'];

		try{
			if ($this->mail->send() == 1) {
				$ret['status'] = 'ok';
				$ret['message'] = null;
			}

		} catch (Exception $e) {
			$this->logger->error("Mailer Sending Error: ".$this->mail->ErrorInfo);
			$ret['status'] = 'error';
			$ret['message'] = $this->mail->ErrorInfo;
		} 

		return $ret;
	}
}

?>