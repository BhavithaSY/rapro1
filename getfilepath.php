<?PHP

// STEP-1 declare parameters of user info
//echo "hiiiii";

$email = htmlentities($_REQUEST["email"]);

if (empty($email)) 
{
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

$result = $access->getpath($email);
//echo "Result is $result";
if($result)
{
	
//echo json_encode($user);
	//$returnArray["filepath"]=$result["filelocation"];
	$returnArray=$result;
	// $returnArray["message"] = "sucessfully registered";
	// $returnArray["Date"] = $user["date"];
	// $returnArray["UserName"] = $user["username"];
	// $returnArray["Email"] = $user["email"];

//echo "The user ino is $returnArray";
	//STEP-5 json data printing
echo json_encode($returnArray);
}
else
{
	$returnArray["status"] = "400";
	$returnArray["Message"] = "could not register with provided info";
	
	
}

//STEP-4 close connection

$access->disconnect();

//STEP-5 json data
echo json_encode($returnArray);

?>