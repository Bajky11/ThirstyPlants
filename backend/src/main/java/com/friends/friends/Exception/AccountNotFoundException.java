package com.friends.friends.Exception;

import org.springframework.http.HttpStatus;

public class AccountNotFoundException extends ApiException {
    public AccountNotFoundException() {
        super("Účet nebyl nalezen", "ACCOUNT_NOT_FOUND", HttpStatus.NOT_FOUND);
    }
}
