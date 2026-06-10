<?php
namespace minipress\application_core\domain\entities;

use Illuminate\Database\Eloquent\Model;
use minipress\application_core\domain\entities\Article;

class Categorie extends Model{

    public $table = "categorie";
    public $timestamps = false;

    public function articles(){
        return $this->hasMany(Article::class, 'id_categorie');}
}


?>
