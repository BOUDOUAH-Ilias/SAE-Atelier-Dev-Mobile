<?php
namespace minipress\application_core\domain\entities;

use Illuminate\Database\Eloquent\Model;
use minipress\application_core\domain\entities\Article;

class User extends Model
{
    public $table = "user";
    public $timestamps = false;

    public function articles()
    {
        return $this->hasMany(Article::class, 'id_auteur');
    }
}
?>