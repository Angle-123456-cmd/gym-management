package com.gym.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;

//缴费表

@Entity
@Table(name = "payment")
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "member_id")
    private Integer memberId;

    @Column(name = "member_name")
    private String memberName;

    private String type;
    private BigDecimal amount;

    @Column(name = "payment_date")
    private Date paymentDate;

    private String method;
    private String status;
    private String remark;

    public Payment() {}

    public Payment(String memberName, String type, BigDecimal amount,
                   Date paymentDate, String method, String status, String remark) {
        this.memberName = memberName;
        this.type = type;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.method = method;
        this.status = status;
        this.remark = remark;
    }

    // Getters and Setters（保持不变）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getMemberId() { return memberId; }
    public void setMemberId(Integer memberId) { this.memberId = memberId; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
}