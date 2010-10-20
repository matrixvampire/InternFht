<?

/**
* HTTP POST from PHP, without cURL
* Wez Furlong
* Software Architect, OpenSourceror
* URL : http://wezfurlong.org/blog/2006/nov/http-post-from-php-without-curl
*/

function do_post_request($url, $data, $optional_headers)
{
  $params = array('http' => array(
              'method' => 'POST',
              'content' => $data
            ));
            
  if ($optional_headers !== null) {
    $params['http']['header'] = $optional_headers;
  }
  $ctx = stream_context_create($params);
  $fp = @fopen($url, 'r', false, $ctx);
  if (!$fp) {
      throw new Exception("Problem with $url, $php_errormsg");
  }

  $response = @stream_get_contents($fp);
  if ($response === false) {
    throw new Exception("Problem reading data from $url, $php_errormsg");
  }
  
  return $response;
  
}
?>
