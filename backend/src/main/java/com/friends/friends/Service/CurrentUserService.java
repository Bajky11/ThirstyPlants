package com.friends.friends.Service;

import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Exception.AccountNotFoundException;
import com.friends.friends.Exception.InvalidTokenException;
import com.friends.friends.Repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class CurrentUserService {

    @Autowired()
    AccountRepository accountRepository;

    public Account getCurrentAccount() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !(authentication.getPrincipal() instanceof Long)) {
            throw new InvalidTokenException();
        }

        Long accountId = (Long) authentication.getPrincipal();

        return accountRepository.findById(accountId)
                .orElseThrow(AccountNotFoundException::new);
    }
}
