<?php

    $servername = "localhost";
	$username = "unistamgroups_yoyopizzaapp";
	$password = "yoyopizzaapp@06";
	$database="unistamgroups_yoyopizzaapp";
	$conn =mysqli_connect($servername, $username, $password, $database);

    $id=$_POST['ord_id'];
	
	$sql="select * from orders where ord_id='$id'";
	$query=mysqli_query($conn,$sql);
	if(mysqli_num_rows($query)>0){
	    while($row=mysqli_fetch_assoc($query)){
	         $result='Order ID : '.$row['ord_id'].'<br> Name in Order : '.$row['ord_name'].'<br> Foods Ordered : '.$row['ord_items'].'<br> Delivery Address : '.$row['ord_address'].'<br> Order Status : '.$row['ord_status'];
	    }
	}
	else {
	   $result="OOPS! We don't have any order with such Order ID : ".$id.". Please verify your Order ID."; 
	}
	
	echo $result;
	
?>