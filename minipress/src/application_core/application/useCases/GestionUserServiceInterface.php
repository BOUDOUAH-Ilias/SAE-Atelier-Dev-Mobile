<?php
namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\User;

interface GestionUserServiceInterface {
    public function authenticateUser($email, $password);
    public function registerUser($email, $password);
    public function startUserSession(User $user);
}
?>