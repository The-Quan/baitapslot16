package org.example.bt_slot16.controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bt_slot16.entities.Products;

import java.io.IOException;

@WebServlet("/products")
public class ProductController extends HttpServlet {
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
        var products = entityManager.createStoredProcedureQuery("getProducts", Products.class).getResultList();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/views/products/Index.jsp").forward(req, resp);
    }
}
