<?php 
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "data_flutter";
$table ="Data";

// get actions from the app to do operations in the database ...
$action = $_POST["action"];

// Create Connection object
$conn = new mysqli($servername, $username, $password, $dbname);
if($conn->connect_error){
    die("Connecion Failed: " . $conn->connect_error);
    return ;
}

// if connection is OK ...

// if the app sends an action to create the table..
if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $table (
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(30) NOT NULL,
        food VARCHAR(30) NOT NULL)
    ";

    if($conn->query($sql) === TRUE){
        echo "success";
    } else {
        echo "error";
    }
    $conn->close();
    return ;
}

//get all data records from the database
if("GET_ALL" == $action){
    $db_data = array();
    $sql = "SELECT id, username, food from $table ORDER BY id DESC";
    $result = $conn->query($sql);
    if($result->num_rowa > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    } else {
        echo "error";
    }
    $conn->close();
    return ;
}

// Add Data
if("ADD_DATA" == $action){
    $username = $POST['username'];
    $food = $POST['food'];
    $sql = "INSERT INTO $table (username, food) VALUE  ('$username', '$food')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return ;
}

// Update Data
if("UPDATE_DATA" == $action){
    // App will be posting these values to this server
    $id = $POST['$id'];
    $username = $POST['username'];
    $food = $POST['food'];
    $sql ="UPDATE $table SET username = '$username', food = '$food' WHERE id ='$id";
    if($conn->query($sql) === TRUE){
        echo "success";
    } else {
        echo "error";
    }
    $conn->close();
    return ;
}

// Delete Data
if('DELETE_DATA' == $action){
    $id = $POST['$id'];
    $sql = "DELETE FROM $table WHERE id = $id";
    if($conn->query($sql) === TRUE){
        echo "success";
    } else {
        echo "error";
    }
    $conn->close();
    return ;
}
?>