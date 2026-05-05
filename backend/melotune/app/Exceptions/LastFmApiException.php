<?php

declare(strict_types=1);

namespace App\Exceptions;

use RuntimeException;

/**
 * Se lanza cuando la API de Last.fm devuelve un error o una respuesta no exitosa.
 */
class LastFmApiException extends RuntimeException
{
    public function __construct(string $message, private readonly string $method = '')
    {
        parent::__construct($message);
    }

    public function getLastFmMethod(): string
    {
        return $this->method;
    }
}
