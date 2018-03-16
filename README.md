# TeamFloorPlan
A web based application designed to help students navigate the university buildings.
The website requires the students to login and enter three parameters, these being the name of the building, the floor desired

# Team Members
MBew, Michael Bew - Michael Bew 804546,
AStrangeWelshMan - Richard Griffiths,
DarthVader5000 - David Andreas,
kevinli532 - Kevin Li,
MarcoPolo12 - George Swallow.

Note: Due to early problems with committing lots of commits are showing in the history but not in the overall statistics.

# Code documentation #

## Backend Functionality ##

| Function Name            | Arguments                                                                                                                   | Description                                                                                                                                                                                                                                                                                                                                                             |
|--------------------------|-----------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| deleteSessionAndRedirect | @param {string} redirectURL                                                                                                 | Deletes the user session and  redirect the user to the page specified in the arguement                                                                                                                                                                                                                                                                                  |
| signUserUp               | @param {connection} conn @param {string} email @param {string} username @param {string} password  @param {string} cpassword | This function adds a username,  password and email to the database when a user is in the process of signing up. It performs the following checks. 1. It checks the password and confirmation password are the same. 2. It checks the username includes no special characters. 3.Checks the inputs aren't empty. 4.Checks the email and/or username aren't already used. |
| userLogin                | @param {connection} conn @param {string} username @param {string} password                                                  | This function checks if a given username and password combination are in a database. If the combination is valid, it creates a user session for them and redirects them to the building select page. Otherwise it redirects them to the login page with an error message to display to them.                                                                            |
| getBuildingData          | @param {connection} conn @param {string} buildingName                                                                       | This fetches the amount of floors from a  building. If the building name isn't specified, it returns a list of building names.                                                                                                                                                                                                                                          |
| insertRoomDataTest       | @param {connection} conn @param {int} floorID @param {int} roomXAxis  @param {int} roomYAxis  @param {int} roomSize         | This function is a maintenance function for automated inserting of data into the database. The front end doesn't have access to this. Only users with the session ID of  "admin" can call this method.                                                                                                                                                                  |
| getRoomID                | @param {connection} conn  @param {string} buildingName  @param {int} roomID                                                 | This function fetches the unique room id of a given room number and room building.                                                                                                                                                                                                                                                                                      |
| getPathCoordinates       | @param {connection} conn  @param {int} roomID  @param {string} pathEntranceID @param {int} floorNumb  @param {bool} disable | This function fetches the coordinates for a path between a between a given  starting point (entrance if it on the bottom floor or stairs/lift if it is on a floor > 0) If the user sets the disabled flag it will always draw from an elevator.                                                                                                                         |
|                          |                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                         |

The code below all these functions will decide what functions will be called. This table will show the parameters

| Request Type | Request Trigger | Requests Inputted                                                                              | Function called    |
|--------------|-----------------|------------------------------------------------------------------------------------------------|--------------------|
| POST         | Signup          | Username (compulsory) Email (compulsory) Password (compulsory) Cpassword (compulsory)          | signUserUp         |
| POST         | Login           | Username (compulsory) Password (compulsory)                                                    | userLogin          |
| GET          | roomStuff       | buildingName (optional)                                                                        | getBuildingData    |
| POST         | nodeBool        | floorID (compulsory) nodeYAxis (compulsory) nodeXAxis (compulsory)                             | insertNodeDataTest |
| POST         | roomBool        | floorID (compulsory) roomYAxis (compulsory) roomXAxis (compulsory) roomSize (compulsory)       | insertRoomDataTest |
| GET          | roomID          | buildingName (compulsory) roomID (compulsory)                                                  | getRoomID          |
| GET          | pathEntranceID  | roomIDSelect (compulsory) pathEntranceID (compulsory) floor (compulsory) disabled (compulsory) | getPathCoordinates |


