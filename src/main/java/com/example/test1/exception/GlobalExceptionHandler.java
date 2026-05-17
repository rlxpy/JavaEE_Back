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

    // ⭐️ 2. 新增：拦截所有业务逻辑中抛出的 RuntimeException
    // 这样你在 Service 里写的 throw new RuntimeException("🚫 账号已封禁") 就会被这里接住！
    @ExceptionHandler(RuntimeException.class)
    public Map<String, Object> handleRuntimeException(RuntimeException e) {
        Map<String, Object> result = new HashMap<>();
        // 打印一句简短的日志，方便调试，不刷屏
        System.out.println("🚩 业务异常拦截: " + e.getMessage());

        result.put("code", 500); // 或者根据你的习惯给 403/500
        result.put("msg", e.getMessage()); // 获取你 throw 时写的文字
        return result;
    }
}
