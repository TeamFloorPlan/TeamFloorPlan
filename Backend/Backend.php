<?php
session_start();
$errmsg_arr = array();
$errflag    = false;
// configuration
$dbhost     = "localhost";      //Address of the database
$dbname     = "insefinal";            //Name for the database
$dbuser     = "root";           //Name of the MySQL user
$dbpass     = "";               //Password of the MySQL user

$conn = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass); //Declaring a new PDO connection

print_r(error_get_last());


/*
TODO:
	1.Replace redirect placeholders
	2.Add functionality for confirming emails
	3.Get database info from George
	4.Add functionality to get room data from the database
	5.Add ability to search
	6.Clean up code. Make it more OOP
*/
//echo "egg";
if(isset($_POST['Signup']) && isset($_POST['email']) && isset($_POST['username']) && isset($_POST['password']))//If a new user is signing up
{
   
                
                $user = $_POST['username'];			//Get Username
                $email = $_POST['email'];			//Get Email
                $password = hash('sha256',($_POST['password']),false);		//Get password and conformation of password hashes
                $cpassword = hash('sha256',($_POST['cpassword']),false);


                if($password!=$cpassword)		//Check that passwords are the same
                {
                    header("location: ../createAccountForm.php?error=passwordError"); //TODO: Redirect to page telling the user the two passwords aren't the same
                    exit;
                }

                if(!preg_match('/^[A-Za-z0-9_~\-!@#\$%\^&*\(\)]+$/' , $user)) //Sanitise the user input. Only allow A-Z and 0-9 in the username
                {
                         header("location: ../createAccountForm.php?error=invalidUsername");
                         exit;
                }
                    
                    
                
               echo "hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";

                if($user == '' || $email == '' || $password == '')
                {
                    header("location: ../createAccountForm.php?error=invalidUsername");
                }
                else
                {
                    $check = $conn->prepare("SELECT * FROM logindetails WHERE loginUsername=:username or loginEmail=:email");
                    $check->bindParam(':username',$user);
                    $check->bindParam(':email',$email);
                    $check->execute();
                    $checkuser = $check->fetchAll();
                    foreach($checkuser as $row)
                    {
                        header("Location: ../createAccountForm.php?error=errorUsernameTaken");
                        exit;
                    }




                    //$verified = "false";
                    $result = $conn->prepare("INSERT INTO logindetails (loginUsername, loginPassword , loginEmail) VALUES (:username, :password, :email)");
                    $result->bindParam(':username', $user); //Replacing prepared statement vars with username and password
                    $result->bindParam(':password', $password);
                    $result->bindParam(':email', $email);
                    $result->execute();
                    header("location: ../login.php");
                }

            
        
    
}else if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['Login'])) 
{
        echo "heeeeee";
    
        $user     = $_POST['username'];
        $password = hash('sha256',($_POST['password']),false);
        //echo $password;       
        if ($user == '') {
            $errmsg_arr[] = 'You must enter your Username';
            $errflag      = true;
        }
        if ($password == '') {
            $errmsg_arr[] = 'You must enter your Password';
            $errflag      = true;
        }
        echo $user;
        echo $password;
        // query
        $result = $conn->prepare("SELECT * FROM logindetails WHERE loginUsername= :user AND loginPassword= :password");
        $result->bindParam(':user', $user);
        $result->bindParam(':password', $password);
        $result->execute();
        $rows = $result->fetch(PDO::FETCH_NUM);
        if ($rows > 0) {
            
            $_SESSION['user'] = $user;
            session_write_close();
            header("location: ../buildingSelect.php");
        } else {
            $errmsg_arr[] = 'Username and Password are not found';
            $errflag      = true;
        }
        if ($errflag) {
            $_SESSION['ERRMSG_ARR'] = $errmsg_arr;
            session_write_close();
            header("location: ../login.php?loginError=1");
           // echo $errmsg_arr;
            exit();
        }
    
} else if(isset($_GET['roomStuff']))
{
    if(!isset($_GET['buildingName']))
    {
        $results = array();
        $result = $conn->prepare("SELECT buildingName from building");
        $result->execute();
        $buildingNames = $result->fetchAll();
        foreach($buildingNames as $row)
        {
            array_push($results, $row['buildingName']);
        }
        echo implode(" ",$results);
    }
    else{
        $buildingName = $_GET['buildingName'];
        $results = array();
        $result = $conn->prepare("SELECT buildingNumberOfFloors FROM building WHERE buildingName= :buildingName");
        $result->bindParam(':buildingName', $buildingName);
        $result->execute();
        $floorNumber = $result->fetchAll();
        foreach($floorNumber as $row)
        {
            echo $row['buildingNumberOfFloors'];
        }
    }

}else if(isset($_POST['nodeBool']))
{
    $nodeID = NULL;
    $floorID = $_POST['floorID'];
    $nodeYAxis = $_POST['nodeYAxis'];
    $nodeXAxis = $_POST['nodeXAxis'];
    $nodeNorthAdjacent = $_POST['nodeNorthAdjacent'];
    $nodeEastAdjacent = $_POST['nodeEastAdjacent'];
    $nodeSouthAdjacent = $_POST['nodeSouthAdjacent'];
    $nodeWestAdjacent = $_POST['nodeWestAdjacent'];

    $result = $conn->prepare("INSERT INTO nodes (nodeID, floorID, nodeXAxis, nodeYAxis, nodeGetNorth, nodeGetEast, nodeGetSouth, nodeGetWest) VALUES (:nodeID, :floorID, :nodeYAxis, :nodeXAxis, :nodeNorthAdjacent, :nodeEastAdjacent, :nodeSouthAdjacent, :nodeWestAdjacent)");
    $result->bindParam(':nodeID', $nodeID);
    $result->bindParam(':floorID', $floorID);
    $result->bindParam(':nodeYAxis', $nodeYAxis);
    $result->bindParam(':nodeXAxis', $nodeXAxis);
    $result->bindParam(':nodeNorthAdjacent', $nodeNorthAdjacent);
    $result->bindParam(':nodeEastAdjacent', $nodeEastAdjacent);
    $result->bindParam(':nodeSouthAdjacent', $nodeSouthAdjacent);
    $result->bindParam(':nodeWestAdjacent', $nodeWestAdjacent);
    $result->execute();
    header("Location: post2.html");

}else if(isset($_POST['roomBool']))
{
    $roomID = NULL;
    $floorID = $_POST['floorID'];
    $roomYAxis = $_POST['roomYAxis'];
    $roomXAxis = $_POST['roomXAxis'];
    $roomSize = $_POST['roomSize'];

    $result = $conn->prepare("INSERT INTO room (roomID, floorID, roomYAxis, roomXAxis, roomSize) VALUES (:roomID, :floorID, :roomYAxis, :roomXAxis, :roomSize)");
    $result->bindParam(':roomID',$roomID);
    $result->bindParam(':floorID', $floorID);
    $result->bindParam(':roomYAxis', $roomYAxis);
    $result->bindParam(':roomXAxis', $roomXAxis);
    $result->bindParam(':roomSize',$roomSize);
    $result->execute();
    header("post2.html");
}else if(isset($_GET['roomID']))
{
    $roomID = $_GET['roomID'];
    $result = $conn->prepare("SELECT room.roomID FROM room WHERE room.roomName= :roomID");
    $result->bindParam(':roomID',$roomID);
    $result->execute();

    $floorNumber = $result->fetchAll();
    foreach($floorNumber as $row)
    {
        echo $row['roomID'];
    }
}else if(isset($_GET['pathEntranceID']))
{
    $roomID = $_GET['roomIDSelect'];
    $pathEntranceID = $_GET['pathEntranceID'];
    $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.EntranceID= :pathEntranceID AND path.roomID= :roomID");
    $result->bindParam(':pathEntranceID',$pathEntranceID);
    $result->bindParam(':roomID',$roomID);
    $result->execute();
    $floorNumber = $result->fetchAll();
    foreach($floorNumber as $row)
    {
        echo $row['pathCoordinates'];
    }
}


?>


