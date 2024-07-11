package com.easybackend.config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MongoConfig {
    @Bean
    public MongoClient mongoClient(@Value("${spring.data.mongodb.uri}") String connectionString) {
        MongoClient mc = null;
        try {
            mc = MongoClients.create(connectionString);
            System.err.println("Successfully connected to Mongo");
        }catch (Exception ex){
            System.err.println("Failed to connect to Mongo: " + ex.getMessage());
            ex.printStackTrace();
        }
        return mc;
    }
}


