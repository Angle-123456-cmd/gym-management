package com.gym.repository;

import com.gym.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    // 按 id 降序排列
    List<Payment> findAllByOrderByIdDesc();

    // 根据会员 ID 查询缴费记录（按支付日期降序）
    @Query("SELECT p FROM Payment p WHERE p.memberId = :memberId ORDER BY p.paymentDate DESC")
    List<Payment> findByMemberIdOrderByPaymentDateDesc(@Param("memberId") int memberId);

    // ---- 新增：统计某会员的缴费记录数 ----
    int countByMemberId(int memberId);
}