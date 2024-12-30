<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR생성</title>
</head>
<body>
주문번호 : <input type="text" id="scode" maxlength="6"><br>
<input type="button" value="QR 생성" onclick="qr_make()">
<div id="qrView"></div>
<img id="qrImg" src="">
</body>

<script>
function qr_make(){
	var html;	//ajax 함수
	var data = document.getElementById("scode");
	if(data.value == ""){
		alert("주문번호를 입력하세요");
	}
	else{
		html = new XMLHttpRequest();
		html.onreadystatechange = function(){
			if(html.readyState == XMLHttpRequest.DONE && html.status ==200){
				console.log(this.response);
				if(this.responseText != "error"){
					// 이쪽에 초기화를 한번시키는 코드가 들어가야한다!!!!!!!!!!!!!!
					document.getElementById("qrView").append(this.responseText);   // 이건 URL이 출력됨
					document.getElementById("qrImg").src= this.responseText;    // 이건 이미지 출력!!
					
				}
			}
		}
	}
	html.open("PUT","./qr/"+data.value,true);
	html.send();
}
</script>
</html>