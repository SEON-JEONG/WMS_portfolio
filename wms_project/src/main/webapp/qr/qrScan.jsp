<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1">
	<thead>
		<tr>
			<th>주문번호</th>
			<th>고객명</th>
			<th>배송현황</th>
		</tr>
	</thead>


	<tbody>
		<tr>
			<td>${scode}</td>
			<td>${usernm}</td>
			<td>${delivery}</td>
		</tr>
	</tbody>

</table>


</body>
</html>