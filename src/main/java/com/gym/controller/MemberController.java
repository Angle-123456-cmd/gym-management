package com.gym.controller;

import com.gym.model.*;
import com.gym.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.Optional;

/**
 * 会员控制器
 * 统一处理所有与会员相关的请求，包括管理员后台的会员管理和会员中心的自助服务
 * 映射路径：/member/*
 */
@Controller
@RequestMapping("/member")
public class MemberController {

    // ==================== 依赖注入 ====================

    /** 会员数据访问接口 */
    @Autowired
    private MemberRepository memberRepository;

    /** 课程数据访问接口 */
    @Autowired
    private CourseRepository courseRepository;

    /** 预约数据访问接口 */
    @Autowired
    private AppointmentRepository appointmentRepository;

    /** 缴费数据访问接口 */
    @Autowired
    private PaymentRepository paymentRepository;

    // ==================== 私有辅助方法 ====================

    /**
     * 根据会员卡类型获取对应的金额
     * @param type 会员卡类型（月卡/季卡/年卡）
     * @return 对应的金额
     */
    private BigDecimal getAmountByType(String type) {
        switch (type) {
            case "月卡": return new BigDecimal("300");
            case "季卡": return new BigDecimal("900");
            case "年卡": return new BigDecimal("3600");
            default: return BigDecimal.ZERO;
        }
    }

    // ================================================================
    // 一、管理员后台功能（5个方法）
    // ================================================================

    /**
     * 1. 会员列表
     * 功能：查询所有会员信息，展示在列表中
     * 访问路径：GET /member 或 GET /member/
     * @param model Spring MVC 模型对象，用于传递数据到视图
     * @return 会员列表页面（member/list.jsp）
     */
    @GetMapping({"", "/"})
    public String list(Model model) {
        // 查询所有会员
        model.addAttribute("members", memberRepository.findAll());
        return "member/list";
    }

    /**
     * 2. 添加会员表单
     * 功能：返回添加会员的表单页面
     * 访问路径：GET /member/add
     * @return 会员表单页面（member/form.jsp）
     */
    @GetMapping("/add")
    public String addForm() {
        return "member/form";
    }

    /**
     * 3. 编辑会员表单
     * 功能：根据会员ID查询会员信息，回显到编辑表单
     * 访问路径：GET /member/edit
     * @param id 会员ID（从请求参数获取）
     * @param model Spring MVC 模型对象
     * @return 会员表单页面（member/form.jsp）
     */
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int id, Model model) {
        // 根据ID查询会员，若不存在则返回null
        model.addAttribute("member", memberRepository.findById(id).orElse(null));
        return "member/form";
    }

    /**
     * 4. 保存会员（新增或编辑）⭐核心方法
     * 功能：处理会员的新增和编辑操作，包含手机号唯一性校验
     * 访问路径：POST /member/save
     * @param idStr 会员ID（编辑时传入，新增时为空）
     * @param name 会员姓名
     * @param gender 性别
     * @param phone 手机号
     * @param email 邮箱（可选）
     * @param joinDate 加入日期
     * @param expiryDate 到期日期
     * @param membershipType 会员类型
     * @param status 会员状态
     * @param password 密码（编辑时为空表示不修改）
     * @param ra 重定向属性传递对象
     * @return 重定向到会员列表
     */
    @PostMapping("/save")
    public String save(@RequestParam(value = "id", required = false) String idStr,
                       @RequestParam("name") String name,
                       @RequestParam("gender") String gender,
                       @RequestParam("phone") String phone,
                       @RequestParam(value = "email", required = false) String email,
                       @RequestParam(value = "joinDate", required = false) String joinDate,
                       @RequestParam(value = "expiryDate", required = false) String expiryDate,
                       @RequestParam(value = "membershipType", required = false) String membershipType,
                       @RequestParam(value = "status", required = false) String status,
                       @RequestParam(value = "password", required = false) String password,
                       RedirectAttributes ra) {
        try {
            Member member;

            // 判断是新增还是编辑
            if (idStr != null && !idStr.isEmpty()) {
                // ===== 编辑模式 =====
                // 从数据库查出原有数据，避免覆盖未传入的字段
                member = memberRepository.findById(Integer.parseInt(idStr))
                        .orElseThrow(() -> new RuntimeException("会员不存在"));
            } else {
                // ===== 新增模式 =====
                member = new Member();
                // 新增时设置密码（如果前端传了密码就用，否则默认123456）
                member.setPassword(password != null && !password.isEmpty() ? password : "123456");
            }

            // ===== 手机号唯一性校验 =====
            if (idStr == null || idStr.isEmpty()) {
                // 新增：检查手机号是否已被占用
                if (memberRepository.existsByPhone(phone)) {
                    ra.addFlashAttribute("error", "手机号已存在，请使用其他号码！");
                    return "redirect:/member/add";
                }
            } else {
                // 编辑：如果手机号被修改了，且新手机号已被其他会员占用，则不允许
                if (!member.getPhone().equals(phone) && memberRepository.existsByPhone(phone)) {
                    ra.addFlashAttribute("error", "手机号已被其他会员使用！");
                    return "redirect:/member/edit?id=" + idStr;
                }
            }

            // ===== 更新允许修改的字段 =====
            member.setName(name);
            member.setGender(gender);
            member.setPhone(phone);
            member.setEmail(email);

            // 日期字段（非必填，编辑时可能不传）
            if (joinDate != null && !joinDate.isEmpty()) {
                member.setJoinDate(Date.valueOf(joinDate));
            }
            if (expiryDate != null && !expiryDate.isEmpty()) {
                member.setExpiryDate(Date.valueOf(expiryDate));
            }

            // 会员类型和状态
            if (membershipType != null && !membershipType.isEmpty()) {
                member.setMembershipType(membershipType);
            }
            if (status != null && !status.isEmpty()) {
                member.setStatus(status);
            }

            // 密码：只有非空时才更新（编辑时留空则保持原密码不变）
            if (password != null && !password.isEmpty()) {
                member.setPassword(password);
            }

            // 保存到数据库
            memberRepository.save(member);
            return "redirect:/member";

        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "操作失败：" + e.getMessage());
            return "redirect:/member";
        }
    }

    /**
     * 5. 删除会员⭐核心方法
     * 功能：删除指定会员，删除前检查是否有预约或缴费记录
     * 访问路径：GET /member/delete
     * @param id 要删除的会员ID
     * @param ra 重定向属性传递对象
     * @return 重定向到会员列表
     */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id, RedirectAttributes ra) {
        // 1. 检查是否有预约记录
        int appointmentCount = appointmentRepository.countByMemberId(id);
        if (appointmentCount > 0) {
            ra.addFlashAttribute("error", "该会员有预约课程，无法删除！");
            return "redirect:/member";
        }

        // 2. 检查是否有缴费记录
        int paymentCount = paymentRepository.countByMemberId(id);
        if (paymentCount > 0) {
            ra.addFlashAttribute("error", "该会员有缴费记录，无法删除！");
            return "redirect:/member";
        }

        // 3. 两项检查都通过，执行删除
        try {
            memberRepository.deleteById(id);
            ra.addFlashAttribute("success", "删除成功");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "删除失败：" + e.getMessage());
        }
        return "redirect:/member";
    }

    // ================================================================
    // 二、会员中心功能（4个方法）
    // ================================================================

    /**
     * 6. 会员中心首页
     * 功能：显示当前登录会员的首页，包含快捷操作菜单
     * 访问路径：GET /member/dashboard
     * @param session HTTP会话对象，用于获取当前登录用户信息
     * @param model Spring MVC 模型对象
     * @return 会员中心首页（member/dashboard.jsp）
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // 从Session获取当前登录会员ID
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";  // 未登录则跳转登录页

        // 查询会员信息并传递到页面
        model.addAttribute("member", memberRepository.findById(userId).orElse(null));
        return "member/dashboard";
    }

    /**
     * 7. 查看已预约课程
     * 功能：显示当前会员已预约的所有课程列表
     * 访问路径：GET /member/courses
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 已预约课程列表页面（member/courses.jsp）
     */
    @GetMapping("/courses")
    public String courses(HttpSession session, Model model) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        // 查询该会员已预约的课程（按预约ID倒序）
        List<Course> bookedCourses = appointmentRepository.findBookedCoursesByMemberId(memberId);
        model.addAttribute("courses", bookedCourses);

        // 传递已预约的课程ID集合（供JSP中取消按钮使用）
        List<Integer> bookedIds = appointmentRepository.findCourseIdsByMemberId(memberId);
        model.addAttribute("bookedCourseIds", bookedIds);

        return "member/courses";
    }

    /**
     * 8. 预约课程页面
     * 功能：显示所有可预约的课程列表供会员选择
     * 访问路径：GET /member/appointment
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 预约课程页面（member/appointment.jsp）
     */
    @GetMapping("/appointment")
    public String appointmentPage(HttpSession session, Model model) {
        // 获取所有课程（按ID倒序）
        model.addAttribute("courses", courseRepository.findAllByOrderByIdDesc());
        return "member/appointment";
    }

    /**
     * 9. 提交预约⭐核心方法
     * 功能：处理会员预约课程请求，包含课程存在性、重复预约、容量三重检查
     * 访问路径：POST /member/appointment
     * @param courseId 课程ID
     * @param session HTTP会话对象
     * @param ra 重定向属性传递对象
     * @return 重定向到预约页面
     */
    @PostMapping("/appointment")
    public String doAppointment(@RequestParam("courseId") int courseId,
                                HttpSession session,
                                RedirectAttributes ra) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        // 1. 检查课程是否存在
        Optional<Course> courseOpt = courseRepository.findById(courseId);
        if (!courseOpt.isPresent()) {
            ra.addFlashAttribute("error", "课程不存在");
            return "redirect:/member/appointment";
        }
        Course course = courseOpt.get();

        // 2. 检查该会员是否已预约过该课程（重复预约校验）
        if (appointmentRepository.isBooked(memberId, courseId)) {
            ra.addFlashAttribute("error", "您已预约过该课程");
            return "redirect:/member/appointment";
        }

        // 3. 检查课程容量是否已满
        if (course.getEnrolledCount() >= course.getCapacity()) {
            ra.addFlashAttribute("error", "课程已满，无法预约");
            return "redirect:/member/appointment";
        }

        // 4. 创建预约记录并保存
        Appointment app = new Appointment();
        app.setMemberId(memberId);
        app.setCourseId(courseId);
        app.setStatus("已预约");
        appointmentRepository.save(app);

        // 5. 课程已预约人数 +1
        courseRepository.incrementEnrolledCount(courseId);

        ra.addFlashAttribute("success", "预约成功");
        return "redirect:/member/appointment";
    }

    /**
     * 10. 取消预约⭐核心方法
     * 功能：删除预约记录，同时将课程已预约人数 -1
     * 访问路径：GET /member/cancelAppointment
     * @param courseId 课程ID
     * @param session HTTP会话对象
     * @param ra 重定向属性传递对象
     * @return 重定向到已预约课程列表
     */
    @GetMapping("/cancelAppointment")
    public String cancelAppointment(@RequestParam("courseId") int courseId,
                                    HttpSession session,
                                    RedirectAttributes ra) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        // 1. 删除预约记录
        int deleted = appointmentRepository.deleteByMemberAndCourse(memberId, courseId);
        if (deleted > 0) {
            // 2. 课程已预约人数 -1
            courseRepository.decrementEnrolledCount(courseId);
            ra.addFlashAttribute("cancelSuccess", "已取消预约");
        } else {
            ra.addFlashAttribute("cancelError", "取消失败");
        }
        return "redirect:/member/courses";
    }

    // ================================================================
    // 三、支付流程功能（5个方法）
    // ================================================================

    /**
     * 11. 办理/升级会员卡页面
     * 功能：显示当前会员信息，供选择新的会员类型和到期日期
     * 访问路径：GET /member/card
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 办卡页面（member/card.jsp）
     */
    @GetMapping("/card")
    public String cardPage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        model.addAttribute("member", memberRepository.findById(userId).orElse(null));
        return "member/card";
    }

    /**
     * 12. 显示支付页面（GET方式）
     * 功能：接收URL参数，计算金额，跳转到支付方式选择页面
     * 访问路径：GET /member/pay
     * @param membershipType 选择的会员类型
     * @param expiryDateStr 选择的到期日期
     * @param model Spring MVC 模型对象
     * @return 支付页面（member/pay.jsp）
     */
    @GetMapping("/pay")
    public String payPage(@RequestParam("membershipType") String membershipType,
                          @RequestParam("expiryDate") String expiryDateStr,
                          Model model) {
        BigDecimal amount = getAmountByType(membershipType);
        model.addAttribute("amount", amount);
        model.addAttribute("membershipType", membershipType);
        model.addAttribute("expiryDate", expiryDateStr);
        return "member/pay";
    }

    /**
     * 13. 显示支付页面（POST方式）
     * 功能：接收表单提交，计算金额，跳转到支付方式选择页面
     * 访问路径：POST /member/pay
     * @param membershipType 选择的会员类型
     * @param expiryDateStr 选择的到期日期
     * @param model Spring MVC 模型对象
     * @return 支付页面（member/pay.jsp）
     */
    @PostMapping("/pay")
    public String payPost(@RequestParam("membershipType") String membershipType,
                          @RequestParam("expiryDate") String expiryDateStr,
                          Model model) {
        BigDecimal amount = getAmountByType(membershipType);
        model.addAttribute("amount", amount);
        model.addAttribute("membershipType", membershipType);
        model.addAttribute("expiryDate", expiryDateStr);
        return "member/pay";
    }

    /**
     * 14. 显示支付二维码
     * 功能：根据选择的支付方式显示对应的二维码图片
     * 访问路径：GET /member/showQR
     * @param method 支付方式（微信/支付宝）
     * @param membershipType 会员类型
     * @param expiryDate 到期日期
     * @param model Spring MVC 模型对象
     * @return 二维码展示页面（member/qr.jsp）
     */
    @GetMapping("/showQR")
    public String showQR(@RequestParam("method") String method,
                         @RequestParam("membershipType") String membershipType,
                         @RequestParam("expiryDate") String expiryDate,
                         Model model) {
        model.addAttribute("method", method);
        model.addAttribute("membershipType", membershipType);
        model.addAttribute("expiryDate", expiryDate);
        return "member/qr";
    }

    /**
     * 15. 确认支付⭐核心方法
     * 功能：确认支付，执行会员卡升级/续费，自动生成缴费记录
     * 访问路径：POST /member/confirmPay
     * @param membershipType 选择的会员类型
     * @param expiryDateStr 选择的到期日期
     * @param method 支付方式（微信/支付宝）
     * @param session HTTP会话对象
     * @param ra 重定向属性传递对象
     * @return 重定向到办卡页面
     */
    @PostMapping("/confirmPay")
    public String confirmPay(@RequestParam("membershipType") String membershipType,
                             @RequestParam("expiryDate") String expiryDateStr,
                             @RequestParam("method") String method,
                             HttpSession session,
                             RedirectAttributes ra) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        Date expiryDate = Date.valueOf(expiryDateStr);

        // 1. 查询当前会员信息
        Optional<Member> memberOpt = memberRepository.findById(memberId);
        if (!memberOpt.isPresent()) {
            ra.addFlashAttribute("error", "会员不存在");
            return "redirect:/member/card";
        }
        Member member = memberOpt.get();
        String oldType = member.getMembershipType();

        // 2. 更新会员卡类型和到期日期
        int updated = memberRepository.updateCard(memberId, membershipType, expiryDate);

        if (updated > 0) {
            // 3. 计算金额
            BigDecimal amount = getAmountByType(membershipType);

            // 4. 自动生成缴费记录
            Payment payment = new Payment();
            payment.setMemberId(memberId);
            payment.setMemberName(member.getName());
            payment.setType("会员费");
            payment.setAmount(amount);
            payment.setPaymentDate(new Date(System.currentTimeMillis()));
            payment.setMethod(method);      // 记录支付方式（微信/支付宝）
            payment.setStatus("已支付");
            String action = oldType.equals(membershipType) ? "续费" : "升级";
            payment.setRemark("通过会员中心" + action + "操作，新类型：" + membershipType + "，支付方式：" + method);
            paymentRepository.save(payment);

            ra.addFlashAttribute("success", "支付成功，会员卡已升级/续费！");
        } else {
            ra.addFlashAttribute("error", "操作失败，请重试");
        }
        return "redirect:/member/card";
    }

    /**
     * 16. 旧版办卡（保留兼容）
     * 功能：不经过支付流程，直接升级/续费会员卡
     * 访问路径：POST /member/card
     * @param membershipType 会员类型
     * @param expiryDateStr 到期日期
     * @param session HTTP会话对象
     * @param ra 重定向属性传递对象
     * @return 重定向到办卡页面
     */
    @PostMapping("/card")
    public String updateCard(@RequestParam("membershipType") String membershipType,
                             @RequestParam("expiryDate") String expiryDateStr,
                             HttpSession session,
                             RedirectAttributes ra) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        Date expiryDate = Date.valueOf(expiryDateStr);
        Optional<Member> memberOpt = memberRepository.findById(memberId);
        if (!memberOpt.isPresent()) {
            ra.addFlashAttribute("error", "会员不存在");
            return "redirect:/member/card";
        }
        Member member = memberOpt.get();
        String oldType = member.getMembershipType();

        int updated = memberRepository.updateCard(memberId, membershipType, expiryDate);
        if (updated > 0) {
            BigDecimal amount = getAmountByType(membershipType);
            Payment payment = new Payment();
            payment.setMemberId(memberId);
            payment.setMemberName(member.getName());
            payment.setType("会员费");
            payment.setAmount(amount);
            payment.setPaymentDate(new Date(System.currentTimeMillis()));
            payment.setMethod("会员升级/续费");
            payment.setStatus("已支付");
            String action = oldType.equals(membershipType) ? "续费" : "升级";
            payment.setRemark("通过会员中心" + action + "操作，新类型：" + membershipType);
            paymentRepository.save(payment);
            ra.addFlashAttribute("success", "操作成功");
        } else {
            ra.addFlashAttribute("error", "操作失败");
        }
        return "redirect:/member/card";
    }

    // ================================================================
    // 四、个人中心功能（3个方法）
    // ================================================================

    /**
     * 17. 查看个人资料
     * 功能：显示当前会员的个人资料
     * 访问路径：GET /member/profile
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 个人资料页面（member/profile.jsp）
     */
    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        model.addAttribute("member", memberRepository.findById(userId).orElse(null));
        return "member/profile";
    }

    /**
     * 18. 更新个人资料
     * 功能：修改会员的个人信息（姓名、性别、手机号、邮箱）
     * 访问路径：POST /member/profile
     * @param name 姓名
     * @param gender 性别
     * @param phone 手机号
     * @param email 邮箱（可选）
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 个人资料页面（member/profile.jsp）
     */
    @PostMapping("/profile")
    public String updateProfile(@RequestParam("name") String name,
                                @RequestParam("gender") String gender,
                                @RequestParam("phone") String phone,
                                @RequestParam(value = "email", required = false) String email,
                                HttpSession session,
                                Model model) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        Optional<Member> memberOpt = memberRepository.findById(memberId);
        if (memberOpt.isPresent()) {
            Member member = memberOpt.get();

            // 检查手机号是否被其他会员占用
            if (!member.getPhone().equals(phone) && memberRepository.existsByPhone(phone)) {
                model.addAttribute("error", "手机号已被其他会员使用！");
                model.addAttribute("member", member);
                return "member/profile";
            }

            // 更新字段（注意：不修改密码）
            member.setName(name);
            member.setGender(gender);
            member.setPhone(phone);
            member.setEmail(email);
            memberRepository.save(member);

            model.addAttribute("message", "资料更新成功");
            model.addAttribute("member", member);
        } else {
            model.addAttribute("error", "更新失败");
        }
        return "member/profile";
    }

    /**
     * 19. 查看缴费记录
     * 功能：显示当前会员的所有缴费记录（按支付日期倒序）
     * 访问路径：GET /member/payments
     * @param session HTTP会话对象
     * @param model Spring MVC 模型对象
     * @return 缴费记录页面（member/payments.jsp）
     */
    @GetMapping("/payments")
    public String payments(HttpSession session, Model model) {
        Integer memberId = (Integer) session.getAttribute("userId");
        if (memberId == null) return "redirect:/login";

        // 按支付日期倒序查询该会员的所有缴费记录
        model.addAttribute("payments", paymentRepository.findByMemberIdOrderByPaymentDateDesc(memberId));
        return "member/payments";
    }
}