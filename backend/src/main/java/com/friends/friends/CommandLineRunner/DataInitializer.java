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
import org.springframework.stereotype.Component;

import java.time.ZonedDateTime;
import java.util.ArrayList;

@Component
public class DataInitializer implements CommandLineRunner {

    private final AccountRepository accountRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final HomeRepository homeRepository;
    private final FlowerRepository flowerRepository;

    public DataInitializer(AccountRepository accountRepository, BCryptPasswordEncoder passwordEncoder, HomeRepository homeRepository, FlowerRepository flowerRepository) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = passwordEncoder;
        this.homeRepository = homeRepository;
        this.flowerRepository = flowerRepository;
    }

    @Override
    @Transactional
    public void run(String... args) {
        Account admin = new Account("admin", passwordEncoder.encode("admin"));
        Home pce = new Home("Pardubice");
        Home na = new Home("Nachod");
        Home nohr = new Home("Novy Hradek");
        Home byst = new Home("Bystre");


        // nejdřív ulož home, aby mělo ID
        homeRepository.save(pce);
        homeRepository.save(na);
        homeRepository.save(nohr);
        homeRepository.save(byst);

        Flower sunflower = new Flower("sunflower", pce);
        sunflower.setWatter(ZonedDateTime.now().minusDays(3));

        Flower monstera = new Flower("Monstera", pce);
        monstera.setWatter(ZonedDateTime.now().minusDays(3));
        monstera.setCloudflareImageId("4b54e654-85bb-4ae3-383e-bf6e7f554c00");

        Flower mint = new Flower("mint", pce);

        // přiřazení homes a accounts
        admin.getHomes().add(pce);
        pce.getAccounts().add(admin);

        admin.getHomes().add(na);
        na.getAccounts().add(admin);

        admin.getHomes().add(nohr);
        nohr.getAccounts().add(admin);

        admin.getHomes().add(byst);
        byst.getAccounts().add(admin);

        // ulož květiny (už mají existující home s ID)
        flowerRepository.save(sunflower);
        flowerRepository.save(mint);
        flowerRepository.save(monstera);

        // ulož admina
        accountRepository.save(admin);
    }
}


