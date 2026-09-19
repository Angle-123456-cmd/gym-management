package com.gym.model;

import javax.persistence.*;

@Entity
@Table(name = "course")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String instructor;
    private String type;
    private Integer capacity;

    @Column(name = "enrolled_count")
    private Integer enrolledCount;

    private String schedule;
    private String location;

    // 无参构造（JPA 需要）
    public Course() {}

    // 带参构造（可选）
    public Course(String name, String instructor, String type, Integer capacity,
                  Integer enrolledCount, String schedule, String location) {
        this.name = name;
        this.instructor = instructor;
        this.type = type;
        this.capacity = capacity;
        this.enrolledCount = enrolledCount;
        this.schedule = schedule;
        this.location = location;
    }

    // Getter / Setter（保持不变，略）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public Integer getEnrolledCount() { return enrolledCount; }
    public void setEnrolledCount(Integer enrolledCount) { this.enrolledCount = enrolledCount; }

    public String getSchedule() { return schedule; }
    public void setSchedule(String schedule) { this.schedule = schedule; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}