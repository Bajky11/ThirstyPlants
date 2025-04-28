package com.friends.friends.Repository;

import com.friends.friends.Entity.Flower.Flower;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FlowerRepository extends JpaRepository<Flower, Long> {
    List<Flower> findByHomeId(Long homeId);
}
