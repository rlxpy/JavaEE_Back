package com.example.test1.Controller;

import com.example.test1.Service.ServiceImpl.StudentServiceImpl;
import com.example.test1.Service.StudentService;
import com.example.test1.entity.Student;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/stu")
public class StudentController {

    @Autowired
    public StudentService studentService;

    @GetMapping("/get{id}")
    public Student regetStudent(@PathVariable int id) {
         Student student = studentService.getById(id);
         if (student == null) {
             return null;
         }
         return student;
    }

    @GetMapping("/getAll")
    public List<Student> getAll() {
        List<Student> students = new ArrayList<Student>();
        students = studentService.getAll();
        return students;
    }

    @PutMapping("/update")
    public String postStudent(@RequestBody Student student) {
        if(student.getId() == null){
            return "没有学生id";
        }
        boolean success = studentService.upData(student);
        return success ? "yes" : "no";
    }

    @PostMapping("/insert")
    public String insertStudent(@RequestBody Student student) {
        boolean success = studentService.insert(student);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/delete{id}")
    public String deleteStudent(@PathVariable int id) {
        boolean success = studentService.delete(id);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/deleteAll")
    public String deleteAll() {
        boolean success = studentService.deleteAll();
        return success ? "yes" : "no";
    }


}
