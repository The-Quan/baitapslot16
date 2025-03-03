package org.example.bt_slot16.controller;

import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bt_slot16.entities.Orders;
import org.example.bt_slot16.entities.Products;
import org.example.bt_slot16.entities.Users;
import org.example.bt_slot16.entities.response.OrderResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    EntityManagerFactory entityManagerFactory;
    EntityManager entityManager;

    @Override
    public void init() throws ServletException {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
        System.out.println("Init");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("getOrders");

        List<Object[]> results = query.getResultList();

        List<OrderResponse> orders = results.stream().map(obj -> new OrderResponse(
                (Integer) obj[0], (Integer) obj[1], (String) obj[2], (String) obj[3], (String) obj[4],
                (Integer) obj[5], (String) obj[6], (Double) obj[7]
        )).toList();

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/orders/index.jsp").forward(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("deleteOrder");
        query.registerStoredProcedureParameter("id", Integer.class, ParameterMode.IN);
        query.setParameter("id", id);
        query.execute();
        entityManager.getTransaction().commit();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var userId = Integer.valueOf(req.getParameter("userId"));
        var productId = Integer.valueOf(req.getParameter("productId"));
        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("createOrder");

        query.registerStoredProcedureParameter("userId", Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("productId", Integer.class, ParameterMode.IN);


        query.setParameter("userId", userId);
        query.setParameter("productId", productId);


        query.execute();
        entityManager.getTransaction().commit();
        var orders = entityManager.createStoredProcedureQuery("getOrders", Orders.class).getResultList();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/orders/index.jsp").forward(req, resp);
    }
}
