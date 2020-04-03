package com.example.server;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
    @RequestMapping(value = "/**/{path:[^\\.]*}", method = {RequestMethod.GET})
    public String fallback() {
        return "/index.html";
    }
}