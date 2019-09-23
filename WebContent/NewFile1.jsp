<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<select>
<option>년도</option>
<option value="19">19</option>
<option value="20">20</option>

</select>

<select>
<option>월</option>
<%for(int i=1; i<13; i++){
	String j = String.format("$02d", i);
	%>
<option value=<%=j %>><%=j %></option>
<%} %>

</select>

<select>
<option>일</option>

<option value="01">01</option>
</select>

</body>
</html>