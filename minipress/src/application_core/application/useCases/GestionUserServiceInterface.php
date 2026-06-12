<?php
namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\User;

interface GestionUserServiceInterface {
    public function authenticateUser($email, $password);
    public function registerUser($email, $password);
    public function startUserSession(User $user);
    public function logoutUser();
    public function isUserAuthenticated();
    public function getUserById($userId);
    public function canCreateArticle($userId);
    public function canEditArticle($userId, $articleId);
    public function canDeleteArticle($userId, $articleId);
    public function getUserByEmail($email);
    public function getCurrentUser();
    public function emailExists($email);
    public function updateUserPassword($userId, $newPassword);
}
?>