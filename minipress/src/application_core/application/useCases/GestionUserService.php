<?php
namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\User;
use minipress\application_core\domain\entities\Article;

class GestionUserService implements GestionUserServiceInterface{

    public function authenticateUser($email, $password){
        if (empty($email) || empty($password)) {
            throw new \InvalidArgumentException('Email et mot de passe requis');
        }

        $user = User::where('email', $email)->first();

        if (!$user) {
            throw new \Exception('Utilisateur non trouvé');
        }

        if (!password_verify($password, $user->mot_de_passe)) {
            throw new \Exception('Email ou mot de passe incorrect');
        }

        return $user;
    }

    public function registerUser($email, $password){
        if (empty($email) || empty($password)) {
            throw new \InvalidArgumentException('Email et mot de passe requis');
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new \InvalidArgumentException('Email invalide');
        }

        if (strlen($password) < 6) {
            throw new \InvalidArgumentException('Le mot de passe doit faire au moins 6 caractères');
        }

        if ($this->emailExists($email)) {
            throw new \Exception('Un utilisateur avec cet email existe déjà');
        }

        $user = new User();
        $user->email = $email;
        $user->mot_de_passe = password_hash($password, PASSWORD_DEFAULT);
        $user->save();

        return $user;
    }

    public function startUserSession(User $user){
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        $_SESSION['auth_user'] = [
            'id' => $user->id,
            'email' => $user->email,
            'is_admin' => $user->is_admin ?? 0
        ];

        return true;
    }

    public function getCurrentUser(){
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        if (!isset($_SESSION['auth_user']['id'])) {
            return null;
        }

        $user = User::find($_SESSION['auth_user']['id']);
        if (!$user) {
            // Nettoyer la session si l'utilisateur n'existe plus
            $this->logoutUser();
            return null;
        }

        return $user;
    }

    public function logoutUser(){
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        // Supprimer uniquement la clé d'authentification
        unset($_SESSION['auth_user']);

        return true;
    }


    public function isUserAuthenticated(){
        return $this->getCurrentUser() !== null;
    }


    public function getUserById($userId){
        if (empty($userId)) {
            return null;
        }

        return User::find($userId);
    }


    public function canCreateArticle($userId){
        if (!$userId) {
            return false;
        }

        $user = $this->getUserById($userId);
        return $user !== null;
    }

    public function canEditArticle($userId, $articleId){
        if (!$userId || !$articleId) {
            return false;
        }

        $article = Article::find($articleId);
        if (!$article) {
            return false;
        }

        return $article->author_id == $userId;
    }

    public function canDeleteArticle($userId, $articleId){
        return $this->canEditArticle($userId, $articleId);
    }

    public function getUserByEmail($email){
        if (empty($email)) {
            return null;
        }

        return User::where('email', $email)->first();
    }

    public function emailExists($email){
        if (empty($email)) {
            return false;
        }

        return User::where('email', $email)->exists();
    }

    public function updateUserPassword($userId, $newPassword){
        if (empty($userId) || empty($newPassword)) {
            throw new \InvalidArgumentException('ID utilisateur et nouveau mot de passe requis');
        }

        if (strlen($newPassword) < 6) {
            throw new \InvalidArgumentException('Le mot de passe doit faire au moins 6 caractères');
        }

        $user = $this->getUserById($userId);
        if (!$user) {
            throw new \Exception('Utilisateur non trouvé');
        }

        $user->mot_de_passe = password_hash($newPassword, PASSWORD_DEFAULT);
        return $user->save();
    }
}
?>