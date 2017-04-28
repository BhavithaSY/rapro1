<?PHP

// STEP-1 declare parameters of user info
//echo "hiiiii";
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);
$email = htmlentities($_REQUEST["email"]);

if (empty($username) || empty($password) || empty($email)) {
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

$result = $access->registerUser($username,$password,$email);
//echo "Result is $result";
if($result)
{
	$user = $access->selectUser($username);
//echo json_encode($user);
	$returnArray["status"] = "200";
	$returnArray["message"] = "sucessfully registered";
	$returnArray["Date"] = $user["date"];
	$returnArray["UserName"] = $user["username"];
	$returnArray["Email"] = $user["email"];

//adding default categories
	//$rescatid=$access->generateCID();
	//$rescatid1=1;
	$Cname1="Focus Group";
	$CSubtitle1="Testing the usage of each developed product";
	//$rescatid2=2;
	$Cname2="Usability Study";
	$CSubtitle2="Requirements gathering observations";
	//$rescatid3=3;
	$Cname3="Dynamic Event Observation";
	$CSubtitle3="Testing the products in mobile environment";

		$rescatid1=$access->generateCID();
 		$resinscat1=$access->insertCategory($rescatid1,$email,$Cname1,$CSubtitle1);
 		$rescatid2=$access->generateCID();
 		$resinscat2=$access->insertCategory($rescatid2,$email,$Cname2,$CSubtitle2);
 		$rescatid3=$access->generateCID();
 		$resinscat3=$access->insertCategory($rescatid3,$email,$Cname3,$CSubtitle3);



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