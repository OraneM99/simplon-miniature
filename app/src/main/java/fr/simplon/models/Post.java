package fr.simplon.models;

import java.time.LocalDateTime;
import java.util.*;

public class Post implements Comparable<Post> {

    private static long nbPosts = 0;
    private List<Map<String, Object>> comments = new ArrayList<>();

    private long id;
    private long owner;
    private String ownerUsername;
    private long parent;
    private String content;
    private LocalDateTime createdAt;
    private boolean isDraft = false;
    private boolean isLiked = false;

    public Post() {
    }

    public Post(long id, long owner, String ownerUsername, long parent, String content) {
        this.id = ++nbPosts;
        this.owner = owner;
        this.ownerUsername = ownerUsername;
        this.parent = parent;
        this.content = content;
        this.createdAt = LocalDateTime.now();
    }

    public Post(long owner, long parent, String content, Date createdAt, boolean isDraft) {
        this.id = ++nbPosts;
        this.owner = owner;
        this.parent = parent;
        this.content = content;
        this.createdAt = LocalDateTime.now();
        this.isDraft = isDraft;
    }

    public long getId() {
        return id;
    }

    public long getOwner() {
        return owner;
    }

    public long getParent() {
        return parent;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public boolean isDraft() {
        return isDraft;
    }

    private void setId(long id) {
        this.id = id;
    }

    private void setOwner(long owner) {
        this.owner = owner;
    }

    private void setParent(long parent) {
        this.parent = parent;
    }

    private void setContent(String content) {
        this.content = content;
    }

    private void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    private void setDraft(boolean draft) {
        isDraft = draft;
    }

    private void toggleDraft(boolean draft) {
        isDraft = !isDraft;
    }

    public boolean isLiked() {
        return isLiked;
    }

    public void toggleLike() {
        isLiked = !isLiked;
    }

    public static long getNbPosts() {
        return nbPosts;
    }

    public static void setNbPosts(long nbPosts) {
        Post.nbPosts = nbPosts;
    }

    public String getOwnerUsername() {
        return ownerUsername;
    }

    public void setOwnerUsername(String ownerUsername) {
        this.ownerUsername = ownerUsername;
    }

    @Override
    public int compareTo(Post post) {
        return getCreatedAt().compareTo(post.getCreatedAt());
    }

    public void addComment(long userId, String username, String content) {
        Map<String, Object> comment = new HashMap<>();
        comment.put("username", username);
        comment.put("content", content);
        comment.put("createdAt", LocalDateTime.now());
        comments.add(comment);
    }

    public List<Map<String, Object>> getComments() {
        return comments;
    }

}
