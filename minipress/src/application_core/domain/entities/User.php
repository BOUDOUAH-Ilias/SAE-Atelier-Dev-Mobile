<?php
namespace minipress\application_core\domain\entities;

use Illuminate\Database\Eloquent\Model;
use minipress\application_core\domain\entities\Article;

class User extends Model{

    public $table = "users";
    public $timestamps = false;
    protected $fillable = ['email', 'password'];
    protected $hidden = ['password'];

    public function articles(){
        return $this->hasMany(Article::class, 'id_auteur');}
    
    public function verifyPassword($password) {
        return password_verify($password, $this->password);
    }
    
    public static function createUser($email, $password) {
        $user = new self();
        $user->email = $email;
        $user->password = password_hash($password, PASSWORD_DEFAULT);
        $user->save();
        return $user;
    }
    
    public static function findByEmail($email) {
        return self::where('email', $email)->first();
    }
}
?>
