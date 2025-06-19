package model;

import java.util.Date;

public class SystemLog {
    private int id;
    private String username;
    private String action;
    private String details;
    private Date logTime;

    public SystemLog() {}

    public SystemLog(int id, String username, String action, String details, Date logTime) {
        this.id = id;
        this.username = username;
        this.action = action;
        this.details = details;
        this.logTime = logTime;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }
    public Date getLogTime() { return logTime; }
    public void setLogTime(Date logTime) { this.logTime = logTime; }
}