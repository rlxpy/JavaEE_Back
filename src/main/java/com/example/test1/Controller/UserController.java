package com.example.test1.Controller;

import com.example.test1.Service.UserService;
import com.example.test1.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    public UserService userService;

    @GetMapping("/get/{id}")
    public User getUser(@PathVariable int id) {
        User user = userService.getUserById(id);
        if(user == null) {
            return null;
        }
        return user;
    }

    @GetMapping("/getAll")
    public List<User> getAll() {
        List<User> students = new ArrayList<User>();
        students = userService.getAllUsers();
        return students;
    }

    @PutMapping("/update")
    public String postUser(@RequestBody User student) {
        if(student.getId() == null){
            return "没有学生id";
        }
        boolean success = userService.updateUserById(student);
        return success ? "yes" : "no";
    }

    @PostMapping("/insert")
    public String insertUser(@RequestBody User student) {
        boolean success = userService.insertUser(student);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        boolean success = userService.deleteUserById(id);
        return success ? "yes" : "no";
    }

    @DeleteMapping("/deleteAll")
    public String deleteAll() {
        boolean success = userService.deleteAllUsers();
        return success ? "yes" : "no";
    }
}
