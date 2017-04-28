<?PHP

// STEP-1 declare parameters of user info
//echo "hiiiii";

$email = htmlentities($_REQUEST["email"]);
$pathforfile = htmlentities($_REQUEST["pathforfile"]);


if (empty($email) || empty($pathforfile) ){
//echo "not empty";
	$returnArray["status"]="400";
	$returnArray["Message"]="Missing required data";
	echo json_encode($returnArray);
	return;
}
//echo "username is $username";
//secure password
//STEP-2 Build connection
//store php var info from ini var
$file = parse_ini_file("DataCollectionTool.ini");
$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

require("secure/access.php");
$access = new access($host,$user,$pass,$name);
$access->connect();

//STEP-3 register or insert user information

$result = $access->savefilepath($email,$pathforfile);
//echo "Result is $result";
if($result)
{
	$user = $access->selectUser($username);
//echo json_encode($user);
	$returnArray["status"] = "200";
	$returnArray["message"] = "sucessfully saved location";
	

//echo "The user ino is $returnArray";
	//STEP-5 json data printing
echo json_encode($returnArray);
}
else
{
	$returnArray["status"] = "400";
	$returnArray["Message"] = "could not save location with provided info";
	echo json_encode($returnArray);

	
}

//STEP-4 close connection

$access->disconnect();

//STEP-5 json data

?>