package fr.simplon.models;

import java.util.ArrayList;
import java.util.List;

public class User {

    private long id;
    private String username;
    private String email;
    private String password;

    private List<Long> followings = new ArrayList<>();

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public User(long id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    public long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    private void setId(long id) {
        this.id = id;
    }

    private void setUsername(String username) {
        this.username = username;
    }

    private void setEmail(String email) {
        this.email = email;
    }

    private void setPassword(String password) {
        this.password = password;
    }

    public List<Long> getFollowings() {
        return followings;
    }

    public void setFollowings(List<Long> followings) {
        this.followings = followings;
    }

    public void follow (long userId){
        if(!followings.contains(userId)){
            followings.add(userId);
        }
    }

    public void unfollow (long userId){
        followings.remove(userId);
    }
    public boolean isFollowing(long userId){
        return followings.contains(userId);
    }
}
