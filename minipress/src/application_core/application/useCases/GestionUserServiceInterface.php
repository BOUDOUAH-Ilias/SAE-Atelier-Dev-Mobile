<?php
namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\User;

interface GestionUserServiceInterface {

    /**
     * Authentifie un utilisateur avec email et mot de passe
     *
     * @param string $email
     * @param string $password
     * @return User
     * @throws \InvalidArgumentException Si les paramètres sont invalides
     * @throws \Exception Si l'authentification échoue
     */
    public function authenticateUser($email, $password);

    /**
     * Inscrit un nouvel utilisateur
     *
     * @param string $email
     * @param string $password
     * @return User
     * @throws \InvalidArgumentException Si les paramètres sont invalides
     * @throws \Exception Si l'inscription échoue
     */
    public function registerUser($email, $password);

    /**
     * Démarre une session pour un utilisateur
     *
     * @param User $user
     * @return bool
     */
    public function startUserSession(User $user);

    /**
     * Récupère l'utilisateur actuellement connecté
     *
     * @return User|null
     */
    public function getCurrentUser();

    /**
     * Déconnecte l'utilisateur actuel
     *
     * @return bool
     */
    public function logoutUser();

    /**
     * Vérifie si un utilisateur est authentifié
     *
     * @return bool
     */
    public function isUserAuthenticated();

    /**
     * Récupère un utilisateur par son ID
     *
     * @param int $userId
     * @return User|null
     */
    public function getUserById($userId);

    /**
     * Vérifie si un utilisateur peut créer des articles
     *
     * @param int $userId
     * @return bool
     */
    public function canCreateArticle($userId);

    /**
     * Vérifie si un utilisateur peut modifier un article
     *
     * @param int $userId
     * @param int $articleId
     * @return bool
     */
    public function canEditArticle($userId, $articleId);

    /**
     * Vérifie si un utilisateur peut supprimer un article
     *
     * @param int $userId
     * @param int $articleId
     * @return bool
     */
    public function canDeleteArticle($userId, $articleId);

    /**
     * Récupère un utilisateur par son email
     *
     * @param string $email
     * @return User|null
     */
    public function getUserByEmail($email);

    /**
     * Vérifie si un email est déjà utilisé
     *
     * @param string $email
     * @return bool
     */
    public function emailExists($email);

    /**
     * Met à jour le mot de passe d'un utilisateur
     *
     * @param int $userId
     * @param string $newPassword
     * @return bool
     * @throws \InvalidArgumentException Si les paramètres sont invalides
     * @throws \Exception Si la mise à jour échoue
     */
    public function updateUserPassword($userId, $newPassword);
}
?>
