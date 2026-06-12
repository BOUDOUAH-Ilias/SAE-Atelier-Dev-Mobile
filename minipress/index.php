<?php
declare(strict_types=1);
error_reporting(E_ALL & ~E_DEPRECATED);
require_once __DIR__ . '/src/vendor/autoload.php';
$app = require_once __DIR__ . '/src/conf/bootstrap.php';
$app->run();