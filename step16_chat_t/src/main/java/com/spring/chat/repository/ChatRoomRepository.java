package com.spring.chat.repository;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import javax.annotation.PostConstruct;

import com.spring.chat.dto.ChatRoomDTO;

@Repository
public class ChatRoomRepository {

    private Map<String, ChatRoomDTO> chatRoomDTOMap;

    @PostConstruct
    private void init(){
    	// 고유한 채팅방의 id가 중복이 되지 않도록 hashmap
        chatRoomDTOMap = new LinkedHashMap<>();
    }
    
    // 모든 채팅방 출력
    public List<ChatRoomDTO> findAllRooms(){
    	
        List<ChatRoomDTO> result = new ArrayList<>(chatRoomDTOMap.values());
        
        // List 역순 정렬(최신 생성된 채팅방 생성 순서로 변경)
        Collections.reverse(result);

        return result;
    }

    // 특정 채팅방 출력
    public ChatRoomDTO findRoomById(String id){
        return chatRoomDTOMap.get(id);
    }

    // 채팅방 생성
    public ChatRoomDTO createChatRoomDTO(String name){
        ChatRoomDTO room = ChatRoomDTO.create(name);
        chatRoomDTOMap.put(room.getRoomId(), room);

        return room;
    }
}