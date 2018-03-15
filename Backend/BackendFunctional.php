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




function deleteSessionAndRedirect($redirectURL){
	session_destroy();
	$location = "Location: ";
	$location .= $redirectURL; //Concatenate Location wtih file.
	header($location);
}


function signUserUp($conn, $email, $username, $password, $cpassword){

	$password = hash('sha256',$password); //Get hashes of passwords
	$cpassword = hash('sha256',$cpassword);

	if($password != $cpassword){
		deleteSessionAndRedirect("../createAccountForm.php?error=passwordError"); //If passwords don't match, redirect to error page.
	}

	if(!preg_match('/^[A-Za-z0-9_~\-!@#\$%\^&*\(\)]+$/' , $username)) //Sanitise the user input. Only allow A-Z and 0-9 in the username
    {
    	deleteSessionAndRedirect("../createAccountForm.php?error=invalidUsername");
    }

    if($username == '' || $email == '' || $password == '')
    {
    	deleteSessionAndRedirect("../createAccountForm.php?error=invalidUsername"); //Check that $user, $email and $password are all populated
    }

	$check = $conn->prepare("SELECT * FROM logindetails WHERE loginUsername=:loginUsername or loginEmail=:loginEmail"); //This block of code checks
    $check->bindParam(':loginUsername',$username);															  //that the username or email
    $check->bindParam(':loginEmail',$email);																  //haven't been taken already.
    $check->execute();
    $checkuser = $check->fetchAll();
    foreach($checkuser as $row)
    {
        deleteSessionAndRedirect("../createAccountForm.php?error=errorUsernameTaken");//If username/email has been taken, redirect.
    }

     $result = $conn->prepare("INSERT INTO logindetails (loginUsername, loginPassword, loginEmail) VALUES (:loginUsername, :loginPassword, :loginEmail)"); //Insert into DB
     $result->bindParam(':loginUsername', $username); //Replacing prepared statement vars with username and password
     $result->bindParam(':loginPassword', $password);
     $result->bindParam(':loginEmail', $email);
     $result->execute();
     print_r(error_get_last());
     deleteSessionAndRedirect("../Login.php");
}

function userLogin($conn,$username,$password){
	$password = hash('sha256',$password);

	if($username == '' ||  $password == '')
    {
    	deleteSessionAndRedirect("../loginIncorrect.html"); //Check that $user, $email and $password are all populated
    }

    $result = $conn->prepare("SELECT * FROM logindetails WHERE loginUsername= :loginUsername AND loginPassword= :loginPassword");
    $result->bindParam(':loginUsername', $username);
    $result->bindParam(':loginPassword', $password);
    $result->execute();
    $rows = $result->fetch(PDO::FETCH_NUM);
    if ($rows > 0) {   
    	$_SESSION['user'] = $username;	//Start user session login successful
     	session_write_close();
        header("Location: ../buildingSelect.php");
    } else {
         deleteSessionAndRedirect("../login.php?loginError=1");   
    }
}

function getBuildingData($conn,$buildingName){
	if($buildingName == NULL){
		$results = array();
        $result = $conn->prepare("SELECT buildingName from building");
        $result->execute();
        $buildingNames = $result->fetchAll();
        foreach($buildingNames as $row)
        {
            array_push($results, $row['buildingName']);
        }
        echo implode(" ",$results);
	}else{
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
}

function insertRoomDataTest($conn, $floorID, $roomXAxis, $roomYAxis, $roomSize){
	$roomID = NULL;
	$result = $conn->prepare("INSERT INTO room (roomID, floorID, roomYAxis, roomXAxis, roomSize) VALUES (:roomID, :floorID, :roomYAxis, :roomXAxis, :roomSize)");
    $result->bindParam(':roomID',$roomID);
    $result->bindParam(':floorID', $floorID);
    $result->bindParam(':roomYAxis', $roomYAxis);
    $result->bindParam(':roomXAxis', $roomXAxis);
    $result->bindParam(':roomSize',$roomSize);
    $result->execute();
    header("Location: post2.html");
}

function getRoomID($conn,$buildingName,$roomID){
    $getFloor = substr($roomID, 0,1);

    $result = $conn->prepare("SELECT room.roomID FROM room JOIN floor ON room.floorID WHERE room.roomName= :roomID AND floor.floorID= room.floorID AND floor.buildingName= :buildingName ");
    $result->bindParam(':roomID',$roomID);
    $result->bindParam(':buildingName', $buildingName);
    $result->execute();

    $floorNumber = $result->fetchAll();
    foreach($floorNumber as $row)
    {
        echo $row['roomID'];
        echo ",";
        echo $getFloor;
    }
}

function getPathCoordinates($conn,$roomID,$pathEntranceID,$floorNumb,$disabled){
    if($floorNumb == 0)
    {
        $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.EntranceID= :pathEntranceID AND path.roomID= :roomID");
        $result->bindParam(':pathEntranceID',$pathEntranceID);
        $result->bindParam(':roomID',$roomID);
        $result->execute();
        $floorNumber = $result->fetchAll();
        foreach($floorNumber as $row)
        {
            echo $row['pathCoordinates'];

        }
    }else{
        $stairID = $pathEntranceID;
        if($disabled=="false")
        {
            $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.stairID= :stairID AND path.roomID= :roomID");
            $result->bindParam(':stairID',$stairID);
            $result->bindParam(':roomID',$roomID);
            $result->execute();
            $floorNumber = $result->fetchAll();
            foreach($floorNumber as $row)
            {
                echo $row['pathCoordinates'];

            }
        }else{
            $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.stairID= :elevatorID AND path.roomID= :roomID");
            $result->bindParam(':elevatorID',$stairID);
            $result->bindParam(':roomID',$roomID);
            $result->execute();
            $floorNumber = $result->fetchAll();
            foreach($floorNumber as $row)
            {
                echo $row['pathCoordinates'];
            }
        }
        
    }
}

if(isset($_POST['Signup'])){
	$user = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $cpassword = $_POST['cpassword'];

    signUserUp($conn,$email,$user,$password,$cpassword);

}elseif (isset($_POST['Login'])){
	$user = $_POST['username'];
	$password = $_POST['password'];

	userLogin($conn,$user,$password);
}elseif (isset($_GET['roomStuff'])){
	if(!isset($_GET['buildingName'])){
		$buildingName = NULL;
	}else{
		$buildingName = $_GET['buildingName'];
	}
	getBuildingData($conn,$buildingName);

}elseif(isset($_POST['nodeBool'])){
	$floorID = $_POST['floorID'];
    $nodeYAxis = $_POST['nodeYAxis'];
    $nodeXAxis = $_POST['nodeXAxis'];

    insertNodeDataTest($conn,$floorID,$nodeXAxis,$nodeYAxis);
}elseif(isset($_POST['roomBool'])){

	$floorID = $_POST['floorID'];
    $roomYAxis = $_POST['roomYAxis'];
    $roomXAxis = $_POST['roomXAxis'];
    $roomSize = $_POST['roomSize'];

    insertRoomDataTest($conn,$floorID,$roomXAxis,$roomYAxis,$roomSize);
}elseif(isset($_GET['roomID'])){
    $buildingName = $_GET['buildingName'];
    $roomID = $_GET['roomID'];

    getRoomID($conn,$buildingName,$roomID);
}elseif(isset($_GET['pathEntranceID'])){

    $roomID = $_GET['roomIDSelect'];
    $pathEntranceID = $_GET['pathEntranceID'];
    $floorNumb = $_GET['floor'];
    $disabled = $_GET['disabled'];

    getPathCoordinates($conn,$roomID,$pathEntranceID,$floorNumb,$disabled);
}