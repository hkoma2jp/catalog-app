package com.hkoma2jp.graphql.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hkoma2jp.graphql.entity.Product;

public interface ProductRepository extends JpaRepository<Product, String> {
    
}
