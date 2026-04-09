package com.example.test1.Service;

import com.example.test1.entity.Student;

import java.util.List;

public interface StudentService {
   public Student getById(int id);

   boolean upData(Student student);

   boolean insert(Student student);

   boolean delete(int id);

   List<Student> getAll();

   boolean deleteAll();
}

