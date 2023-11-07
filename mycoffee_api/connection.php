<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$database = "qlcoffee";

$connectNow = new mysqli($serverHost, $user, $password, $database);

if (!$connectNow) {
    die("Connection failed: " . $connectNow->connect_error);
}