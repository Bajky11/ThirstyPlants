package com.friends.friends.Entity.Account;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.friends.friends.Entity.Home.Home;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    @JsonIgnore
    private String passwordHash;

    @ManyToMany(mappedBy = "accounts")
    @JsonIgnore
    private Set<Home> homes = new HashSet<>();

    public Account(String email, String passwordHash) {
        this.email = email;
        this.passwordHash = passwordHash;
    }
}


