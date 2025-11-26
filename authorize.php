<?php
require_once __DIR__ . "/config.php";

$input = get_json_input();
if(!$input) send_json_response(["status"=>"error","message"=>"Invalid input"],400);

$card = trim($input['card_number'] ?? '');
$pin  = trim($input['pin_code'] ?? '');

if(!$card || !$pin) send_json_response(["status"=>"error","message"=>"Enter card & PIN"],400);

// Lookup card in DB
$stmt = $conn->prepare("SELECT user_id, full_name, balance, pin_code FROM users WHERE card_number = ?");
$stmt->bind_param("s", $card);
$stmt->execute();
$result = $stmt->get_result();

if($result->num_rows === 0){
    send_json_response(["status"=>"error","message"=>"Card not found"],404);
}

$user = $result->fetch_assoc();

// Check PIN
if($pin !== $user['pin_code']){
    send_json_response(["status"=>"error","message"=>"Invalid PIN"],401);
}

send_json_response([
    "status"=>"success",
    "data"=>[
        "user_id"=>$user['user_id'],
        "name"=>$user['full_name'],
        "balance"=>$user['balance']
    ]
]);
?>
