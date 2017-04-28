<?PHP

// STEP-1 declare parameters of user info
//echo "hiiiii";
$rescatid = htmlentities($_REQUEST["categoryID"]);
$taskname = htmlentities($_REQUEST["taskname"]);
$col1='col1';
$col2='col2';
$col3='col3';
$col4='col4';
$num=2;
//$addedcat = htmlentities($_REQUEST["addedcate"]);
//$firstlogin = htmlentities($_REQUEST["firslogin"]);
//$email = htmlentities($_REQUEST["email"]);

if (empty($rescatid)){
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

$restid=$access->generateTID();
$resinsTask=$access->insertTasks($restid,$rescatid,$taskname);
//print($resinsTask);
if($restid)
{
for($j = 0; $j<4; $j++)
			{
			//call columns inserting function here
			if ($j==0)
			{
			$resinscol=$access->insertColumn($restid,$rescatid,$col1);
			}
			elseif ($j==1) {
				$resinscol=$access->insertColumn($restid,$rescatid,$col2);
			}
			elseif ($j==2) {
				$resinscol=$access->insertColumn($restid,$rescatid,$col3);
			}
			else  {
				$resinscol=$access->insertColumn($restid,$rescatid,$col4);
			}
		}
$returnArray["status"]="200";
		$returnArray["Message"]="successfully inserted";
echo json_encode($returnArray);
}
else
{
	$returnArray["status"] = "400";
	$returnArray["Message"] = "could not getTasks with provided info";
	echo json_encode($returnArray);
	
}

//STEP-4 close connection

$access->disconnect();

//STEP-5 json data
//echo json_encode($returnArray);

?>