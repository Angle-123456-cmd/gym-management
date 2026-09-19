package com.gym.controller;

import com.gym.model.Payment;
import com.gym.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.sql.Date;

//管理员收费

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentRepository paymentRepository;

    // 收费列表（管理员后台）
    @GetMapping({"", "/"})
    public String list(Model model) {
        model.addAttribute("payments", paymentRepository.findAllByOrderByIdDesc());
        return "payment/list";
    }

    // 添加收费表单
    @GetMapping("/add")
    public String addForm() {
        return "payment/form";
    }

    // 编辑收费表单
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int id, Model model) {
        Payment payment = paymentRepository.findById(id).orElse(null);
        model.addAttribute("payment", payment);
        return "payment/form";
    }

    // 删除收费记录
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        paymentRepository.deleteById(id);
        return "redirect:/payment";
    }

    // 保存收费记录（新增或编辑）
    @PostMapping("/save")
    public String save(Payment payment,
                       @RequestParam(value = "id", required = false) String idStr,
                       @RequestParam("paymentDate") String paymentDateStr,
                       RedirectAttributes ra) {
        try {
            if (idStr != null && !idStr.isEmpty()) {
                payment.setId(Integer.parseInt(idStr));
            }
            payment.setPaymentDate(Date.valueOf(paymentDateStr));
            paymentRepository.save(payment);
        } catch (Exception e) {
            e.printStackTrace();
            ra.addAttribute("error", "操作失败：" + e.getMessage());
            return "redirect:/payment";
        }
        return "redirect:/payment";
    }
}