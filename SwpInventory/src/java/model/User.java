package model;

public class User {

    private String username;
    private String password;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String image;
    private int role;
    private int isApproved;

    // Constructor
    public User(String username, String password, String name, String email, String phone, String address, int role, String image, int isApproved) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.image = image;
        this.isApproved = isApproved;
    }

    // Default constructor (nên có nếu dùng Bean hoặc ResultSet mapping)
    public User() {}

    // Getters & Setters
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public int getRole() {
        return role;
    }
    public void setRole(int role) {
        this.role = role;
    }

    public int getIsApproved() {
        return isApproved;
    }
    public void setIsApproved(int isApproved) {
        this.isApproved = isApproved;
    }
}