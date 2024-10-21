<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Chat Rooms</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
	<form action="/chat/room" method="post" name="form">
		<div class="input-group mb-3">
		<span class="input-group-text" id="inputGroup-sizing-default">Room Name</span>
		    <input type="text" name="name" class="form-control" placeholder="Enter Room Name">
		    <button id="btn-create" class="btn btn-secondary">개설하기</button>
		</div>
	</form>
    <div>
    	<!-- c:foreach -->
    	<c:forEach items="${rooms}" var="room">
	        <ul class="list-group">
	            <li class="list-group-item"><a href="/chat/room?roomId=${room.roomId}">Chat Room Name : ${room.name}</a></li>
	        </ul>
    	
    	</c:forEach>
    </div>
</div>

<script>
	var roomName = "${roomName}";
	
	if(roomName != null && roomName != '') {
	    alert(roomName + "방이 개설되었습니다.");
	}
	let btnCreate = document.getElementById('btn-create');
	
	var form = document.form;
	
	btnCreate.addEventListener('click', (e) => { 
		e.preventDefault();
		
		var name = form.name.value;
	
	    if(name == ""){
	        alert("Please write the name.");
	    }else {
	    	form.submit();
	    }
	});
</script>
</body>
</html>