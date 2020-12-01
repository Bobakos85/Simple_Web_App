<?php
    $connection = pg_connect ("host=swa.cjfomqionnia.eu-west-2.rds.amazonaws.com port=5432 dbname=swa user=administrator password=<enter_password_here>");
    if($connection) {
       echo 'connected';
    } else {
        echo 'there has been an error connecting';
    } 
?>