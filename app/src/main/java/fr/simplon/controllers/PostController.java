package fr.simplon.controllers;

import fr.simplon.models.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jspecify.annotations.NonNull;

import java.io.IOException;
import java.util.*;

@WebServlet("/feeds")
public class PostController extends HttpServlet {

    private List<@NonNull Post> postList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("postList", postList);
        req.getRequestDispatcher("/feeds.jsp").forward(req,resp);

    }

    //créer un post
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newPost = req.getParameter("newPost");
        Long ownerId = Long.parseLong(req.getParameter("ownerId"));

        if(newPost != null && !newPost.trim().isEmpty()){
            postList.add(new Post(ownerId, newPost.trim(),new Date()));
            Collections.sort(postList, Comparator.reverseOrder());
        }

        resp.sendRedirect(req.getContextPath()+"/feeds");
    }
}
