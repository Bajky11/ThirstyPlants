package com.friends.friends.Entity.Home.ResponseDTO;

import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Entity.Home.Home;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HomeDetailResponseDTO {
    private Long id;
    private String name;
    private Account owner;
    private List<Account> accounts;

    public static HomeDetailResponseDTO fromEntity(Home home) {
        Account owner = home.getOwner();

        List<Account> nonOwnerAccounts = home.getAccounts().stream().filter(account -> !account.getId().equals(owner.getId())).collect(Collectors.toList());

        return new HomeDetailResponseDTO(home.getId(), home.getName(), owner, nonOwnerAccounts);
    }
}