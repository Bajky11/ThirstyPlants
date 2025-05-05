package com.friends.friends.Controller;

import com.friends.friends.Config.JwtService;
import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Entity.Account.RequestDTO.AccountLoginRequestDTO;
import com.friends.friends.Entity.Account.RequestDTO.AccountRegisterRequestDTO;
import com.friends.friends.Entity.Account.ResponseDTO.AccountResponseDTO;
import com.friends.friends.Repository.AccountRepository;
import com.friends.friends.Service.CurrentUserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AccountRepository accountRepository;

    @Autowired
    private CurrentUserService currentUserService;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public AuthController(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @PostMapping("/health")
    public ResponseEntity<Void> health() {
        return ResponseEntity.ok().build();
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody AccountRegisterRequestDTO request) {
        Optional<Account> accountOptional = accountRepository.findByEmail(request.getEmail());

        if (accountOptional.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Účet s tímto e-mailem již existuje.");
        }

        Account account = new Account(
                request.getEmail(),
                passwordEncoder.encode(request.getPassword())
        );

        accountRepository.save(account);
        String token = jwtService.generateToken(account.getId());
        return ResponseEntity.ok(new AccountResponseDTO(account, token));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody AccountLoginRequestDTO request) {
        Optional<Account> accountOptional = accountRepository.findByEmail(request.getEmail());

        if (accountOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Účet s tímto e-mailem neexistuje.");
        }

        Account account = accountOptional.get();

        if (!passwordEncoder.matches(request.getPassword(), account.getPasswordHash())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Nesprávné heslo.");
        }

        String token = jwtService.generateToken(account.getId());
        return ResponseEntity.ok(new AccountResponseDTO(account, token));
    }

    @GetMapping("/account")
    public ResponseEntity<?> loginWithToken() {
        Account account = currentUserService.getCurrentAccount();
        return ResponseEntity.ok(account);
    }
}