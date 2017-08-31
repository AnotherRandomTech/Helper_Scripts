<?php
    /* Easier to test only when loading the page? better loading time for later or do a whole page refresh? */
    $url1=$_SERVER['REQUEST_URI'];
    header("Refresh: 30; URL=$url1");
    
    if(fsockopen("10.0.1.4",3306))
    {
        echo '<img src="on.png" />';
        echo "Open";
    }
    else
    {
        echo '<img src="off.png" />';
        echo "Closed/Blocked";
    }
    ?>
