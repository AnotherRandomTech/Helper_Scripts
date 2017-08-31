<?php
$hostname='{<Mail Server Hostname Here>:993/imap/ssl}INBOX';
$username = '<login email here>';
$password = '<password here>';

$mbox = imap_open($hostname,$username,$password) or die('Cannot connect to Tiriyo: ' . imap_last_error());
$status=imap_status($mbox,$hostname,SA_ALL);
if ($status) {
echo "Email: " , $username , "
\n";
echo "Messages: " . $status->messages . "
\n";
echo "Recent: " . $status->recent . "
\n";
echo "Unseen: " . $status->unseen . "
\n";

} 
else {
echo "imap_status failed: " . imap_last_error() . "\n";
}

?>
