package com.spring.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.chat.repository.ChatRoomRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "/chat")
@RequiredArgsConstructor
@Controller
public class RoomController {

    private final ChatRoomRepository repository;

    // 채팅방 목록 조회
    @GetMapping(value = "/rooms")
    public String getChatRooms(Model model){

        log.info("RoomController : getChatRooms()");
        model.addAttribute("rooms", repository.findAllRooms());
     
        return "chat/rooms";
    }

    // 채팅방 개설
    @PostMapping(value = "/room")
    public String createChatRoom(@RequestParam String name, Model model){

        log.info("RoomController : createChatRoom()");
        model.addAttribute("roomName", repository.createChatRoomDTO(name));
        
        return "redirect:/chat/rooms";
    }

    // 채팅방 조회
    @GetMapping("/room")
    public void getChatRoom(String roomId, Model model){
    	
        log.info("RoomController : getChatRoom(), roomId : " + roomId);
        
        model.addAttribute("room", repository.findRoomById(roomId));
    }
}