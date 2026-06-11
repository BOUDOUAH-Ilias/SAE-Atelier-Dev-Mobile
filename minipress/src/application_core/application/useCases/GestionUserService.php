<?php
namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\User;
use minipress\application_core\domain\entities\Article;

class GestionUserService implements GestionUserServiceInterface
{

    /**
     * Authentifie un utilisateur avec email et mot de passe
     */
    public function authenticateUser($email, $password)
    {
        if (empty($email) || empty($password)) {
            throw new \InvalidArgumentException('Email et mot de passe requis');
        }

        $user = User::where('email', $email)->first();

        if (!$user) {
            throw new \Exception('Utilisateur non trouvé');
        }

        if (!password_verify($password, $user->password)) {
            throw new \Exception('Mot de passe incorrect');
        }

        return $user;
    }

    /**
     * Inscrit un nouvel utilisateur
     */
    public function registerUser($email, $password)
    {
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

        // Créer le nouvel utilisateur
        $user = new User();
        $user->email = $email;
        $user->mot_de_passe = password_hash($password, PASSWORD_DEFAULT);
        $user->save();

        return $user;
    }

    /**
     * Démarre une session pour un utilisateur
     */
    public function startUserSession(User $user)
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        $_SESSION['user_id'] = $user->id;
        $_SESSION['user_email'] = $user->email;

        return true;
    }

    /**
     * Récupère l'utilisateur actuellement connecté
     */
    public function getCurrentUser()
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        if (!isset($_SESSION['user_id'])) {
            return null;
        }

        $user = User::find($_SESSION['user_id']);
        if (!$user) {
            // Nettoyer la session si l'utilisateur n'existe plus
            $this->logoutUser();
            return null;
        }

        return $user;
    }

    /**
     * Déconnecte l'utilisateur actuel
     */
    public function logoutUser()
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        // Détruire toutes les données de session
        session_destroy();

        return true;
    }

    /**
     * Vérifie si un utilisateur est authentifié
     */
    public function isUserAuthenticated()
    {
        return $this->getCurrentUser() !== null;
    }

    /**
     * Récupère un utilisateur par son ID
     */
    public function getUserById($userId)
    {
        if (empty($userId)) {
            return null;
        }

        return User::find($userId);
    }

    /**
     * Vérifie si un utilisateur peut créer des articles
     */
    public function canCreateArticle($userId)
    {
        if (!$userId) {
            return false;
        }

        $user = $this->getUserById($userId);
        return $user !== null;
    }

    /**
     * Vérifie si un utilisateur peut modifier un article
     */
    public function canEditArticle($userId, $articleId)
    {
        if (!$userId || !$articleId) {
            return false;
        }

        $article = Article::find($articleId);
        if (!$article) {
            return false;
        }

        // Seul l'auteur peut modifier son article
        return $article->author_id == $userId;
    }

    /**
     * Vérifie si un utilisateur peut supprimer un article
     */
    public function canDeleteArticle($userId, $articleId)
    {
        // Même logique que pour l'édition
        return $this->canEditArticle($userId, $articleId);
    }

    /**
     * Récupère un utilisateur par son email
     */
    public function getUserByEmail($email)
    {
        if (empty($email)) {
            return null;
        }

        return User::where('email', $email)->first();
    }

    /**
     * Vérifie si un email est déjà utilisé
     */
    public function emailExists($email)
    {
        if (empty($email)) {
            return false;
        }

        return User::where('email', $email)->exists();
    }

    /**
     * Met à jour le mot de passe d'un utilisateur
     */
    public function updateUserPassword($userId, $newPassword)
    {
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