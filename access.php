<?PHP
 class access
    {
        //connection global variables
        var $host =null;
        var $user = null;
        var $pass = null;
        var $name = null;
        var $conn = null;
        var $result = null;
        
        //constructing class
        function __construct($dbhost,$dbuser,$dbpass,$dbname)
        {
            $this->host=$dbhost;
            $this->user=$dbuser;
            $this->pass=$dbpass;
            $this->name=$dbname;
        }
        //connection function
        public function connect()
        {
            //echo "Hello";
            $this->conn=new mysqli($this->host,$this->user,$this->pass,$this->name);
            if(mysqli_connect_errno())
            {
                //echo "could not connect to database";
            }else
            {
                //echo "Connected";
            }
            //support all languages
            $this->conn->set_charset("utf8");
            
        }
        //disconneting file
        public function disconnect()
        {
            //echo "entered disconnect";
            if($this->conn != null)
            {
                $this->conn->close();
            }
        }
       // inserting user details
        public function registerUser($username,$password,$email)
        {
            //echo "enetred register user";
            //SQL COMMAND
           // $sql = "INSERT INTO users SET username = ?, password = ?, email = ?";
            $sql = "INSERT INTO users (username,password,email) VALUES (?, ?, ?)";
            //store query result in $statement
           $statement = $this->conn->prepare($sql);
           //if error
           if(!$statement)
           {
            throw new Exception($statement->error);
           }
           //bind 3 parameters of type string to be placed in sql command
           $statement->bind_param("sss", $username, $password, $email);
           // $statement->bindparam(1,$username);
           // $statement->bindparam(2,$password);
           // $statement->bindparam(3,$email);
           $returnValue = $statement->execute();
           //echo "return value is $returnValue :::::::";
           return $returnValue;
        }
        //save location of file
        public function savefilepath($email,$pathforfile)
        {
          //echo "reached";
         $sql = "UPDATE users SET filelocation=? WHERE email=?"; 
         $statement=$this->conn->prepare($sql);
         if(!$statement)
           {
            //echo $pathforfile;
            throw new Exception($statement->error);
           }
           $statement->bind_param("ss", $pathforfile,$email);
           $returnValue = $statement->execute();
           //echo $returnValue;
            return $returnValue;


        }
        //select user information
        public function selectUser($username)
        {
            //echo("entered selsected user");
            $sql = "SELECT * FROM users WHERE username='". $username."'";
            //assign result we got from sql to $result var
            $result = $this->conn->query($sql);
            if ($result != null && (mysqli_num_rows($result) >= 1))
            {
               
                $row = $result->fetch_array(MYSQLI_ASSOC);
                if (!empty($row))
                {
                    
                    $returnArray = $row;
                }
            }
            
            return $returnArray;
        }
        //get the file url
        public function getpath($email)
        {
        	$sql = "SELECT filelocation FROM users WHERE email='". $email."'";
        	$result = $this->conn->query($sql);

            if ($result != null && (mysqli_num_rows($result) == 1))
            {
               
                $row = $result->fetch_array(MYSQLI_ASSOC);
                if (!empty($row))
                {
                    
                    $returnArray = $row;
                }
            }
            
            return $returnArray;
        }
        //get cat name to check with given cat name to avoid duplicates
        public function getCatName($email,$name)
        {
          //echo "came";
          $catsnames=array();
          $sql="SELECT CName FROM Categories WHERE email='". $email."'";
          $result = $this->conn->query($sql);
          if ($result != null && (mysqli_num_rows($result) > 0))
            {
              $ee=mysqli_num_rows($result);
                //echo "$ee";
                while($row=$result->fetch_assoc())
            {
                //echo json_encode($row);

                array_push($catsnames,$row);
            }
     
                if (!empty($catsnames))
                {
                  //echo json_encode($catsnames);
                   //echo "entered not empty of select ser and the row is $row";
                    $returnArray = $catsnames;
                    //echo json_encode($returnArray);
                }
            }
            else
            {
              //$returnArray = ["nothing","no"];
                //echo "enterd null";
            }
            //echo json_encode($categories);
          // echo "\n The array is $categories";
            //echo json_encode($returnArray);
            return $returnArray;

        }
        //login check up
        public function loginUser($email,$password)
        {
            
            $sql = "SELECT * FROM users WHERE email='". $email."' AND password='". $password."'";
            //assign result we got from sql to $result var
            $result = $this->conn->query($sql);
            if ($result != null && (mysqli_num_rows($result) == 1))
            {
               
                $row = $result->fetch_array(MYSQLI_ASSOC);
                if (!empty($row))
                {
                    
                    $returnArray = $row;
                }
            }
            
            //echo json_encode($returnArray);
           // echo "The array is $returnArray";
            return $returnArray;
        }
public function categoriesdata($email)
        {
            //echo "entered";
            $categories=array();
         // if($firstlogin == 1 && $addcat == 2)
         //     {
         //       // echo " is 1";
         //        $sql = "SELECT * FROM CategoriesDefault";
         //    //echo"$sql";
         //        if ($this->conn != null)
         //        { 
         //            //echo "not null";
         //            $result = $this->conn->query($sql);
         //        }
         //        else
         //        {
         //            //echo "is null";
         //        }
            
         //    //echo "$result";
         //    }
            //  else
            // {
                //echo "is 0";
                $sql = "SELECT * FROM Categories WHERE email='". $email."'";
               if ($this->conn != null)
                { 
                    //echo "not null";
                    $result = $this->conn->query($sql);
                }
                else
                {
                   // echo "is null";
                }
                //echo "$result";
            // }
            //echo "passes";
            //echo"$sql";
            

            if ($result != null && (mysqli_num_rows($result) > 0))
            {
                //echo "entered if of select user";
               // $row = $result->fetch_array(MYSQLI_ASSOC);
                //echo "entered if";
                while($row=$result->fetch_assoc())
            {
                //echo "row is $row";

                array_push($categories,$row);
            }
     
                if (!empty($categories))
                {
                   // echo "entered not empty of select ser and the row is $row";
                    $returnArray = $categories;
                }
            }
            else
            {
                //echo "enterd null";
            }
            //echo json_encode($categories);
          // echo "\n The array is $categories";
            return $returnArray;
        }

public function updateloginstatus($email,$firstlogin)
        {
            //echo"enterd update";
            
                $sql = "UPDATE users SET firstTimeLogin = 2 WHERE email='". $email."'";
                $result = $this->conn->query($sql);
                $statement = $this->conn->prepare($sql);

                if(!$statement)
                {
                    throw new Exception($statement->error);
                }
                $returnValue = $statement->execute();
            //echo"return is $returnValue.  ";
                //return $returnValue;
        }
public function generateCID()
{
    //echo "entered";
    $cid=0;
    $count=0;
    while ($count==0) {
       $num=rand(1,100000);
        $sql="SELECT * FROM Categories WHERE CID=$num";
       $result = $this->conn->query($sql);
       if ($result != null && (mysqli_num_rows($result) > 0))
            {
                $count=0;
            }
        else
            {
                $count=1;
                $cid=$num;
            }
    }

            return $num;
}
public function generateTID()
{
    //echo "entered";
    $cid=0;
    $count=0;
    while ($count==0) {
       $num=rand(1,100000);
        $sql="SELECT * FROM Tasks WHERE TID=$num";
       $result = $this->conn->query($sql);
       if ($result != null && (mysqli_num_rows($result) > 0))
            {
                $count=0;
            }
        else
            {
                $count=1;
                $cid=$num;
            }
    }
//print($num);
            return $num;
}

public function insertCategory($rescatid,$email,$Cname,$Csubtitle)
{
    //echo "enetred register user";
            //SQL COMMAND
           // $sql = "INSERT INTO users SET username = ?, password = ?, email = ?";
            $sql = "INSERT INTO Categories (CID,CName,Csubtitle,email) VALUES (?, ?, ?,?)";
            //store query result in $statement
           $statement = $this->conn->prepare($sql);
           //if error
           if(!$statement)
           {
            throw new Exception($statement->error);
           }
           //bind 3 parameters of type string to be placed in sql command
           $statement->bind_param("isss", $rescatid, $Cname, $Csubtitle,$email);
           // $statement->bindparam(1,$username);
           // $statement->bindparam(2,$password);
           // $statement->bindparam(3,$email);
           $returnValue = $statement->execute();
           //echo "return value is $returnValue :::::::";
           return $returnValue;
}
public function insertTasks($restid,$rescatid,$taskname)
{
//echo "enetred register user";
            //SQL COMMAND
           // $sql = "INSERT INTO users SET username = ?, password = ?, email = ?";
            $sql = "INSERT INTO Tasks (TID,CID,Tname) VALUES (?, ?, ?)";
            //$sql = "INSERT INTO Tasks (TID,CID) VALUES ($restid,$rescatid)";
            //print($sql);
            //store query result in $statement
           $statement = $this->conn->prepare($sql);
           //if error
           if(!$statement)
           {
            throw new Exception($statement->error);
           }
           //bind 3 parameters of type string to be placed in sql command
           $statement->bind_param("iis", $restid, $rescatid, $taskname);
           // $statement->bindparam(1,$username);
           // $statement->bindparam(2,$password);
           // $statement->bindparam(3,$email);
           $returnValue = $statement->execute();
           //echo "return value is $returnValue :::::::";
           return $returnValue;
}
public function insertColumn($restid,$rescatid,$nameofcol)
{
    //echo "enetred register user";
            //SQL COMMAND
           // $sql = "INSERT INTO users SET username = ?, password = ?, email = ?";
            $sql = "INSERT INTO Columnss (TID,CID,ColName) VALUES (?, ?, ?)";
            //store query result in $statement
           $statement = $this->conn->prepare($sql);
           //if error
           if(!$statement)
           {
            throw new Exception($statement->error);
           }
           //bind 3 parameters of type string to be placed in sql command
           $statement->bind_param("iis", $restid, $rescatid, $nameofcol);
           // $statement->bindparam(1,$username);
           // $statement->bindparam(2,$password);
           // $statement->bindparam(3,$email);
           $returnValue = $statement->execute();
           //echo "return value is $returnValue :::::::";
           return $returnValue;
}

public function getTasks($cat)
{
  $tasks=array();
         // if($firstlogin == 1 && $addedcat == 2)
         //     {
         //       // echo " is 1";
         //        $sql = "SELECT * FROM TasksDefault";
         //    //echo"$sql";
         //        if ($this->conn != null)
         //        { 
         //            //echo "not null";
         //            $result = $this->conn->query($sql);
         //        }
         //        else
         //        {
         //            //echo "is null";
         //        }
            
         //    //echo "$result";
         //    }
            // else
            // {
                //echo "is 0";
                $sql = "SELECT * FROM Tasks WHERE CID='". $cat."'";
               if ($this->conn != null)
                { 
                    //echo "not null";
                    $result = $this->conn->query($sql);
                }
                else
                {
                   // echo "is null";
                }
                //echo "$result";
            //}
            //echo "passes";
            //echo"$sql";
            

            if ($result != null && (mysqli_num_rows($result) > 0))
            {
                //echo "entered if of select user";
               // $row = $result->fetch_array(MYSQLI_ASSOC);
                //echo "entered if";
                while($row=$result->fetch_assoc())
            {
                //echo "row is $row";

                array_push($tasks,$row);
            }
     
                if (!empty($tasks))
                {
                   // echo "entered not empty of select ser and the row is $row";
                    $returnArray = $tasks;
                }
            }
            else
            {
                //echo "enterd null";
            }
            //echo json_encode($categories);
          // echo "\n The array is $categories";
            return $returnArray;
}


public function deleteTasks($taskID)
{
      $sql = "DELETE FROM Tasks WHERE TID= '". $taskID."'";
      $statement = $this->conn->prepare($sql);
           //if error
           if(!$statement)
           {
            throw new Exception($statement->error);
           }
           else
           {
           $returnValue = $statement->execute();
         }
           //echo "return value is $returnValue :::::::";
           return $returnValue;
}
    }
    ?>