<?php
require_once "config.php";
$input=get_json_input();
if(!$input) send_json_response(["status"=>"ERROR","message"=>"Invalid JSON"],400);

$full_name=trim($input['full_name']??'');
$card_number=trim($input['card_number']??'');
$pin_code=trim($input['pin_code']??'');
$balance=floatval($input['balance']??0);

if(!$full_name||!$card_number||!$pin_code)
    send_json_response(["status"=>"ERROR","message"=>"All fields required"],400);

$conn->begin_transaction();
try{
    $check=$conn->prepare("SELECT 1 FROM users WHERE card_number=?");
    $check->bind_param("s",$card_number);
    $check->execute();
    if($check->get_result()->num_rows>0){
        $conn->rollback();
        send_json_response(["status"=>"ERROR","message"=>"Card already registered"],409);
    }
    $check->close();

    $stmt=$conn->prepare("INSERT INTO users (full_name,card_number,pin_code,balance) VALUES (?,?,?,?)");
    $stmt->bind_param("sssd",$full_name,$card_number,$pin_code,$balance);
    $stmt->execute();
    $stmt->close();

    $conn->commit();
    send_json_response(["status"=>"SUCCESS","message"=>"Card registered"],201);
}catch(Exception $e){
    $conn->rollback();
    send_json_response(["status"=>"ERROR","message"=>"DB error","debug"=>$e->getMessage()],500);
}
?>
