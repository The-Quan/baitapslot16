package org.example.bt_slot16.controller;

import com.google.gson.Gson;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bt_slot16.entities.Products;
import org.example.bt_slot16.entities.Users;

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
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("deleteProduct");
        query.registerStoredProcedureParameter("id", Integer.class, ParameterMode.IN);
        query.setParameter("id", id);
        query.execute();
        entityManager.getTransaction().commit();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var product_name = req.getParameter("product_name");
        var description = req.getParameter("description");
        var price = Double.valueOf(req.getParameter("price"));
        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("createProduct");

        query.registerStoredProcedureParameter("productName", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("description", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("price", Double.class, ParameterMode.IN);

        query.setParameter("productName", product_name);
        query.setParameter("description", description);
        query.setParameter("price", price);

        query.execute();
        entityManager.getTransaction().commit();
        var products = entityManager.createStoredProcedureQuery("getProducts", Products.class).getResultList();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/views/products/Index.jsp").forward(req, resp);
    }
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Products products = gson.fromJson(req.getReader(), Products.class);

        int id = products.getProduct_id();
        String productName = products.getProduct_name();
        String description = products.getDescription();
        Double price = products.getPrice();

        System.out.println(id + productName + description + price);

        if (!entityManager.getTransaction().isActive()) {
            entityManager.getTransaction().begin();
        }
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("updateProduct");

        query.registerStoredProcedureParameter("id", Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_product_name", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_description", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_price", Double.class, ParameterMode.IN);

        query.setParameter("id", id);
        query.setParameter("new_product_name", productName);
        query.setParameter("new_description", description);
        query.setParameter("new_price", price);

        query.execute();
        entityManager.getTransaction().commit();
    }
}
