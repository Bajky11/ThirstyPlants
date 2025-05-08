package com.friends.friends.CommandLineRunner;

import com.friends.friends.Entity.Account.Account;
import com.friends.friends.Entity.Flower.Flower;
import com.friends.friends.Entity.Home.Home;
import com.friends.friends.Repository.AccountRepository;
import com.friends.friends.Repository.FlowerRepository;
import com.friends.friends.Repository.HomeRepository;
import jakarta.transaction.Transactional;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;
import java.util.ArrayList;

@Component
public class DataInitializer implements CommandLineRunner {

    private final AccountRepository accountRepository;
    private final HomeRepository homeRepository;
    private final FlowerRepository flowerRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(AccountRepository accountRepository, HomeRepository homeRepository, FlowerRepository flowerRepository, PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.homeRepository = homeRepository;
        this.flowerRepository = flowerRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        /*

        boolean enableInitialization = true;
        if (!enableInitialization) return;

        // 1. vytvoř účty
        Account admin = new Account("admin", passwordEncoder.encode("admin"));

        Account test1 = new Account("test1", passwordEncoder.encode("test"));
        Account test2 = new Account("test2", passwordEncoder.encode("test"));


        // 2. nejprve ulož admina (nutné kvůli Home.owner!)
        accountRepository.save(admin);
        accountRepository.save(test1);
        accountRepository.save(test2);

        // 3. vytvoř Home a nastav vlastníka (už uloženého)
        Home pce = new Home("Pardubice", admin);
        Home na = new Home("Nachod", admin);
        Home nohr = new Home("Novy Hradek", admin);
        Home byst = new Home("Bystre", admin);

        // 4. ulož domácnosti
        homeRepository.save(pce);
        homeRepository.save(na);
        homeRepository.save(nohr);
        homeRepository.save(byst);

        // 5. nastav sdílení domácností
        pce.getAccounts().add(admin);
        na.getAccounts().add(admin);
        nohr.getAccounts().add(admin);
        byst.getAccounts().add(admin);

        admin.getHomes().add(pce);
        admin.getHomes().add(na);
        admin.getHomes().add(nohr);
        admin.getHomes().add(byst);

        // 6. květiny
        Flower sunflower = new Flower("sunflower", 1, pce);
        sunflower.setWatter(ZonedDateTime.now().minusDays(3));

        Flower monstera = new Flower("Monstera", 1, pce);
        monstera.setWatter(ZonedDateTime.now().minusDays(3));
        monstera.setWateringFrequencyDays(7);

        Flower mint = new Flower("mint", 1, pce);

        flowerRepository.save(sunflower);
        flowerRepository.save(monstera);
        flowerRepository.save(mint);

        // 7. znovu ulož admina s napojenými homes
        accountRepository.save(admin);
     */
    }
}


