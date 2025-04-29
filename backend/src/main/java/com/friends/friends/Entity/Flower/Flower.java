package com.friends.friends.Entity.Flower;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.friends.friends.Entity.Home.Home;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.ZonedDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Flower {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    private String cloudflareImageId = null;

    @Column(nullable = false)
    private String name;

    // flower is created with 100 years before now() so immediately after creation it needs watter, then according wateringFrequencyDays.
    @Column(nullable = false)
    private ZonedDateTime watter = ZonedDateTime.now().minusYears(100);

    @Column(nullable = false)
    private int wateringFrequencyDays = 1;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "home_id", nullable = false)
    @JsonIgnore
    private Home home;

    public Flower(String name,int  wateringFrequencyDays,Home home) {
        this.name = name;
        this.wateringFrequencyDays = wateringFrequencyDays;
        this.home = home;
    }
}
