package com.gym.repository;

import com.gym.model.Staff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StaffRepository extends JpaRepository<Staff, Integer> {
    // 按 id 降序排列
    List<Staff> findAllByOrderByIdDesc();

    // 管理员登录验证
    @Query("SELECT s FROM Staff s WHERE s.name = :name AND s.password = :password AND s.position = '经理'")
    Optional<Staff> findAdminByNameAndPassword(@Param("name") String name, @Param("password") String password);

    // 检查手机号是否已存在
    boolean existsByPhone(String phone);
}