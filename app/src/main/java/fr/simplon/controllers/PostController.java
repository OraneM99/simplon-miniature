package fr.simplon.controllers;

import fr.simplon.models.Post;
import fr.simplon.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.jspecify.annotations.NonNull;

import java.io.IOException;
import java.util.*;

@WebServlet("/feeds")
public class PostController extends HttpServlet {

    private List<@NonNull Post> postList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("postList", postList);
        req.getRequestDispatcher("/feeds.jsp").forward(req, resp);

    }

    // créer un post
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String newPost = req.getParameter("newPost");
        // Long postId = Long.parseLong(req.getParameter("postId"));
        // Long parentPost = Long.parseLong(req.getParameter("parent"));
        Long postId = System.currentTimeMillis();
        // String buttonLike = req.getParameter("buttonLike");

        if (newPost != null && !newPost.trim().isEmpty()) {
            String username = (String) session.getAttribute("loggedUser");

            List<User> users = (List<User>) getServletContext().getAttribute("users");
            User owner = findByUserName(username, users);

            if (owner != null) {
                postList.add(
                        new Post(postId, owner.getId(), owner.getUsername(), 0L, newPost.trim()));
                Collections.sort(postList, Comparator.reverseOrder());
            }
        }
        resp.sendRedirect(req.getContextPath() + "/feeds");
    }

    private User findByUserName(String username, List<User> users) {
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

}
