<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Basics - Divide by Zero</title>
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
	<li><a href="index.php">Problem Set
	1</a></li>
</ul>
</div>

</div>
<div id="content">
<h2>Divide by zero</h2>

Today's Date : <? echo date('l jS \of F Y h:i:s A'); ?>
<br /><br />
<h5>About to divide by zero</h5>

<?
$num1=10;
$num2=0;

error_log("About to divide by zero - Web4");

$answer=$num1/$num2;

echo "<pre>";
print_r(error_get_last());
echo "</pre>";
?>
<br />
<hr />
<a href="views/my-first-program.view.php" target="_blank" style="margin: 3px;">View Source</a>
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
<h1><a href="http://freethoughts.ftmblog.com">Copyrights
&copy;FTM</a></h1>
</div>
</div>
</body>
</html>
