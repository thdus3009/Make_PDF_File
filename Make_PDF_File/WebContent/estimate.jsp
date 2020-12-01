<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.Calendar" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>
<title>Insert title here</title>
</head>
<body>

 	<%Calendar cal = Calendar.getInstance();%>

	<p>견적서 -비용확인</p>
	<!-- 견적일자 : hidden -->
	<input type="hidden" value="<%= cal.get(Calendar.YEAR) %>년 <%= cal.get(Calendar.MONTH)+1 %>월 <%= cal.get(Calendar.DATE) %>일"></input>
	 기간: <input class="term" type="text"></input>
	 <br>
	 수량: <input class="amount" type="text"></input>
	 <br><br>
	<button onclick="test()">견적서 출력하기</button>
	
	
	
	<script type="text/javascript">
		
		function test(){
			var openWin;
			openWin = window.open("NewFile.html","childForm","width=570, height=350");
			openWin.document.getElementsByClassName("term1").text = document.getElementsByClassName("term").value;
			openWin.document.getElementsByClassName("amount1").text = document.getElementsByClassName("amount").value;
			
			document.getElementsByClassName("term2").value = document.getElementsByClassName("term").value
			document.getElementsByClassName("amount2").value = document.getElementsByClassName("amount").value
		}
	
	</script>
	
</body>
</html>