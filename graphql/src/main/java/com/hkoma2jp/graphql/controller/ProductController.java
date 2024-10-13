package com.hkoma2jp.graphql.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import com.hkoma2jp.graphql.entity.Product;
import com.hkoma2jp.graphql.service.ProductService;

@Controller
public class ProductController {
    
    @Autowired
    private ProductService productService;

    @QueryMapping
    public Product product(@Argument String id) {
        return productService.getProductById(id);
    }

}

