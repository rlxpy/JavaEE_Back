package com.example.test1.exception;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // 专门拦截 @Valid 校验失败抛出的异常
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, Object> handleValidExceptions(MethodArgumentNotValidException ex) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 400);// 告诉前端这是请求参数错误

        // 获取校验失败的详细信息
        BindingResult bindingResult = ex.getBindingResult();
        FieldError fieldError = bindingResult.getFieldError();
        if(fieldError != null) {
            result.put("msg", fieldError.getDefaultMessage());
        }else {
            result.put("msg", "参数校验失败");
        }

        return result;
    }
}
