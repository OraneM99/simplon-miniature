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
    private Set<Long> likedByUserIds = new HashSet<>();

    private String mediaUrl;
    private AttachmentType attachmentType = AttachmentType.NONE;

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

    public Post(long id, long owner, String ownerUsername, long parent, String content, String mediaUrl,
            AttachmentType attachmentType) {
        this.id = ++nbPosts;
        this.owner = owner;
        this.ownerUsername = ownerUsername;
        this.parent = parent;
        this.content = content;
        this.createdAt = LocalDateTime.now();
        this.mediaUrl = mediaUrl;
        this.attachmentType = attachmentType != null ? attachmentType : AttachmentType.NONE;
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

    public int getLikeCount() {
        return likedByUserIds.size();
    }

    public boolean isLikedBy(long userId) {
        return likedByUserIds.contains(userId);
    }

    public void toggleLike(long userId) {
        if (likedByUserIds.contains(userId)) {
            likedByUserIds.remove(userId);
        } else {
            likedByUserIds.add(userId);
        }
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

    public void setComments(List<Map<String, Object>> comments) {
        this.comments = comments;
    }

    public String getMediaUrl() {
        return mediaUrl;
    }

    private void setMediaUrl(String mediaUrl) {
        this.mediaUrl = mediaUrl;
    }

    public AttachmentType getAttachmentType() {
        return attachmentType;
    }

    private void setAttachmentType(AttachmentType attachmentType) {
        this.attachmentType = attachmentType;
    }

    public boolean hasMedia() {
        return attachmentType != null
                && attachmentType != AttachmentType.NONE
                && mediaUrl != null
                && !mediaUrl.isBlank();
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
