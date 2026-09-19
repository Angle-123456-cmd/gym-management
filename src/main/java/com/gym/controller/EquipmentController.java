package com.gym.controller;

import com.gym.model.Equipment;
import com.gym.repository.EquipmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/equipment")
public class EquipmentController {

    @Autowired
    private EquipmentRepository equipmentRepository;

    // 器材列表
    @GetMapping({"", "/"})
    public String list(Model model) {
        List<Equipment> equipments = equipmentRepository.findAllByOrderByIdDesc();
        model.addAttribute("equipments", equipments);
        return "equipment/list";
    }

    // 添加器材表单
    @GetMapping("/add")
    public String addForm() {
        return "equipment/form";
    }

    // 编辑器材表单
    @GetMapping("/edit")
    public String editForm(@RequestParam("id") int id, Model model) {
        Equipment equipment = equipmentRepository.findById(id).orElse(null);
        model.addAttribute("equipment", equipment);
        return "equipment/form";
    }

    // 删除器材
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        equipmentRepository.deleteById(id);
        return "redirect:/equipment";
    }

    // 保存器材（新增或编辑）
    @PostMapping("/save")
    public String save(Equipment equipment, @RequestParam(value = "id", required = false) String idStr,
                       @RequestParam("purchaseDate") String purchaseDateStr) {
        if (idStr != null && !idStr.isEmpty()) {
            equipment.setId(Integer.parseInt(idStr));
        }
        equipment.setPurchaseDate(Date.valueOf(purchaseDateStr));
        equipmentRepository.save(equipment);
        return "redirect:/equipment";
    }
}