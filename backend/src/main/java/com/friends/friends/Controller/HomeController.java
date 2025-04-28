package com.friends.friends.Controller;

import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Entity.Home.Home;
import com.friends.friends.Entity.Home.RequestDTO.addHomeRequestDTO;
import com.friends.friends.Repository.HomeRepository;
import com.friends.friends.Service.CurrentUserService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/home")
public class HomeController {

    private final CurrentUserService currentUserService;
    private final HomeRepository homeRepository;

    public HomeController(CurrentUserService currentUserService, HomeRepository homeRepository) {
        this.currentUserService = currentUserService;
        this.homeRepository = homeRepository;
    }

    @PostMapping("/health")
    public ResponseEntity<Void> health() {
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<List<Home>> getUserHomes() {
        Long accountId = currentUserService.getCurrentAccount().getId();
        List<Home> homes = homeRepository.findHomesByAccountId(accountId);
        return ResponseEntity.ok(homes);
    }

    @PostMapping()
    public ResponseEntity<Void> addHome(@RequestBody @Valid addHomeRequestDTO request) {
        Account currentAccount = currentUserService.getCurrentAccount();

        Home home = new Home(request.getName());
        home.getAccounts().add(currentAccount);

        homeRepository.save(home);

        return ResponseEntity.ok().build();
    }

    @DeleteMapping()
    public ResponseEntity<Void> removeHome(@RequestParam Long id) {
        Optional<Home> home = homeRepository.findById(id);

        if (homeRepository.findById(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        homeRepository.delete(home.get());
        return ResponseEntity.ok().build();
    }
}
