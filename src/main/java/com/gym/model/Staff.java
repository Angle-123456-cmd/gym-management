package com.gym.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;   // 改为 sql.Date

//员工表

@Entity
@Table(name = "staff")
public class Staff {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String gender;
    private String phone;
    private String position;

    @Column(name = "hire_date")
    private Date hireDate;   // 现在类型是 java.sql.Date

    private BigDecimal salary;
    private String status;
    private String password;

    // 无参构造
    public Staff() {}

    // 带参构造（可选）
    public Staff(String name, String gender, String phone, String position,
                 Date hireDate, BigDecimal salary, String status) {
        this.name = name;
        this.gender = gender;
        this.phone = phone;
        this.position = position;
        this.hireDate = hireDate;
        this.salary = salary;
        this.status = status;
    }

    // Getter / Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public Date getHireDate() { return hireDate; }
    public void setHireDate(Date hireDate) { this.hireDate = hireDate; }

    public BigDecimal getSalary() { return salary; }
    public void setSalary(BigDecimal salary) { this.salary = salary; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}