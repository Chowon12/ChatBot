package com.spring.chat.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ChatHandler extends TextWebSocketHandler  {
	// WebSocketSession : WebSocket 통신으로 연결 후 상태를 유지하는 객체. 
	// 데이터가 전달이 되면 챗핸들러가 자동으로 세션객체를 만들어줌.
    private static List<WebSocketSession> webSocketSessionList = new ArrayList<>();

    //send가 보낸 메세지를 핸들러가 인식함. TextMessage객체를 통해서. getPayload는 메세지를 받아오는 메소드.
    @Override
    protected void handleTextMessage(WebSocketSession webSocketSession, TextMessage message) throws Exception {
        String payload = message.getPayload();
        
        log.info("payload : " + payload);

        //이 메세지를 다시 소켓세션에 sendMessage해서 보내줌.보내주면 자동으로 jsp에서 onMessage가 실행됨. 
        for(WebSocketSession wsSession: webSocketSessionList) {
        	wsSession.sendMessage(message);
        }
    }

    // Client가 서버에 연결 후 실행되는 메소드 
    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {

    	webSocketSessionList.add(webSocketSession);
        log.info(webSocketSession + " 클라이언트 접속");
    }

    // Client가 서버와 연결 종료후 실행되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus status) throws Exception {

        log.info(webSocketSession + " 클라이언트 접속 해제");
        webSocketSessionList.remove(webSocketSession);
    }
}