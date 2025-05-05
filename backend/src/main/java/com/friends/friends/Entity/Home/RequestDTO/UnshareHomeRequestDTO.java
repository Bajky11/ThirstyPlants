package com.friends.friends.Entity.Home.RequestDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UnshareHomeRequest {
    private Long accountId;

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }
}
