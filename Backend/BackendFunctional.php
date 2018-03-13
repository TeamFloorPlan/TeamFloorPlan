<?php
session_start();
$errmsg_arr = array();
$errflag    = false;
// configuration
$dbhost     = "localhost";      //Address of the database
$dbname     = "inse";            //Name for the database
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
		deleteSessionAndRedirect("PasswordError.html"); //If passwords don't match, redirect to error page.
	}

	if(!preg_match('/^[A-Za-z0-9_~\-!@#\$%\^&*\(\)]+$/' , $username)) //Sanitise the user input. Only allow A-Z and 0-9 in the username
    {
    	deleteSessionAndRedirect("UsernameError.html");
    }

    if($username == '' || $email == '' || $password == '')
    {
    	deleteSessionAndRedirect("../createAccountForm.html"); //Check that $user, $email and $password are all populated
    }

	$check = $conn->prepare("SELECT * FROM `logindetails` WHERE username=:username or email=:email"); //This block of code checks
    $check->bindParam(':username',$username);															  //that the username or email
    $check->bindParam(':email',$email);																  //haven't been taken already.
    $check->execute();
    $checkuser = $check->fetchAll();
    foreach($checkuser as $row)
    {
        deleteSessionAndRedirect("UsernameError.html");//If username/email has been taken, redirect.
    }

     $result = $conn->prepare("INSERT INTO logindetails (username, password, email) VALUES (:username, :password, :email)"); //Insert into DB
     $result->bindParam(':username', $username); //Replacing prepared statement vars with username and password
     $result->bindParam(':password', $password);
     $result->bindParam(':email', $email);
     $result->execute();
     print_r(error_get_last());
     //deleteSessionAndRedirect("../Login.html");
}

function userLogin($conn,$username,$password){
	$password = hash('sha256',$password);

	if($user == '' ||  $password == '')
    {
    	deleteSessionAndRedirect("../loginIncorrect.html"); //Check that $user, $email and $password are all populated
    }

    $result = $conn->prepare("SELECT * FROM logindetails WHERE username= :username AND password= :password");
    $result->bindParam(':username', $user);
    $result->bindParam(':password', $password);
    $result->execute();
    $rows = $result->fetch(PDO::FETCH_NUM);
    if ($rows > 0) {   
    	$_SESSION['user'] = $user;	//Start user session login successful
     	session_write_close();
        header("Location: ../index.html");
    } else {
         deleteSessionAndRedirect("../loginIncorrect.html");   
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

function insertNodeDataTest($conn, $floorID, $nodeXAxis, $nodeYAxis){
	$nodeID = 7;
	 $result = $conn->prepare("INSERT INTO nodes (nodeID, floorID, nodeYAxis, nodeXAxis) VALUES (:nodeID, :floorID, :nodeYAxis, :nodeXAxis)");
    $result->bindParam(':nodeID', $nodeID);
    $result->bindParam(':floorID', $floorID);
    $result->bindParam(':nodeYAxis', $nodeYAxis);
    $result->bindParam(':nodeXAxis', $nodeXAxis);
    $result->execute();
    echo "hi";
    //header("Location: post2.html");
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
}