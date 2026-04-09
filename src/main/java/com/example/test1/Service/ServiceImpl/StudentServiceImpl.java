package com.example.test1.Service.ServiceImpl;

import com.example.test1.Service.StudentService;
import com.example.test1.entity.Student;
import com.example.test1.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;


    @Override
    public  Student getById(int id) {
        Student student = new Student();
        student = studentMapper.getStudentById(id);
        return student;
    }

    @Override
    public boolean upData(Student student) {
        return studentMapper.updateStudent(student) > 0;
    }

    @Override
    public boolean insert(Student student) {
        return studentMapper.insertStudent(student) > 0;
    }

    @Override
    public boolean delete(int id) {
        return studentMapper.deleteStudent(id) > 0;
    }

    @Override
    public List<Student> getAll() {
        List<Student> students = new ArrayList<>();
        students = studentMapper.getAllStudents();
        return students;
    }

    @Override
    public boolean deleteAll() {
        return studentMapper.deleteAllStudents() > 0;
    }


}
