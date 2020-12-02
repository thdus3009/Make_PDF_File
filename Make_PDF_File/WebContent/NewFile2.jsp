<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/html2canvas.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/jspdf.min.js"></script>

<style type="text/css">
  #pdfDiv {
  	width: 190mm;
  	height: 190*1.414mm;  	
  }
  #color {
  	background-color: pink;
  }
  table {
  	width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>

<title>Insert title here</title>
</head>
<body>

<div id="pdfDiv">
<br><br>
	<table>
		<thead>
			<tr id="color"><td colspan="3" style="font-size: 40px;">갤러리 360</td></tr>
			<tr>
				<td>이름</td>
				<td>대관수</td>
				<td>사용기간</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>김소연</td>
				<td class="amount"></td>
				<td class="term"></td>
			</tr>
		</tbody>
	</table>
</div>

<br>
</div>

<button type="button" class="btn btn-primary" id="savePdf" >PDF 저장</button>



<script>
$(document).ready(function() {

	/* 	var a=3; 
	var b=a+3;
	$(".amount").text(b); //이런식으로 값넣고 사용가능*/
	
	$('#savePdf').click(function() { // pdf저장 button id
		
	    html2canvas($('#pdfDiv')[0]).then(function(canvas) { //저장 영역 div id
		
	    // 캔버스를 이미지로 변환
	    var imgData = canvas.toDataURL('image/png');
		     
	    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
	    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	    var imgHeight = canvas.height * imgWidth / canvas.width;
	    var heightLeft = imgHeight;
	    var margin = 10; // 출력 페이지 여백설정
	    var doc = new jsPDF('p', 'mm');
	    var position = 0;
	       
	    // 첫 페이지 출력
	    doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	    heightLeft -= pageHeight;
	         
	    // 한 페이지 이상일 경우 루프 돌면서 출력
	    while (heightLeft >= 20) {
	        position = heightLeft - imgHeight;
	        doc.addPage();
	        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	        heightLeft -= pageHeight;
	    }
	    
/* 	    doc.line(15,19,190,19); //시작x, 시작y, 종료x, 종료y
	    doc.text(15,40,'안녕하세요'); */
	    
	    // 파일 저장
	    doc.save('file-name.pdf');

		  
	});

	});
	
	
})



</script>

</body>
</html>