<?php
require_once __DIR__ . "/config.php";

$input = get_json_input();
$card = trim($input['card_number'] ?? '');
$fuel = trim($input['fuel_type'] ?? '');
$volume = floatval($input['volume'] ?? 0);
$cost = floatval($input['cost'] ?? 0);

if(!$card || !$fuel || $volume <= 0 || $cost <= 0){
    send_json_response(["status"=>"error","message"=>"Invalid fields"],400);
}

// Get real user
$stmt = $conn->prepare("SELECT user_id, balance FROM users WHERE card_number = ?");
$stmt->bind_param("s",$card);
$stmt->execute();
$res = $stmt->get_result();

if($res->num_rows === 0){
    send_json_response(["status"=>"error","message"=>"Card not found"],404);
}

$user = $res->fetch_assoc();
$user_id = $user['user_id'];
$current_balance = floatval($user['balance']);

// --- For simulation: ignore insufficient balance, allow transaction ---
$new_balance = $current_balance - $cost; // can be negative, but saved

// Save transaction
$insert = $conn->prepare("INSERT INTO transactions (user_id, fuel_type, volume, cost, transaction_time) VALUES (?,?,?,?,NOW())");
$insert->bind_param("isdd",$user_id,$fuel,$volume,$cost);
$insert->execute();
$insert->close();

// Update balance (optional: allow negative for testing)
$update = $conn->prepare("UPDATE users SET balance = ? WHERE user_id = ?");
$update->bind_param("di",$new_balance,$user_id);
$update->execute();
$update->close();

send_json_response([
    "status"=>"SUCCESS",
    "message"=>"Transaction completed successfully.",
    "fuel_type"=>$fuel,
    "volume_dispensed"=>$volume,
    "final_cost"=>$cost,
    "remaining_balance"=>$new_balance
]);
?>
