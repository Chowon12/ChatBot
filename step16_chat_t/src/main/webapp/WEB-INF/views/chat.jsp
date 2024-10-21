<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Chat</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body>

<div class="container">
    <div class="col-6">
        <label><b>Chat</b></label>
    </div>
    <div>
        <div id="msgArea" class="col"></div>
        <div class="col-6">
            <div class="input-group mb-3">
                <input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" id="button-send" onclick="send()">전송</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>	
	// 로그인한 클라이언트 정보
	const username = "${userName}";
	
	// 메세지 출력을 위한 DOM 객체
	let msgArea = document.getElementById("msgArea");
	
	// WebSocket 객체 생성 및 서버와의 통신을 위한 설정  ws : 웹소켓 프로토콜.
    const websocket = new WebSocket("ws://localhost:8080/ws/chat");
	// 이제 연결이 끊기지 않게 하니 아래 정보들을 계속 전달해줌. 
    websocket.onmessage = onMessage;
    websocket.onopen = onOpen;
    websocket.onclose = onClose;

    // 메세지 송신
    function send(){

        let msg = document.getElementById("msg");

        console.log(username + ":" + msg.value);
        
        // 연결된 서버에 메세지를 전달하는 메소드
        websocket.send(username + ":" + msg.value);
        msg.value = '';
    }
    
    // 채팅 OUT
    function onClose(evt) {
        var str = username + ": 님이 방을 나가셨습니다.";
        websocket.send(str);
    }
    
    // 채팅 IN
    function onOpen(evt) {
        var str = username + ": 님이 입장하셨습니다.";
        websocket.send(str);
    }
    
    
    let content = '';
    
    // 메세지 수신
    function onMessage(msg) {
    	//json객체를 주고받는다고 생각하면 됨. pom.xml에도 json으로 객체를 매핑할 수 있는 jackson을 넣어놨기 때문에 가능.
        var data = msg.data;
        var sessionId = null;
        
        // 데이터를 전송한 클라이언트
        var message = null;
        var arr = data.split(":");

        for(var i=0; i<arr.length; i++){
            console.log('arr[' + i + ']: ' + arr[i]);
        }

        var cur_session = username;

        // 현재 세션에 로그인한 클라이언트 세션 정보
        console.log("cur_session : " + cur_session);
        sessionId = arr[0];
        message = arr[1];

        console.log("sessionID : " + sessionId);
        console.log("cur_session : " + cur_session);


        
        // 로그인 한 클라이언트와 타 클라이언트 분류 및 분류된 메세지 출력
        if(sessionId == cur_session){
            var str = "<div class='col-6'>";
            str += "<div class='alert alert-secondary'>";
            str += "<b>" + sessionId + " : " + message + "</b>";
            str += "</div></div>";
            content += str;
            msgArea.innerHTML = content;
        }
        else{
            var str = "<div class='col-6'>";
            str += "<div class='alert alert-warning'>";
            str += "<b>" + sessionId + " : " + message + "</b>";
            str += "</div></div>";
            content += str;
            msgArea.innerHTML = content;
        }
    }
</script>
</body>
</html>