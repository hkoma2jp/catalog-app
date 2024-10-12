package com.hkoma2jp.api.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Data;

@Entity
@Data
@Table(name = "specs")
public class Spec {

    @Id
    private String id;

    @ManyToOne
    @JoinColumn(name = "sku_id", referencedColumnName = "id")
    private Sku sku;

    @Column(nullable = false)
    private String specName;

    @Column(nullable = false)
    private String specValue;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime updatedAt;

    private LocalDateTime deletedAt;

}
