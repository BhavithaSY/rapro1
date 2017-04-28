<?PHP

// STEP-1 declare parameters of user info
//echo "entered";
$Cname = htmlentities($_REQUEST["CName"]);
$Csubtitle = htmlentities($_REQUEST["Csubtitle"]);
$email = htmlentities($_REQUEST["email"]);
//$tasksnumb = htmlentities($_REQUEST["numbtasks"]);
//$colsnumb = htmlentities($_REQUEST["numbcols"]);
//$col1 = htmlentities($_REQUEST["colname1"]);
//$col2 = htmlentities($_REQUEST["colname2"]);
//$col3 = htmlentities($_REQUEST["colname3"]);
//$col4 = htmlentities($_REQUEST["colname4"]);
//$colsarray = array($col1,$col2,$col3,$col4);
//list($co1,$co2,$co3,$co4)=$colsarray;
//echo "end";
if (empty($Cname) || empty($email) || empty($Csubtitle))
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
//echo "re";
//STEP-3
$rescategory=$access->getCatName($email,$Cname);
//echo json_encode($rescategory);
if($rescategory)
{
	$num=count($rescategory);
	for($i=0;$i<$num;$i++)
	{
		$namesarray[$i]=$rescategory[$i]["CName"];

	}
	if(in_array(strtolower($Cname), array_map('strtolower', $namesarray)))
	{
		$returnArray["status"]="500";
		$returnArray["Message"]="same name exists";
		echo json_encode($returnArray);
		return;
	}
	else
	{
		$rescatid=$access->generateCID();
 		$resinscat=$access->insertCategory($rescatid,$email,$Cname,$Csubtitle);
 
 // 		for ($i = 0; $i < $tasksnumb; $i++)
	// 	{
	
	// 		$restid=$access->generateTID();

	// 		//also call inserting tasks function here
	// 		$resinsTask=$access->insertTasks($restid,$rescatid);

	// 		//columns
	// 		for($j = 0; $j<4; $j++)
	// 		{
	// 		//call columns inserting function here
	// 		if ($j==0)
	// 		{
	// 		$resinscol=$access->insertColumn($restid,$rescatid,$col1);
	// 		}
	// 		elseif ($j==1) {
	// 			$resinscol=$access->insertColumn($restid,$rescatid,$col2);
	// 		}
	// 		elseif ($j==2) {
	// 			$resinscol=$access->insertColumn($restid,$rescatid,$col3);
	// 		}
	// 		else  {
	// 			$resinscol=$access->insertColumn($restid,$rescatid,$col4);
	// 		}
	// 	}
		
	// }
	$returnArray["status"]="200";
		$returnArray["Message"]="successfully inserted";
echo json_encode($returnArray);
}

}


// //STEP-4 close connection

$access->disconnect();

//STEP-5 json data
//echo json_encode($returnArray);

?>