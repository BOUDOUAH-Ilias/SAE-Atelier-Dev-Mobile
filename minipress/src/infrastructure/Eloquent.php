<?php
/**
 * File:  Eloquents.php
 * Creation Date: 27/12/2022
 * description: classe Eloquent, service de connexion à la base de données
 *
 * @author: canals
 */

namespace gift\appli\infrastructure;

use Illuminate\Database\Capsule\Manager as DB;

class Eloquent
{


    public static function init($filename): void
    {


        $db = new DB();
        $config = parse_ini_file($filename);
        // Accept both 'dbname' (existing config) and 'database' (Illuminate expected key)
        if (isset($config['dbname']) && !isset($config['database'])) {
            $config['database'] = $config['dbname'];
        }
        $db->addConnection($config);
        $db->setAsGlobal();
        $db->bootEloquent();

    }


}