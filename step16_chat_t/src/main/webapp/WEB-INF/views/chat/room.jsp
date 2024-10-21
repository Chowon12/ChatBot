<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Chat Room</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
	<div class="container">
	    <div class="col-6">
	        <h1>${room.name}</h1>
	    </div>
	    <div>
	        <div id="msgArea" class="col"></div>
	        <div class="col-6">
	            <div class="input-group mb-3">
	                <input type="text" id="msg" class="form-control">
	                <div class="input-group-append">
	                    <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-6"></div>
	</div>
	<%! int num; %>
	<%  num++;   %>
	<% 
		session.setAttribute("userName", "userName " + num);
	%>
	<script>
		var roomName = "${room.name}";
		var roomId = "${room.roomId}";
		var username = "${userName}";
		
		console.log(roomName + ", " + roomId + ", " + username);
		
		let msgArea = document.getElementById("msgArea");
		
		// SockJS : WebSocket을 지원하지 않는 브라우저에서 실행시 런타임에서 필요 코드 생성하는 라이브러리
		var sockJs = new SockJS("/stomp/chat");
		// 1. SockJS를 STOMP로 전달
		var stomp = Stomp.over(sockJs);
		// stomp는 혼자서 실행 안됨. 웹소켓보다 향상된 기능인 sockJs가 필요함. 
		// 2. 연결
		stomp.connect({}, function (){
		
		   //4. subscribe(path, callback) 서버로부터 메세지를 수신
		   let contentt = '';
		   stomp.subscribe("/sub/chat/room/" + roomId, function (chat) {
		       var content = JSON.parse(chat.body);
		
		       var writer = content.writer;
		       var message = content.message;
		       var str = '';
		
		       if(writer === username){
		           str = "<div class='col-6'>";
		           str += "<div class='alert alert-secondary'>";
		           str += "<b>" + writer + " : " + message + "</b>";
		           str += "</div></div>";
					content += str;
					msgArea.innerHTML = content;
		       }
		       else{
		           str = "<div class='col-6'>";
		           str += "<div class='alert alert-warning'>";
		           str += "<b>" + writer + " : " + message + "</b>";
		           str += "</div></div>";
		           contentt += str;
					msgArea.innerHTML = contentt;
		       }
		
		       contentt += str;
				msgArea.innerHTML = contentt;
		   });
		
		   //3. send(path, header, message) 서버로 메세지 전송
		   stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
		});
		
		// 버튼 클릭시 서버로 메세지 정송
		let sendBtn = document.getElementById("button-send");
		sendBtn.addEventListener('click', (e) => { 
		
		    var msg = document.getElementById("msg");
		
		    console.log(username + ":" + msg.value);
		    stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
		    msg.value = '';
		});
	</script>
</body>
</html>