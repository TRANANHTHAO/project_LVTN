<?php
include "../connection.php";

//câu truy vấn
$sql = "SELECT * FROM coupon";

$newArr = array();

//kiểm tra
if ($result = mysqli_query($connectNow, $sql)) {
    while ( $db_field = mysqli_fetch_assoc($result) ) {
        $newArr[] = $db_field;
    }
    echo json_encode($newArr);
} else
    //Hiện thông báo khi không thành công
    echo 'Không thành công. Lỗi' . mysqli_error($connectNow);
//ngắt kết nối
mysqli_close($connectNow);

