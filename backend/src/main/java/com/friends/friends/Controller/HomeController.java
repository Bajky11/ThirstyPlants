package com.friends.friends.Controller;

import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Entity.Home.Home;
import com.friends.friends.Entity.Home.RequestDTO.ShareHomeRequestDTO;
import com.friends.friends.Entity.Home.RequestDTO.UnshareHomeRequestDTO;
import com.friends.friends.Entity.Home.RequestDTO.addHomeRequestDTO;
import com.friends.friends.Entity.Home.ResponseDTO.HomeDetailResponseDTO;
import com.friends.friends.Repository.AccountRepository;
import com.friends.friends.Repository.HomeRepository;
import com.friends.friends.Service.CurrentUserService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@RestController
@RequestMapping("/home")
public class HomeController {

    private final CurrentUserService currentUserService;
    private final HomeRepository homeRepository;
    private final AccountRepository accountRepository;

    public HomeController(CurrentUserService currentUserService, HomeRepository homeRepository, AccountRepository accountRepository) {
        this.currentUserService = currentUserService;
        this.homeRepository = homeRepository;
        this.accountRepository = accountRepository;
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

        Home home = new Home(request.getName(), currentAccount);
        home.getAccounts().add(currentAccount);

        homeRepository.save(home);

        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{homeId}")
    public ResponseEntity<Void> removeHome(@PathVariable Long homeId) {
        Optional<Home> homeOptional = homeRepository.findById(homeId);

        if (homeOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        homeRepository.delete(homeOptional.get());
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{homeId}")
    public ResponseEntity<HomeDetailResponseDTO> getHomeDetail(@PathVariable Long homeId) {
        return homeRepository.findById(homeId)
                .map(HomeDetailResponseDTO::fromEntity)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/{homeId}/share")
    public ResponseEntity<String> shareHomeWith(@PathVariable Long homeId, @Valid @RequestBody ShareHomeRequestDTO request) {
        Optional<Home> homeOpt = homeRepository.findById(homeId);
        Optional<Account> accountOpt = accountRepository.findByEmail(request.getEmail());

        if (homeOpt.isEmpty() || accountOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Home home = homeOpt.get();
        Account account = accountOpt.get();

        if (home.getAccounts().contains(account)) {
            return ResponseEntity.badRequest().body("Uživatel už má přístup.");
        }

        home.getAccounts().add(account);
        homeRepository.save(home);

        return ResponseEntity.ok("Sdílení přidáno.");
    }

    @DeleteMapping("/{homeId}/share")
    public ResponseEntity<String> UnshareHomeWith(@PathVariable Long homeId, @Valid @RequestBody UnshareHomeRequestDTO request) {
        Optional<Home> homeOpt = homeRepository.findById(homeId);
        Optional<Account> accountOpt = accountRepository.findById(request.getAccountId());

        if (homeOpt.isEmpty() || accountOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Home home = homeOpt.get();
        Account account = accountOpt.get();

        if (!home.getAccounts().contains(account)) {
            return ResponseEntity.badRequest().body("Uživatel nemá přístup.");
        }

        if (home.getOwner().equals(account)) {
            return ResponseEntity.badRequest().body("You cant remove owner.");
        }

        home.getAccounts().remove(account);
        homeRepository.save(home);

        return ResponseEntity.ok("Sdílení odebráno.");
    }
}
