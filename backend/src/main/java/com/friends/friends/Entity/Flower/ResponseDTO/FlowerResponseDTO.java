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

    private static boolean calculateIfNeedWatter(ZonedDateTime lastWatterDate) {
        return lastWatterDate.isBefore(ZonedDateTime.now().minusDays(1));
    }

    public static FlowerResponseDTO fromEntity(Flower flower) {
        FlowerResponseDTO dto = new FlowerResponseDTO();
        dto.setId(flower.getId().intValue());
        dto.setCloudflareImageId(flower.getCloudflareImageId());
        dto.setName(flower.getName());
        dto.setNeedWatter(calculateIfNeedWatter(flower.getWatter()));
        return dto;
    }
}
