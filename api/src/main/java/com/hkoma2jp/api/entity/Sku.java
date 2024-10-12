package com.hkoma2jp.api.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Data
@Table(name = "skus")
public class Sku {

    @Id
    private String id;

    @Column(nullable = false)
    private String name;

    private String displayName;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    @JsonIgnore
    private Product product;

    @Column(nullable = false)
    private double listPrice;

    @Column(nullable = false)
    private double price;

    @OneToMany(mappedBy = "sku", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<Spec> specs;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime updatedAt;

    private LocalDateTime deletedAt;

}
