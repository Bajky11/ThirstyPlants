package com.friends.friends.Exception;

import org.springframework.http.HttpStatus;

public class InvalidTokenException extends ApiException {
    public InvalidTokenException() {
        super("Neplatný nebo chybějící token", "INVALID_TOKEN", HttpStatus.UNAUTHORIZED);
    }
}
