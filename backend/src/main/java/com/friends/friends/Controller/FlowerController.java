package com.friends.friends.Controller;

import com.friends.friends.Entity.Flower.Flower;
import com.friends.friends.Entity.Flower.RequestDTO.addFlowerRequestDTO;
import com.friends.friends.Entity.Flower.RequestDTO.updateFlowerDTO;
import com.friends.friends.Entity.Flower.ResponseDTO.FlowerResponseDTO;
import com.friends.friends.Entity.Home.Home;
import com.friends.friends.Repository.FlowerRepository;
import com.friends.friends.Repository.HomeRepository;
import jakarta.validation.Valid;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/flower")
public class FlowerController {

    private final HomeRepository homeRepository;
    private final FlowerRepository flowerRepository;

    public FlowerController(HomeRepository homeRepository, FlowerRepository flowerRepository) {
        this.homeRepository = homeRepository;
        this.flowerRepository = flowerRepository;
    }

    @PostMapping("/health")
    public ResponseEntity<Void> health() {
        return ResponseEntity.ok().build();
    }

    @PostMapping()
    public ResponseEntity<Void> addFlower(@Valid @RequestBody addFlowerRequestDTO request) {
        Optional<Home> home = homeRepository.findById(request.getHomeId());

        if (home.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Flower flower = new Flower(request.getName(), home.get());
        if(request.getCloudflareImageId() != null){
            flower.setCloudflareImageId(request.getCloudflareImageId());
        }

        flowerRepository.save(flower);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<List<FlowerResponseDTO>> getFlowersByHomeId(@RequestParam Long homeId) {
        if (homeId == null) throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Parameter 'homeId' is required");


        Optional<Home> home = homeRepository.findById(homeId);

        if (home.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        List<FlowerResponseDTO> homeFlowers = flowerRepository.findByHomeId(homeId)
                .stream()
                .map(FlowerResponseDTO::fromEntity)
                .toList();

        return ResponseEntity.ok(homeFlowers);
    }

    @PatchMapping()
    public ResponseEntity<Void> patchFlower(@RequestParam Long flowerId, @Valid @RequestBody updateFlowerDTO request) {
        Flower flower = flowerRepository.findById(flowerId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
        System.out.println("UPDATING");
        if (request.getName() != null) {
            flower.setName(request.getName());
        }

        if (request.getWatter() != null) {
            System.out.println("Updating watter to: " + request.getWatter());
            flower.setWatter(request.getWatter());
        } else {
            System.out.println("Request watter is null - not updating.");
        }

        flowerRepository.save(flower);

        return ResponseEntity.ok().build();
    }

    // TODO: Remove flower image from image storage
    @DeleteMapping()
    public ResponseEntity<Void> deleteFlower(@RequestParam Long flowerId) {
        Optional<Flower> flower = flowerRepository.findById(flowerId);

        if (flower.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        flowerRepository.delete(flower.get());
        return ResponseEntity.ok().build();
    }
}
