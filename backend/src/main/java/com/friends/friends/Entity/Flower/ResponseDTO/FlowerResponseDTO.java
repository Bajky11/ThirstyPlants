package com.friends.friends.Entity.Flower.ResponseDTO;

import com.friends.friends.Entity.Flower.Flower;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;

@Getter
@Setter
public class FlowerResponseDTO {
    private int id;
    private String cloudflareImageId;
    private String name;
    private boolean needWatter;
    private int daysUntilNextWatering;
    private int wateringFrequencyDays;

    public static boolean calculateIfNeedWatter(ZonedDateTime lastWaterDate, int wateringFrequencyDays) {
        return !lastWaterDate.toLocalDate().plusDays(wateringFrequencyDays).isAfter(ZonedDateTime.now().toLocalDate());
    }

    public static int calculateDaysUntilNextWatering(ZonedDateTime lastWaterDate, int wateringFrequencyDays) {
        ZonedDateTime nextWaterDate = lastWaterDate.plusDays(wateringFrequencyDays);
        long daysBetween = ChronoUnit.DAYS.between(ZonedDateTime.now().toLocalDate(), nextWaterDate.toLocalDate());
        return (int) Math.max(daysBetween, 0);
    }

    public static FlowerResponseDTO fromEntity(Flower flower) {
        FlowerResponseDTO dto = new FlowerResponseDTO();
        dto.setId(flower.getId().intValue());
        dto.setCloudflareImageId(flower.getCloudflareImageId());
        dto.setName(flower.getName());
        dto.setNeedWatter(calculateIfNeedWatter(flower.getWatter(), flower.getWateringFrequencyDays()));
        dto.setDaysUntilNextWatering(calculateDaysUntilNextWatering(flower.getWatter(), flower.getWateringFrequencyDays()));
        dto.setWateringFrequencyDays(flower.getWateringFrequencyDays());
        return dto;
    }
}