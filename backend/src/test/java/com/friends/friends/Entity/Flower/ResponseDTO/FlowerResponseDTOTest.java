package com.friends.friends.Entity.Flower.ResponseDTO;

import org.junit.jupiter.api.Test;
import java.time.ZonedDateTime;

import static org.junit.jupiter.api.Assertions.*;

class FlowerResponseDTOTest {

    @Test
    void shouldNeedWateringExactlyOnBoundary() {
        ZonedDateTime lastWatered = ZonedDateTime.now().minusDays(3);
        int frequency = 3;

        boolean result = FlowerResponseDTO.calculateIfNeedWatter(lastWatered, frequency);

        assertTrue(result, "Květina by měla potřebovat zalít přesně v den, kdy je dosaženo intervalu.");
    }

    @Test
    void shouldNotNeedWateringBeforeBoundary() {
        ZonedDateTime lastWatered = ZonedDateTime.now().minusDays(2);
        int frequency = 3;

        boolean result = FlowerResponseDTO.calculateIfNeedWatter(lastWatered, frequency);

        assertFalse(result, "Květina by neměla potřebovat zalít před dosažením intervalu.");
    }

    @Test
    void shouldNeedWateringAfterBoundary() {
        ZonedDateTime lastWatered = ZonedDateTime.now().minusDays(4);
        int frequency = 3;

        boolean result = FlowerResponseDTO.calculateIfNeedWatter(lastWatered, frequency);

        assertTrue(result, "Květina by měla potřebovat zalít po překročení intervalu.");
    }

    @Test
    void shouldAlwaysNeedWateringWhenFrequencyIsZero() {
        ZonedDateTime lastWatered = ZonedDateTime.now();
        int frequency = 0;

        boolean result = FlowerResponseDTO.calculateIfNeedWatter(lastWatered, frequency);

        assertTrue(result, "Při frekvenci 0 by měla květina vždy potřebovat zalít.");
    }

    @Test
    void shouldHandleNegativeFrequencySafely() {
        ZonedDateTime lastWatered = ZonedDateTime.now();
        int frequency = -3;

        boolean result = FlowerResponseDTO.calculateIfNeedWatter(lastWatered, frequency);

        assertTrue(result, "Při záporné frekvenci by měla květina vždy potřebovat zalít.");
    }
}