<?php
if (extension_loaded('xhprof') && isset($_COOKIE['_profile'])) {
    xhprof_enable();
    $xhprofEnabled = true;
}
?>
