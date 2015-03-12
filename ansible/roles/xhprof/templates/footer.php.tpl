<?php
if (isset($xhprofEnabled)) {
    $data = xhprof_disable();
    $xhprof_root = '/usr/share/php/xhprof_lib/utils/';
    include_once $xhprof_root . "xhprof_lib.php";
    include_once $xhprof_root . "xhprof_runs.php";
    $xhprof_runs = new XHProfRuns_Default();
    $run_id = $xhprof_runs->save_run($data, "xhprof");
}
?>
