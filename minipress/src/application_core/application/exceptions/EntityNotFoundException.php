<?php

namespace minipress\application_core\application\exceptions;

class EntityNotFoundException extends \Exception
{
    public function __construct(string $entityType = '', string $id = '')
    {
        $message = ($entityType && $id)
            ? "L'entité '$entityType' avec l'id '$id' est introuvable."
            : "Entité introuvable.";
        parent::__construct($message, 404);
    }
}
