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

/**
/*deleteSessionAndRedirect deletes the users session and redirects the user to a given page.
/*@param {string} redirectURL
*/
function deleteSessionAndRedirect($redirectURL){
	session_destroy();
	$location = "Location: ";
	$location .= $redirectURL; //Concatenate Location wtih file.
	header($location);
}

/**
/*signUserUp adds a username, password and email to the database when a user is signing up. It
/*performs a the following checks:
/*1. It checks the password and conformation password match. 
/*2. It checks the username includes no special characters. 
/*3. Checks the inputs aren't empty.
/*4. Checks the email and/or username aren't already in use.
/*@param {connection} conn
/*@param {string} email
/*@param {string} username
/*@param {string} password
/*@param {string} cpassword
*/
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

/*
/*userLogin checks that a username and password combination is valid to authenticate a user.
/*@param {connection} conn
/*@param {string} username
/*@param {string} password
*/

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
        header("Location: ../buildingSelect.php"); //Redirect to buildingSelect.php after successful login
    } else {
         deleteSessionAndRedirect("../login.php?loginError=1");  //Returns to login page with invalid username/password
    }
}

/*
/*getBuildingData fetches the amount of floors from a building. This is for the user interface.
/*If building name isn't set, it fetches a list of building names.
/*@param {connection} conn
/*@param {string} buildingName
*/

function getBuildingData($conn,$buildingName){
	if($buildingName == NULL){ //If building name isn't specified, fetch list of building names.
		$results = array();
        $result = $conn->prepare("SELECT buildingName from building");
        $result->execute();
        $buildingNames = $result->fetchAll();
        foreach($buildingNames as $row)
        {
            array_push($results, $row['buildingName']); //Puts building names into an array.
        }
        echo implode(" ",$results); //Outputs building name with spaces inbetween.
	}else{
        $results = array();
        $result = $conn->prepare("SELECT buildingNumberOfFloors FROM building WHERE buildingName= :buildingName");
        $result->bindParam(':buildingName', $buildingName);
        $result->execute();
        $floorNumber = $result->fetchAll();
        foreach($floorNumber as $row)
        {
            echo $row['buildingNumberOfFloors']; //Outputs number of floors a building has.
        }
	}
}

/*
/*insertRoomData is here to automate inserting data into the database. The frontend doesn't access this.
/*Only with users of the session "admin" can call this method.
/*@param {connection} conn
/*@param {int} floorID
/*@param {int} roomXAxis
/*@param {int} roomYAxis
/*@param {int} roomSize 
*/
function insertRoomDataTest($conn, $floorID, $roomXAxis, $roomYAxis, $roomSize){
	$roomID = NULL; //roomID is set to auto increment so NULL is passed to the database.
	$result = $conn->prepare("INSERT INTO room (roomID, floorID, roomYAxis, roomXAxis, roomSize) VALUES (:roomID, :floorID, :roomYAxis, :roomXAxis, :roomSize)");
    $result->bindParam(':roomID',$roomID);
    $result->bindParam(':floorID', $floorID);
    $result->bindParam(':roomYAxis', $roomYAxis);
    $result->bindParam(':roomXAxis', $roomXAxis);
    $result->bindParam(':roomSize',$roomSize);
    $result->execute();
    header("Location: post2.html"); //Sends you back to the HTML script that allows you to automate insertion into DB.
}

/*
/*getRoomID fetches the unique room id of a given room number and room building.
/*@param {connection} conn
/*@param {string} buildingName
/*@param {int} roomID
*/

function getRoomID($conn,$buildingName,$roomID){
    $getFloor = substr($roomID, 0,1); //Fetches the floor of the room by parsing the first character of the room. E.g. room 2.0.1 would be on floor 2.

    $result = $conn->prepare("SELECT room.roomID FROM room JOIN floor ON room.floorID WHERE room.roomName= :roomID AND floor.floorID= room.floorID AND floor.buildingName= :buildingName ");
    $result->bindParam(':roomID',$roomID);
    $result->bindParam(':buildingName', $buildingName);
    $result->execute();

    $floorNumber = $result->fetchAll();
    foreach($floorNumber as $row)
    {
        echo $row['roomID']; //Returns the room ID and what floor it is on seperated by a comma.
        echo ",";
        echo $getFloor;
    }
}

/*
/*getPathCoordinates gets the coordinates for a path between a given entrance and roomID. IF user is disabled (set in the disabled flag)
/*and is not on the ground floor, the path is drawn from the elevator(s).
/*@param {connection} conn
/*@param {int} roomID
/*@param {string} pathEntranceID
/*@param {int} floorNumb
/*@param {bool} disable
*/

function getPathCoordinates($conn,$roomID,$pathEntranceID,$floorNumb,$disabled){

    if($floorNumb == 0) //If ground floor is 0. A path is fetched from the database between a given entrance and room.
    {
        
        $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.EntranceID= :pathEntranceID AND path.roomID= :roomID");
        $result->bindParam(':pathEntranceID',$pathEntranceID);
        $result->bindParam(':roomID',$roomID);
        $result->execute();
        $dataOut = $result->fetchAll();
        foreach($dataOut as $row)
        {
            echo $row['pathCoordinates']; //outputs the path coordinates

        }
    }else{
        $stairID = $pathEntranceID;
        if($disabled=="false")//If the person isn't disabled, get path from stairs to room.
        {
            $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.stairID= :stairID AND path.roomID= :roomID");
            $result->bindParam(':stairID',$stairID);
            $result->bindParam(':roomID',$roomID);
            $result->execute();
            $dataOut = $result->fetchAll();
            foreach($dataOut as $row)
            {
                echo $row['pathCoordinates'];

            }
        }else{
            $result = $conn->prepare("SELECT path.pathCoordinates FROM path WHERE path.stairID= :elevatorID AND path.roomID= :roomID"); //If person is disabled, draw from elevator
            $result->bindParam(':elevatorID',$stairID);
            $result->bindParam(':roomID',$roomID);
            $result->execute();
            $dataOut = $result->fetchAll();
            foreach($dataOut as $row)
            {
                echo $row['pathCoordinates'];
            }
        }
        
    }
}

function checkRoomName($conn,$roomName){
    $result = $conn->prepare("SELECT roomName FROM room WHERE roomName= :roomName");
    $result->bindParam(':roomName',$roomName);
    $result->execute();
    $rows = $result->fetch(PDO::FETCH_NUM);
    if ($rows > 0) {
        echo "SUCCESS";
    }else{
        echo "FAILURE";
    }
}

function checkEntranceNumber($entranceNumber){
    if(is_numeric($entranceNumber)){
        if($entranceNumber <= 2){
            echo "SUCCESS";
        }else{
            echo "FAILURE";
        }
    }else{
        echo "FAILURE";
    }
}

function checkFloorValid($conn,$floorNumber,$buildingName){
    $temp = 1;
    $result = $conn->prepare("SELECT buildingNumberOfFloors FROM building WHERE buildingName= :buildingName");
    $result->bindParam(':buildingName', $buildingName);
    $result->execute();
    $loop = $result->fetchAll();
    foreach($loop as $row)
    {
            $temp = $row['buildingNumberOfFloors']; //Outputs number of floors a building has.
    }

    if($floorNumber > $temp){
        echo "FAILURE";
    }else{
        echo "SUCCESS";
    }
}
/*
/*This block of code decides what functions to call from the data inputted and passes the GET and/or POST requests to their functions.
*/

if(isset($_POST['Signup'])){ //If user is signing up
	$user = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $cpassword = $_POST['cpassword'];

    signUserUp($conn,$email,$user,$password,$cpassword);

}elseif (isset($_POST['Login'])){ //If user is logging in
	$user = $_POST['username'];
	$password = $_POST['password'];

	userLogin($conn,$user,$password);
}elseif (isset($_GET['roomStuff'])){ //Calls getBuildingData and fetches either building names or the number of building floors.
	if(!isset($_GET['buildingName'])){
		$buildingName = NULL;
	}else{
		$buildingName = $_GET['buildingName'];
	}
	getBuildingData($conn,$buildingName);

}elseif(isset($_POST['nodeBool'])){ //For inserting nodes into the database. Not accessable by users.
	$floorID = $_POST['floorID'];
    $nodeYAxis = $_POST['nodeYAxis'];
    $nodeXAxis = $_POST['nodeXAxis'];

    insertNodeDataTest($conn,$floorID,$nodeXAxis,$nodeYAxis);
}elseif(isset($_POST['roomBool'])){ //For inserting room data into the database. Not accessable by users.

	$floorID = $_POST['floorID'];
    $roomYAxis = $_POST['roomYAxis'];
    $roomXAxis = $_POST['roomXAxis'];
    $roomSize = $_POST['roomSize'];

    insertRoomDataTest($conn,$floorID,$roomXAxis,$roomYAxis,$roomSize);
}elseif(isset($_GET['roomID'])){ //If frontend is getting roomID from the database
    $buildingName = $_GET['buildingName'];
    $roomID = $_GET['roomID'];

    getRoomID($conn,$buildingName,$roomID);
}elseif(isset($_GET['pathEntranceID'])){ //If the frontend fetches the path coordinates from the database.

    $roomID = $_GET['roomIDSelect'];
    $pathEntranceID = $_GET['pathEntranceID'];
    $floorNumb = $_GET['floor'];
    $disabled = $_GET['disabled'];

    getPathCoordinates($conn,$roomID,$pathEntranceID,$floorNumb,$disabled);
}elseif(isset($_GET['checkRoom'])){
    $roomName = $_GET['roomName'];
    checkRoomName($conn,$roomName);
}elseif(isset($_GET['checkEntrance'])){
    $entranceNumber = $_GET['entranceNumber'];
    checkEntranceNumber($entranceNumber);
}elseif(isset($_GET['checkFloor'])){
    $buildingName = $_GET['buildingName'];
    $floorNumber = $_GET['floorNumber'];
    checkFloorValid($conn,$floorNumber,$buildingName);
}