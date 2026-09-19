package com.gym.model;

import javax.persistence.*;
import java.sql.Date;

@Entity//映射数据表
@Table(name = "equipment")//数据库表面
public class Equipment {
    @Id//数据库主键
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String type;
    private String location;

    @Column(name = "purchase_date")//数据库字段
    private Date purchaseDate;

    private String status;

    @Column(name = "last_maintenance")
    private String lastMaintenance;

    // 无参构造（JPA 需要）
    public Equipment() {}

    // 带参构造（可选）
    public Equipment(String name, String type, String location, Date purchaseDate,
                     String status, String lastMaintenance) {
        this.name = name;
        this.type = type;
        this.location = location;
        this.purchaseDate = purchaseDate;
        this.status = status;
        this.lastMaintenance = lastMaintenance;
    }

    // Getter / Setter（保持不变，略）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Date getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Date purchaseDate) { this.purchaseDate = purchaseDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getLastMaintenance() { return lastMaintenance; }
    public void setLastMaintenance(String lastMaintenance) { this.lastMaintenance = lastMaintenance; }
}