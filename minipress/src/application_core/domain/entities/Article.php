<?php
namespace minipress\application_core\domain\entities;
use Illuminate\Database\Eloquent\Model;
use minipress\application_core\domain\entities\Categorie;
use minipress\application_core\domain\entities\User;

class Article extends Model
{


    public $table = "article";
    public $timestamps = false;


    public const CREATED_AT = 'date_creation';
    protected $dateFormat = 'Y-m-d H:i:s';
    public const UPDATED_AT = null;

    public function categorie()
    {
        return $this->belongsTo(Categorie::class, 'id_categorie');
    }

    public function auteur()
    {
        return $this->belongsTo(User::class, 'id_auteur');
    }

}
?>