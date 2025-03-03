package org.example.bt_slot16.controller;

import com.google.gson.Gson;
import jakarta.persistence.*;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bt_slot16.entities.Users;

import java.io.IOException;

@WebServlet("/users")
public class UserController extends HttpServlet {
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
        var users = entityManager.createStoredProcedureQuery("getUsersAll", Users.class).getResultList();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/views/users/Index.jsp").forward(req, resp);
    }


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("deleteUser");
        query.registerStoredProcedureParameter("id", Integer.class, ParameterMode.IN);
        query.setParameter("id", id);
        query.execute();
        entityManager.getTransaction().commit();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var username = req.getParameter("username");
        var email = req.getParameter("email");
        var phone = req.getParameter("phone");
        var address = req.getParameter("address");
        entityManager.getTransaction().begin();
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("createUser");

        query.registerStoredProcedureParameter("username", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("email", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("phone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("address", String.class, ParameterMode.IN);

        query.setParameter("username", username);
        query.setParameter("email", email);
        query.setParameter("phone", phone);
        query.setParameter("address", address);

        query.execute();
        entityManager.getTransaction().commit();
        var users = entityManager.createStoredProcedureQuery("getUsersAll", Users.class).getResultList();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/views/users/Index.jsp").forward(req, resp);
    }
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Users users = gson.fromJson(req.getReader(), Users.class);

        int id = users.getUser_id();
        String newName = users.getUsername();
        String email = users.getEmail();
        String phone = users.getPhone();
        String address = users.getAddress();

        System.out.println(id + newName + email + phone + address);

        if (!entityManager.getTransaction().isActive()) {
            entityManager.getTransaction().begin();
        }
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("updateUser");

        query.registerStoredProcedureParameter("id", Integer.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_username", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_email", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_phone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("new_address", String.class, ParameterMode.IN);

        query.setParameter("id", id);
        query.setParameter("new_username", newName);
        query.setParameter("new_email", email);
        query.setParameter("new_phone", phone);
        query.setParameter("new_address", address);

        query.execute();
        entityManager.getTransaction().commit();

        Users updatedUser = entityManager.find(Users.class, id);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setStatus(HttpServletResponse.SC_OK);
        resp.getWriter().write(gson.toJson(updatedUser));
    }
}
