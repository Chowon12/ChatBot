package com.spring.chat.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessageDTO {
    private String roomId;	// 채팅방 id
    private String writer;	// 수신 클라이언트 
    private String message; // 수신 내용
}