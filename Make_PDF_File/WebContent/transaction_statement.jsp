<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.Calendar" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>
</head>
<body>

	<!-- 원래는 DB에 정보가져와서 pdf출력해야하는데,
	 없으니까 임의의 값을 넣어서 테스트 해보기 / 버튼클릭 > 출력 -->
	 <%Calendar cal = Calendar.getInstance();%>
	 <p>DB에서 정보를 받아오기전에 여기에 입력해서 제대로 pdf 출력되는지 Test</p>
	 <p>3개월이상 10프로 할인 계산은 안넣은 상태</p>
	 날짜: <input class="date" type="text" value="<%= cal.get(Calendar.YEAR) %>년 <%= cal.get(Calendar.MONTH)+1 %>월 <%= cal.get(Calendar.DATE) %>일"></input>
	 <br>
	 고객명: <input class="customer" type="text"></input>
	 <br>
	 *기간: <input class="term" type="text"></input>
	 <br>
	 *수량: <input class="amount" type="text"></input>
	 <br>
	 단가: <input class="price" type="text" value="150000"></input>
	 <!-- 공급가액 : 단가*수량 -->
	 <br>
	<button onclick="test()">PDF 출력하기</button>
	
	<button onclick="popup()">test</button>
	
	
	
	
	
	
	
	<!-- javascript -->
	<script type="text/javascript">
	
		function popup(){
			
		}
	
	
		function test(){

/* 			var html = "<html>" +
			"<head></head>" +
			"<body>" +
			"<div class=\"date\">"+$(".date").val()+"</div>" +
			"<div class=\"customer\">"+$(".customer").val()+" 귀하</div>" +
			"<div></div>"+
			"</body>" +
			"</html>"; */
			
			var date = $(".date").val();
			var customer = $(".customer").val();
			var term = $(".term").val();
			var amount = $(".amount").val();
			var price = $(".price").val();
			
			
			var data = JSON.stringify({
				"date" : date,
				"customer" : customer,
				"term" : term,
				"amount" : amount,
				"price" : price
			}) 	

			var url = "/Make_PDF_File/test.p";
			
			$.ajax({
				type : "POST",
				dataType : "json",
				data : data,
				contentType : "application/json; charset=utf-8", 
				url : url,
				success : function(dboj){
					console.log(dboj.html);
					$(".customer").val("");
					$(".term").val("");
					$(".amount").val("");

					alert("pdf다운로드 완료");
				},
				error : function(e){
					alert("ERROR!(?) : " + e);
				}
			})
		
		}	
	</script>
</body>
</html>