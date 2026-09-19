package com.gym.repository;

import com.gym.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {

    // 增加课程已预约人数
    @Modifying
    @Transactional
    @Query("UPDATE Course c SET c.enrolledCount = c.enrolledCount + 1 WHERE c.id = :courseId")
    int incrementEnrolledCount(@Param("courseId") int courseId);

    // 减少课程已预约人数（不低于0）
    @Modifying
    @Transactional
    @Query("UPDATE Course c SET c.enrolledCount = c.enrolledCount - 1 WHERE c.id = :courseId AND c.enrolledCount > 0")
    int decrementEnrolledCount(@Param("courseId") int courseId);

    // 按 id 降序排列
    List<Course> findAllByOrderByIdDesc();
}