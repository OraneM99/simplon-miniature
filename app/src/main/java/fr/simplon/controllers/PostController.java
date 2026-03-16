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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String feedType = req.getParameter("type");
        if(feedType == null) feedType = "recommendations";

        HttpSession session = req.getSession(false);
        List<Post> filteredPostList = postList;


        req.setAttribute("feedType", feedType);
        req.setAttribute("postList", filteredPostList);
        req.getRequestDispatcher("/feeds.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String newPost = req.getParameter("newPost");
        String newComment = req.getParameter("newComment");

        String buttonLike = req.getParameter("buttonLike");
        String postIdStr = req.getParameter("postId");

        if (newPost != null && !newPost.trim().isEmpty()) {
            String username = (String) session.getAttribute("loggedUser");
            List<User> users = (List<User>) getServletContext().getAttribute("users");
            User owner = findByUserName(username, users);

            if (owner != null) {
                Long postId = System.currentTimeMillis();
                postList.add(
                        new Post(postId, owner.getId(), owner.getUsername(), 0L, newPost.trim()));
                Collections.sort(postList, Comparator.reverseOrder());
            }
        } else if(newComment != null && !newComment.trim().isEmpty() && postIdStr != null){
            try{
                long postId = Long.parseLong(postIdStr);
                String username = (String) session.getAttribute("loggedUser");
                List<User> users = (List<User>) getServletContext().getAttribute("users");
                User owner = findByUserName(username, users);
                if (owner != null) {
                    Post post = findPostById(postId);
                    if (post != null) {
                        // ✅ Appel simplifié
                        post.addComment(owner.getId(), owner.getUsername(), newComment.trim());
                    }
                }
            } catch (NumberFormatException e) {
                resp.sendError(400, "ID invalide.");
                return;
            }
        }

        else if(buttonLike != null) {
            try {
                long likePostId = Long.parseLong(buttonLike);
                for (Post post : postList) {
                    if (post.getId() == likePostId) {
                        post.toggleLike();
                        break;
                    }
                }
            } catch (NumberFormatException e) {
                resp.sendError(400, "ID invalide.");
                return;
            }

        }
        resp.sendRedirect(req.getContextPath() + "/feeds");
    }

    private Post findPostById(long postId) {
        for(Post post : postList){
            if(post.getId() == postId){
                return post;
            }
        }
        return null;
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
