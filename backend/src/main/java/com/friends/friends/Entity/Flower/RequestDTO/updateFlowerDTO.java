package com.friends.friends.Entity.Flower.RequestDTO;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;

@Getter
@Setter
public class updateFlowerDTO {
    private String name;

    private ZonedDateTime watter;
}