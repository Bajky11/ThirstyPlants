package com.friends.friends.Entity.Account.RequestDTO;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountRegisterRequestDTO {

    @NotNull(message = "Email účtu je povinný.")
    @NotBlank(message = "Email je povinný.")
    @Email(message = "Email must have valid format.")
    private String email;

    @NotNull(message = "Heslo účtu je povinný.")
    @NotBlank(message = "Heslo je povinné.")
    //@Size(min = 8, message = "Heslo musí mít alespoň 8 znaků.")
    private String password;
}
