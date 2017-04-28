<?PHP
// STEP-1 declare parameters of user info
//echo "hiiiii";
//$email = htmlentities($_REQUEST["email"]);
//$firstLogin = htmlentities($_REQUEST["firstLogin"]);
//$addcat = htmlentities($_REQUEST["addcat"]);
$observeddata=htmlentities($_REQUEST["observeddata"]);
if (empty($observeddata)) 
{
//echo "not empty";
	$returnArray["status"]="400";
	$returnArray["Message"]="Missing required data";
	echo json_encode($returnArray);
	return;
	echo "$observeddata";
}
// $file = parse_ini_file("DataCollectionTool.ini");
// $host = trim($file["dbhost"]);
// $user = trim($file["dbuser"]);
// $pass = trim($file["dbpass"]);
// $name = trim($file["dbname"]);
// require("secure/access.php");
// $access = new access($host,$user,$pass,$name);
// $access->connect();
// $result = $access->categoriesdata($email,$firstLogin,$addcat);
// if($firstLogin==1)
// {
// 	//echo "enterdGGGGG";
// $access->updateloginstatus($email,$firstLogin);
// }
// if($result)
// {
// 	//echo "res is  $result[0]";
// $num=count($result);
// //echo "$num";
// for ($i = 0; $i < $num; $i++)
// {
	
// $returnArray[$i]=$result[$i];
// 	}
// // $returnArray["cid"]=$result["CID"];
// // $returnArray["cname"]=$result["CName"];
// // $returnArray["csub"]=$result["Csubtitle"];
// echo json_encode($returnArray);
// } 
// else
// {
// 	$returnArray["flagging"]="0";
// 	$returnArray["Message"] = "No such user Exists";
// 	echo json_encode($returnArray);
// }
// //echo "Result is $result";
// // if($result1)
// // {
// // 	//$user = $access->selectUser($username);
// // //echo json_encode($user);
// // 	//$returnArray["status"] = "200";
// // 	$returnArray1=$result1;
// // 	// $returnArray["Cid"] = $result["CID"];
// // 	// $returnArray["Cname"] = $result["CName"];
// // 	// $returnArray["Csubtitle"] = $result["Csubtitle"];
	
	
	
	
// // //echo "The user ino is $returnArray";
// // 	//STEP-5 json data printing
// // 	echo "$returnArray1";
// // echo json_encode($returnArray1);
// // }
// // else
// // {
// // 	//$returnArray["status"] = "400";
// // 	$returnArray1["flagging"]="0";
// // 	$returnArray1["Message"] = "No such user Exists";
// // 	echo json_encode($returnArray1);
	
// // }
// //STEP-4 close connection
echo json_encode($observeddata);
 $access->disconnect();