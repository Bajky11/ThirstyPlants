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

    @Column(nullable = false)
    private ZonedDateTime watter = ZonedDateTime.now();

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "home_id", nullable = false)
    @JsonIgnore
    private Home home;

    public Flower(String name, Home home) {
        this.name = name;
        this.home = home;
    }
}
