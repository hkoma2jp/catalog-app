package com.hkoma2jp.api.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Data;

@Entity
@Data
@Table(name = "categories")
public class Category {

    @Id
    private String id;

    @Column(nullable = false)
    private String name;

    private String displayName;

    @Column(nullable = false)
    private int leftBound;

    @Column(nullable = false)
    private int rightBound;

    private String parentId;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime updatedAt;

    private LocalDateTime deletedAt;

}
