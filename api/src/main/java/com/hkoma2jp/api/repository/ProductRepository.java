package com.hkoma2jp.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.hkoma2jp.api.entity.Product;

public interface ProductRepository extends JpaRepository<Product, String> {
    
}
