package com.example.test1.mapper;

import com.example.test1.entity.Student;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StudentMapper {

    public Student getStudentById(int id);
    public List<Student> getAllStudents();
    public int insertStudent(Student student);
    public int updateStudent(Student student);
    public int deleteStudent(int id);
    public int deleteAllStudents();
}
