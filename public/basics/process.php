<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Detail Page</title>
<meta name="description" content="Web4 - WAE Group 4" />
<meta name="author" content="Web4 Group" />
<meta name="Charset" content="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="touching.css" type="text/css" />
</head>
<body>
<div id="container">
<div id="banner">
<div id='bannertitle'><a href="http://web4.cs.ait.ac.th">Web Application Engineering - Group 4</a></div>
</div>

<div id="outer">
<div id="inner">
<div id="left">
<div class="verticalmenu">
<ul>
	<li><a href="index.php">Assignment 1</a></li>
</ul>
</div>

</div>
<div id="content">
<?
require 'post.php';

//Get POST data
$SName = $_POST['SName'];

//URL to query
$url = "http://www.asdu.ait.ac.th/PloneAPI/AdvSearch/assets/PDirectory/PDSearch.cfm";

//Data to be sent as POST
$data = "SName=".$SName."";

//Call do_post_request()
$result = do_post_request($url, $data, null);

//echo $result;

//Get Unique Array List of Emails
$emails = array_unique(get_emails($result));

//Create List
$str = "<ul>";

echo "Email Address related to ". $SName." ----- ";

foreach($emails as $e)
$str.= "<li>".$e."</li>";
$str.= "</ul>";

//Output List
echo $str;

?> <?
/*
 Snippet Name: Get Emails from Strings
 Author : Hermawan Haryanto
 Email : hermawan@codewalkers.com
 Homepage: http://hermawan.com
 Blog : http://hermawan.codewalkers.com
 Url : http://www.codewalkers.com/c/a/Email-Code/Get-Email-Addresses-from-Strings/
 */

function get_emails ($str)
{
$emails = array();
preg_match_all("/\b\w+\@\w+[\.\w+]+\b/", $str, $output);
foreach($output[0] as $email)
array_push ($emails, strtolower($email));
if (count ($emails) >= 1)
return $emails;
else
return false;
}
?>
<form><input type="button" onclick="javascript:history.back()"
	value="Back"></form>
<br />
<hr />
<a href="views/process.view.php" target="_blank" style="margin: 3px;">View Source</a>
<hr />
<br />
</div>
<div id="floatR"><a
	href="http://validator.w3.org/check?uri=referer"><img 
	style="border: 0; width: 88px; height: 31px"
	src="http://www.w3.org/Icons/valid-xhtml10"
	alt="Valid XHTML 1.0 Transitional" height="31" width="88" /></a> <a
	href="http://jigsaw.w3.org/css-validator/check/referer"> <img
	style="border: 0; width: 88px; height: 31px"
	src="http://jigsaw.w3.org/css-validator/images/vcss" alt="Valid CSS!" />
</a></div>
</div>
</div>
<div id="footer">
<h1><a href="http://freethoughts.ftmblog.com">Copyrights &copy;FTM</a></h1>
</div>
</div>
</body>
</html>
