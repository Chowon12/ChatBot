package com.spring.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	
	// 로그인을 가정(PathVariable로 userName 전달)
    @GetMapping("/chat/{userName}")
    public String moveChat(@PathVariable String userName, Model model){

        log.info("ChatController, moveChat()");
        model.addAttribute("userName", userName);
        
        return "chat";
    }
}
