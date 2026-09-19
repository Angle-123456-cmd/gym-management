package com.gym.controller;

import com.gym.model.Member;
import com.gym.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Date;


//新会员收费

@Controller
public class RegisterController {

    @Autowired
    private MemberRepository memberRepository;

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(@RequestParam("name") String name,
                             @RequestParam("gender") String gender,
                             @RequestParam("phone") String phone,
                             @RequestParam(value = "email", required = false) String email,
                             @RequestParam("password") String password,
                             @RequestParam("joinDate") String joinDateStr,
                             Model model) {
        try {
            // 1. 检查手机号是否已被注册
            if (memberRepository.existsByPhone(phone)) {
                model.addAttribute("error", "手机号已被注册，请使用其他号码！");
                return "register";
            }

            Date joinDate = Date.valueOf(joinDateStr);
            Date expiryDate = new Date(joinDate.getTime() + 30L * 24 * 60 * 60 * 1000); // 30天后

            // 2. 创建会员对象
            Member member = new Member();
            member.setName(name);
            member.setGender(gender);
            member.setPhone(phone);
            member.setEmail(email);
            member.setJoinDate(joinDate);
            member.setExpiryDate(expiryDate);
            member.setMembershipType("月卡");
            member.setStatus("正常");
            member.setPassword(password);

            // 3. 保存到数据库
            memberRepository.save(member);
            model.addAttribute("message", "注册成功，请登录");
            return "login";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "注册失败，请重试");
            return "register";
        }
    }
}