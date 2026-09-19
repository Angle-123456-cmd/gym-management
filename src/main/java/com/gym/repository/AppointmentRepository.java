package com.gym.repository;

import com.gym.model.Appointment;
import com.gym.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository//标识为数据访问组件
public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {

    // 查询某会员已预约的课程ID列表
    @Query("SELECT a.courseId FROM Appointment a WHERE a.memberId = :memberId")//定义查询条件
    List<Integer> findCourseIdsByMemberId(@Param("memberId") int memberId);

    // 查询某会员已预约的课程详细信息（按预约ID倒序）
    @Query("SELECT c FROM Course c JOIN Appointment a ON a.courseId = c.id WHERE a.memberId = :memberId ORDER BY a.id DESC")
    List<Course> findBookedCoursesByMemberId(@Param("memberId") int memberId);

    // 检查是否已预约
    @Query("SELECT COUNT(a) > 0 FROM Appointment a WHERE a.memberId = :memberId AND a.courseId = :courseId")
    boolean isBooked(@Param("memberId") int memberId, @Param("courseId") int courseId);

    // 删除预约（按会员和课程）
    @Modifying//删除
    @Transactional//事务管理回滚
    @Query("DELETE FROM Appointment a WHERE a.memberId = :memberId AND a.courseId = :courseId")
    int deleteByMemberAndCourse(@Param("memberId") int memberId, @Param("courseId") int courseId);

    // ---- 新增：统计某会员的预约记录数 ----
    int countByMemberId(int memberId);

    int countByCourseId(int courseId);
}