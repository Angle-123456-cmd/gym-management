package com.gym.controller;

import com.gym.repository.MemberRepository;
import com.gym.repository.StaffRepository;
import com.gym.model.Member;
import com.gym.model.Staff;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
public class LoginController {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private StaffRepository staffRepository;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam("role") String role,
                          @RequestParam("username") String username,
                          @RequestParam("password") String password,
                          HttpSession session,
                          Model model) {

        if ("member".equals(role)) {
            // 会员登录：支持姓名/手机号/邮箱三种方式
            Optional<Member> memberOpt = memberRepository.findByUsernameOrPhoneOrEmailAndPassword(username, password);
            if (memberOpt.isPresent()) {
                Member member = memberOpt.get();
                session.setAttribute("userId", member.getId());
                session.setAttribute("userName", member.getName());
                session.setAttribute("role", "member");
                return "redirect:/member/dashboard";
            }
        } else if ("admin".equals(role)) {
            // 管理员登录：仅限职位为"经理"的员工
            Optional<Staff> adminOpt = staffRepository.findAdminByNameAndPassword(username, password);
            if (adminOpt.isPresent()) {
                Staff admin = adminOpt.get();
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("adminName", admin.getName());
                session.setAttribute("role", "admin");
                return "redirect:/index";
            }
        }

        model.addAttribute("error", "账号或密码错误，请重试");
        return "login";
    }
}