package com.gym.repository;

import com.gym.model.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {

    // 按用户名/手机/邮箱 + 密码查询（用于登录）
    @Query("SELECT m FROM Member m WHERE (m.name = :login OR m.phone = :login OR m.email = :login) AND m.password = :password")
    Optional<Member> findByUsernameOrPhoneOrEmailAndPassword(@Param("login") String login, @Param("password") String password);

    // 更新会员卡类型和到期日期
    @Modifying
    @Transactional
    @Query("UPDATE Member m SET m.membershipType = :type, m.expiryDate = :expiryDate WHERE m.id = :memberId")
    int updateCard(@Param("memberId") int memberId, @Param("type") String membershipType, @Param("expiryDate") Date expiryDate);

    // 检查手机号是否已存在
    boolean existsByPhone(String phone);
}