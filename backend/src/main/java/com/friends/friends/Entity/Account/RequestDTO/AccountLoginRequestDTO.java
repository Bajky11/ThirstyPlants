package com.friends.friends.Entity.Account.RequestDTO;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountLoginRequestDTO {
    @NotNull(message = "Email can not be null.")
    @NotBlank(message = "Email can not be blank.")
    private String email;
    @NotNull(message = "Password can not be null.")
    @NotBlank(message = "Password can not be blank.")
    private String password;
}

/*
{
    "email": "email1",
    "password": "heslo"
}
 */