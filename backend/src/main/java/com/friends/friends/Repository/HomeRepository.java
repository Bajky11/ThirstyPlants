package com.friends.friends.Repository;

import com.friends.friends.Entity.Home.Home;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HomeRepository extends JpaRepository<Home, Long> {
    @Query(
            value = """
        SELECT h.* FROM home h
        JOIN home_account ha ON h.id = ha.home_id
        WHERE ha.account_id = :accountId
        """,
            nativeQuery = true
    )
    List<Home> findHomesByAccountId(@Param("accountId") Long accountId);
}

