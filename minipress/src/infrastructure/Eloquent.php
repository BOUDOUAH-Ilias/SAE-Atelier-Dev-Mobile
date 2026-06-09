<?php

declare(strict_types=1);

namespace minipress\infrastructure;

use Illuminate\Database\Capsule\Manager as DB;

class Eloquent
{
    public static function init(string $filename): void
    {
        $db = new DB();
        $config = parse_ini_file($filename);
        if (isset($config['dbname']) && !isset($config['database'])) {
            $config['database'] = $config['dbname'];
        }
        $db->addConnection($config);
        $db->setAsGlobal();
        $db->bootEloquent();
    }
}
