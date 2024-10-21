package com.spring.chat.dto;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.WebSocketSession;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatRoomDTO {
    private String roomId;	// 채팅방 고유id
    private String name;	// 채팅방명
    // 왜 hashSet사용? 채팅방에 들어갈 때마다 세션정보가 바뀌는게 아님. 중복 방지.
    private Set<WebSocketSession> sessions = new HashSet<>(); //WebSocketSession : WebSocket Connection이 된 Session

    public static ChatRoomDTO create(String name){
        ChatRoomDTO room = new ChatRoomDTO();

        room.roomId = UUID.randomUUID().toString();
        room.name = name;
        return room;
    }
}
