package com.friends.friends.Controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/health")
public class HealthController {

    @PostMapping()
    public ResponseEntity<Void> health() {
        return ResponseEntity.ok().build();
    }
}
