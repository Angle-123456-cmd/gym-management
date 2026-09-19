package com.gym.model;

import javax.persistence.*;

@Entity
@Table(name = "appointment")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "member_id")
    private Integer memberId;

    @Column(name = "course_id")
    private Integer courseId;

    private String status;

    public Appointment() {}

    public Appointment(Integer id, Integer memberId, Integer courseId, String status) {
        this.id = id;
        this.memberId = memberId;
        this.courseId = courseId;
        this.status = status;
    }

    // getters / setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getMemberId() { return memberId; }
    public void setMemberId(Integer memberId) { this.memberId = memberId; }

    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}