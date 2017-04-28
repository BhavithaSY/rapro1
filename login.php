<?PHP
// STEP-1 declare parameters of user info
//echo "hiiiii";
$email = htmlentities($_REQUEST["email"]);
$password = htmlentities($_REQUEST["password"]);
if (empty($password) || empty($email)) 
{
//echo "not empty";
	$returnArray["status"]="400";
	$returnArray["Message"]="Missing required data";
	echo json_encode($returnArray);
	return;
}
$file = parse_ini_file("DataCollectionTool.ini");
$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);
require("secure/access.php");
$access = new access($host,$user,$pass,$name);
$access->connect();
$result = $access->loginUser($email,$password);
//echo "Result is $result";
if($result)
{
	//$user = $access->selectUser($username);
//echo json_encode($user);
	$returnArray["status"] = "200";
	$returnArray["message"] = "sucessfully logedin";
	$returnArray["Date"] = $result["date"];
	$returnArray["UserName"] = $result["username"];
	$returnArray["Email"] = $result["email"];
	$returnArray["FirstTimeLogin"]=$result["firstTimeLogin"];

//echo "The user ino is $returnArray";
	//STEP-5 json data printing
echo json_encode($returnArray);
}
else
{
	$returnArray["status"] = "400";
	$returnArray["Message"] = "No such user Exists";
	echo json_encode($returnArray);
	
}
//STEP-4 close connection
$access->disconnect();