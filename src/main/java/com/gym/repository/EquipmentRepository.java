package com.gym.repository;

import com.gym.model.Equipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EquipmentRepository extends JpaRepository<Equipment, Integer> {
    // 按 id 降序排列
    List<Equipment> findAllByOrderByIdDesc();
}