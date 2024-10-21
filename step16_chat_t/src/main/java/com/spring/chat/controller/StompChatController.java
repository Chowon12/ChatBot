package com.spring.chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.spring.chat.dto.ChatBotMessageDTO;
import com.spring.chat.dto.ChatMessageDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class StompChatController {

    private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달

    // /pub/chat/enter
    @MessageMapping(value = "/chat/enter")
    public void enterChatRoom(ChatMessageDTO message){
    	
    	log.info("StompChatController : enterChatRoom()");
        message.setMessage(message.getWriter() + "님이 채팅방에 참여하였습니다.");
        template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
    }

    @MessageMapping(value = "/chat/message")
    public void messageChatRoom(ChatMessageDTO message){
    	log.info("StompChatController : messageChatRoom()");
        template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
    }
    
    @MessageMapping(value = "/chatbot/enter")
    public void enterChatBot(ChatBotMessageDTO message){
    	log.info("StompChatController : enterChatBot()");
        template.convertAndSend("/sub/chatbot" + message.getMessage(), message);
    }
    
    @MessageMapping(value = "/chatbot/message")
    public void messageChatBot(ChatBotMessageDTO message){
    	log.info("StompChatController : messageChatBot()");
    	
    	String menu = "";
		switch (message.getMessage()) {
		case "1":
			menu = "10) IT Programming 11) DevOps	12) Git Version";
			break;
		case "2":
			menu = "20)배송 조회 21) 주문완료 상세 내역";
			break;
		default:
			menu = "선택한 번호는 없는 메뉴입니다. 다시 입력해주세요.";
			break;
		}
    	
    	message.setMessage(menu);
        template.convertAndSend("/sub/chatbot/message", message);
    }
}