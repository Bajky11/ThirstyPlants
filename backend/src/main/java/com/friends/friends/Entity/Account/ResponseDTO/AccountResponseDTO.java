package com.friends.friends.Entity.Account.ResponseDTO;

import com.friends.friends.Entity.Account.Account;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountResponseDTO {

    private Long id;
    private String email;
    private String token;

    public AccountResponseDTO(Account account, String token) {
        this.id = account.getId();
        this.email = account.getEmail();
        this.token = token;
    }
}
