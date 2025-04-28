package com.friends.friends.Entity.Flower.RequestDTO;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class addFlowerRequestDTO {
    @NotNull(message = "name can not be null.")
    @NotBlank(message = "name can not be blank.")
    private String name;

    @NotNull(message = "Home id can not be null.")
    private Long homeId;
}
