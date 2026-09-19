package com.gym.controller;

import com.gym.model.Staff;
import com.gym.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    private StaffRepository staffRepository;

    @GetMapping({"", "/"})
    public String list(Model model) {
        List<Staff> staffs = staffRepository.findAllByOrderByIdDesc();
        model.addAttribute("staffs", staffs);
        return "staff/list";
    }

    @GetMapping("/add")
    public String addForm() {
        return "staff/form";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int id, Model model) {
        Staff staff = staffRepository.findById(id).orElse(null);
        model.addAttribute("staff", staff);
        return "staff/form";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        staffRepository.deleteById(id);
        return "redirect:/staff";
    }

    @PostMapping("/save")
    public String save(@RequestParam(value = "id", required = false) String idStr,
                       @RequestParam("name") String name,
                       @RequestParam("gender") String gender,
                       @RequestParam("phone") String phone,
                       @RequestParam("position") String position,
                       @RequestParam("hireDate") String hireDateStr,
                       @RequestParam("salary") BigDecimal salary,
                       @RequestParam("status") String status,
                       @RequestParam(value = "password", required = false) String password,
                       RedirectAttributes ra) {
        try {
            // 手机号唯一性校验
            if (idStr == null || idStr.isEmpty()) {
                // 新增
                if (staffRepository.existsByPhone(phone)) {
                    ra.addFlashAttribute("error", "手机号已存在，请使用其他号码！");
                    return "redirect:/staff/add";
                }
            } else {
                // 编辑：如果手机号被修改且新手机号已被其他员工占用，则不允许
                Staff existing = staffRepository.findById(Integer.parseInt(idStr)).orElse(null);
                if (existing != null && !existing.getPhone().equals(phone)
                        && staffRepository.existsByPhone(phone)) {
                    ra.addFlashAttribute("error", "手机号已被其他员工使用！");
                    return "redirect:/staff/edit?id=" + idStr;
                }
            }

            Staff staff;
            if (idStr != null && !idStr.isEmpty()) {
                staff = staffRepository.findById(Integer.parseInt(idStr)).orElse(new Staff());
                staff.setId(Integer.parseInt(idStr));
                if (password != null && !password.isEmpty()) {
                    staff.setPassword(password);
                }
            } else {
                staff = new Staff();
                if ("经理".equals(position)) {
                    if (password == null || password.isEmpty()) {
                        ra.addFlashAttribute("error", "经理职位必须设置密码！");
                        return "redirect:/staff/add";
                    }
                    staff.setPassword(password);
                } else {
                    staff.setPassword(null);
                }
            }
            staff.setName(name);
            staff.setGender(gender);
            staff.setPhone(phone);
            staff.setPosition(position);
            staff.setHireDate(Date.valueOf(hireDateStr));
            staff.setSalary(salary);
            staff.setStatus(status);
            staffRepository.save(staff);
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "操作失败：" + e.getMessage());
            return "redirect:/staff";
        }
        return "redirect:/staff";
    }
}