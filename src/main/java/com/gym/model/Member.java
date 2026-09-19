package com.gym.model;

import javax.persistence.*;
import java.sql.Date;

/**
 * 会员实体类
 */
@Entity
@Table(name = "member")
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String gender;
    private String phone;
    private String email;

    @Column(name = "join_date")
    private Date joinDate;

    @Column(name = "expiry_date")
    private Date expiryDate;

    @Column(name = "membership_type")
    private String membershipType; // 月卡/季卡/年卡

    private String status; // 正常/过期/暂停
    private String password;

    public Member() {}

    public Member(String name, String gender, String phone, String email,
                  Date joinDate, Date expiryDate, String membershipType, String status) {
        this.name = name;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.joinDate = joinDate;
        this.expiryDate = expiryDate;
        this.membershipType = membershipType;
        this.status = status;
    }

    // Getters and Setters（保持不变，略）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Date getJoinDate() { return joinDate; }
    public void setJoinDate(Date joinDate) { this.joinDate = joinDate; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

    public String getMembershipType() { return membershipType; }
    public void setMembershipType(String membershipType) { this.membershipType = membershipType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}