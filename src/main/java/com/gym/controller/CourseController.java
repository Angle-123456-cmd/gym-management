package com.gym.controller;

import com.gym.model.Course;
import com.gym.repository.AppointmentRepository;
import com.gym.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/course")//接口拼接
public class CourseController {

    @Autowired//自动注入对象
    private CourseRepository courseRepository;
    @Autowired
    private AppointmentRepository appointmentRepository;

    @GetMapping({"", "/"})//区分请求方式
    public String list(Model model) {
        model.addAttribute("courses", courseRepository.findAllByOrderByIdDesc());
        return "course/list";
    }

    @GetMapping("/add")
    public String addForm() {
        return "course/form";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", courseRepository.findById(id).orElse(null));
        return "course/form";
    }

    @PostMapping("/save")//区分请求方式
    public String save(Course course, @RequestParam(value = "id", required = false) String idStr) {
        if (idStr != null && !idStr.isEmpty()) {
            course.setId(Integer.parseInt(idStr));
        }
        courseRepository.save(course);
        return "redirect:/course";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id, RedirectAttributes ra) {
        // 检查是否有会员预约了该课程
        int appointmentCount = appointmentRepository.countByCourseId(id);
        if (appointmentCount > 0) {
            ra.addFlashAttribute("error", "该课程已被会员预约，无法删除！");
            return "redirect:/course";
        }
        courseRepository.deleteById(id);
        ra.addFlashAttribute("success", "删除成功");
        return "redirect:/course";
    }
}