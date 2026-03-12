package fr.simplon.models;

import java.util.Date;

public class Post implements Comparable<Post>{

    private static long nbPosts = 0;

    private long id;
    private long owner;
    private long parent;
    private String content;
    private Date createdAt;
    private boolean isDraft = false;

    public Post() {
    }

    public Post(long id, long owner, long parent, String content, Date createdAt) {
        this.id = id;
        this.owner = owner;
        this.parent = parent;
        this.content = content;
        this.createdAt = createdAt;
    }

    public Post(long owner, long parent, String content, Date createdAt, boolean isDraft) {
        this.id = ++nbPosts;
        this.owner = owner;
        this.parent = parent;
        this.content = content;
        this.createdAt = createdAt;
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

    public Date getCreatedAt() {
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

    private void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    private void setDraft(boolean draft) {
        isDraft = draft;
    }

    private void toggleDraft(boolean draft) {
        isDraft = !isDraft;
    }



    @Override
    public int compareTo(Post post) {
        return getCreatedAt().compareTo(post.getCreatedAt());
    }

}
