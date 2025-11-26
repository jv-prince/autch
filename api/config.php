<?php
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);

$host = "localhost";
$user = "root";
$pass = "";
$db   = "fuel_system";

$conn = new mysqli($host, $user, $pass, $db);
if($conn->connect_error){
    header("Content-Type: application/json");
    echo json_encode(["status"=>"ERROR","message"=>"DB connect failed: ".$conn->connect_error]);
    exit;
}
$conn->set_charset("utf8mb4");

function get_json_input(){
    $raw=file_get_contents("php://input");
    $data=json_decode($raw,true);
    return (json_last_error()===JSON_ERROR_NONE)?$data:null;
}

function send_json_response($payload,$http_status=200){
    header_remove();
    header("Content-Type: application/json; charset=utf-8");
    http_response_code($http_status);
    echo json_encode($payload);
    exit;
}
?>
