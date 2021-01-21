<?php

function get_chatbot_msg(){
	
	$servername = "localhost";
	$username = "unistamgroups_yoyopizzaapp";
	$password = "yoyopizzaapp@06";
	$database="unistamgroups_yoyopizzaapp";
	$conn =mysqli_connect($servername, $username, $password, $database);

	$msg = strtolower($_POST["message_sent"]);
	$prev_ques = strtolower($_POST["prev_ques"]);
	$items = strtolower($_POST["items"]);
	$name_in_order = strtolower($_POST["name_in_order"]);
	$delivery_addr = strtolower($_POST["delivery_addr"]);
	$phone = strtolower($_POST["phone"]);


	if($msg==''){
		$category_list = 'Welcome to YoYo Pizza!<br> Which variety do u prefer,<br> ';
		$sql = "select * from varieties";
        $result = mysqli_query($conn, $sql);
		while($row = $result->fetch_assoc()) { 
			$category_list=$category_list.$row['name'].'<br> ';
		}
		$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
		return $data;
	}

	if($prev_ques=='quantity'){
		$arr = explode(" ",$msg);
		$flag=0;
		for($i=0;$i<count($arr);$i++){
			if(is_numeric($arr[$i])){
				$items=$items.'-'.$arr[$i].', ';
				$prev_ques='';
				$flag=1;
			}
		}
		if($flag==0){
			$data= ["message" => "Please give us a number!", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
		else{
		    $prev_ques='add_list';
			$data= ["message" => "Do you need anything else? (Yes/No)", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
	}

	if($prev_ques=='add_list'){
		if(strpos($msg, 'yes') !== false){
			$prev_ques='';
			$category_list = 'We request you to choose from our food varieties,<br>';
			$sql = "select * from varieties";
			$result = mysqli_query($conn, $sql);
			while($row = $result->fetch_assoc()) { 
				$category_list=$category_list.$row['name'].'<br>';
			}
			$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
		else{
			$prev_ques='place_order';
			$data= ["message" => "Do you like to place the Order? (Yes/No)", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
	}

	if($prev_ques=='place_order'){
		if(strpos($msg, 'yes') !== false){
			$prev_ques='get_name';
			$data= ["message" => 'In what name would you like to place the Order?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
		else{
			$prev_ques='';
			$items='';
			$data= ["message" => "Alas! Your order has been cancelled. Kindly order by restarting the app.", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
		}
	}

	if($prev_ques=='get_name'){
			$name_in_order=$msg;
			$prev_ques='get_address';
			$data= ["message" => 'Give us the address to deliver the food?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
	}

	if($prev_ques=='get_address'){
			$delivery_addr=$msg;
			$prev_ques='get_phone';
			$data= ["message" => 'Kindly provide us your phone number for contact?', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
	}

	if($prev_ques=='get_phone'){
			$phone=$msg;
			$prev_ques='order_confirmation';
			$data= ["message" => 'Are you sure, You want to confirm the order? (Yes/No)', "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
			return $data;
	}

	if($prev_ques=='order_confirmation'){
			if(strpos($msg, 'yes') !== false || strpos($msg, 'ok') !== false || strpos($msg, 'okay') !== false || strpos($msg, 'conform') !== false || strpos($msg, 'confirm') !== false
			|| strpos($msg, 'conformation') !== false || strpos($msg, 'confirmation') !== false || strpos($msg, 'confirming') !== false || strpos($msg, 'conforming') !== false ||
			strpos($msg, 'conformed') !== false || strpos($msg, 'confirmed') !== false){
			    
				$prev_ques='';
				
				$sql1="UPDATE `autogen` SET `ord_id`=`ord_id`+1";	
            	mysqli_query($conn, $sql1);	
            	$sql2 ="SELECT * FROM autogen";
            	$res = mysqli_query($conn, $sql2);
            	$row = mysqli_fetch_assoc($res);
            	$id=$row["ord_id"];
            	if($id < 10){ $id2='00000'; }
            	else if($id >= 10){ $id2='0000'; }
            	else if($id >= 100){ $id2='000'; }
            	else if($id >= 1000){ $id2='00'; }
            	else if($id >= 10000){ $id2='0'; }
            	else { $id2=''; }
                $yoyo='YOYO';
            	$id3=$yoyo.$id2.$id;
				
				date_default_timezone_set('Asia/Kolkata');
                $date = date('Y-m-d H:i:s');  				
				
				$status='Order Placed';
				
				$sql = "insert into orders(`ord_id`,`ord_items`,`ord_name`,`ord_address`,`ord_phone`,`ord_status`,`ord_time`) values('$id3','$items','$name_in_order','$delivery_addr','$phone','$status','$date')";
			    $result = mysqli_query($conn, $sql);
				
				$data= ["message" => 'Your order '.$items.' has been confirmed successfully.<br> Kindly note your Order ID for tracking : '.$id3.'.<br> The food will arrive your doorstep!<br> Have a Good day!', "prev_ques" => $prev_ques
				, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
				return $data;
				
			}
			else{
				$prev_ques='';
				$items='';
				$data= ["message" => "Alas! Your order has been cancelled. Kindly order by restarting the app.", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
				return $data;
			}
	}

	$sql = "select * from foods";
    $result = mysqli_query($conn, $sql);
	while($row = $result->fetch_assoc()) { 
		if(strpos($msg, strtolower($row['food_name'])) !== false){

		$items=$items.$row['food_name'];
		$prev_ques='quantity';
		$data= ["message" => "How many ".$row['food_name']."s do you like to have?", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
		return $data;
		break;
		
		}
	}

	$sql = "select * from varieties";
    $result = mysqli_query($conn, $sql);
	while($row = $result->fetch_assoc()) { 
		if(strpos($msg, strtolower($row['name'])) !== false){

		$category_list = 'We have a varieties of '.$row['name'].',<br>';
		$sql2 = "select * from foods where variety='".$row['name']."'";
		$result2 = mysqli_query($conn, $sql2);
		while($row2 = $result2->fetch_assoc()) { 
			$category_list=$category_list.$row2['food_name'].'<br>';
		}
		$category_list = $category_list.'Please choose one!';
		$data= ["message" => $category_list, "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
		return $data;
		break;
		
		}
	}

	$data= ["message" => "Apologies! We are unable to catch you.", "prev_ques" => $prev_ques, "items" => $items, "name_in_order" => $name_in_order, "delivery_addr" => $delivery_addr, "phone" => $phone];
	return $data;

}

$data_res = get_chatbot_msg();
echo json_encode($data_res);

?>