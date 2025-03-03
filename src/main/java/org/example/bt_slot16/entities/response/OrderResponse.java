package org.example.bt_slot16.entities.response;

import jakarta.persistence.EntityResult;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderResponse {
    private int order_id;
    private int user_id;
    private String username;
    private String email;
    private String phone;
    private int product_id;
    private String product_name;
    private Double price;
}
