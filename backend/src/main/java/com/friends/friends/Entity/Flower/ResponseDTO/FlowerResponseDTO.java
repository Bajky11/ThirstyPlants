package com.friends.friends.Entity.Flower.ResponseDTO;

import com.friends.friends.Entity.Flower.Flower;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;

@Getter
@Setter
public class FlowerResponseDTO {
    private int id;
    private String cloudflareImageId;
    private String name;
    private boolean needWatter;

    public static boolean calculateIfNeedWatter(ZonedDateTime lastWaterDate, int wateringFrequencyDays) {
        return !lastWaterDate.toLocalDate().plusDays(wateringFrequencyDays).isAfter(ZonedDateTime.now().toLocalDate());
    }

    public static FlowerResponseDTO fromEntity(Flower flower) {
        FlowerResponseDTO dto = new FlowerResponseDTO();
        dto.setId(flower.getId().intValue());
        dto.setCloudflareImageId(flower.getCloudflareImageId());
        dto.setName(flower.getName());
        dto.setNeedWatter(calculateIfNeedWatter(flower.getWatter(), flower.getWateringFrequencyDays()));
        return dto;
    }
}
