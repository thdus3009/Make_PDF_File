<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/html2canvas.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/jspdf.min.js"></script>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/NewFile.css" />
   
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="https://www.gallery360.co.kr/resource/css/library.css?open?ver=9.10">
    <link rel="stylesheet" type="text/css" href="https://www.gallery360.co.kr/resource/css/jquery-ui.css?open?ver=9.10">
    <link rel="stylesheet" type="text/css" href="https://www.gallery360.co.kr/resource/css/home/style.css?open?ver=9.10">
    <link rel="stylesheet" type="text/css" href="https://www.gallery360.co.kr/resource/css/base.css?open?ver=9.10">
    <link rel="stylesheet" type="text/css" href="https://www.gallery360.co.kr/resource/css/common.css?open?ver=9.10">
    <link rel="stylesheet" href="https://www.gallery360.co.kr/resource/css/partner/request.css?open?ver=9.10">
    <link rel="stylesheet" href="https://www.gallery360.co.kr/resource/css/partner/deco.css?open?ver=9.10">
    <link rel="stylesheet" href="https://www.gallery360.co.kr/resource/css/partner/account.css?open?ver=1.0">
    <link rel="stylesheet" href="https://www.gallery360.co.kr/resource/css/partner/vrscreen.css?open?ver=1.0">

</head>
<body>
<div class="estimate-wrap">
        <div class="estimate-header">
            <h3>자동 견적 내기</h3>
        </div><!--estimate-header end-->
        <div class="estimate-con esti-auto">
            <p>
                VR갤러리는 전시기획자가 원하는 대로 창의적인 전시가 가능합니다.<br/>
                <br/>
                처음 대관하시는 분들은 작품 크기와 작품 수량에 대한 안내를 읽어 보시고<br/>
                필요하신 대관 개수를 입력하여 주세요.
            </p>
            <p>
                VR갤러리의 가상공간은 대략 오프란인 전시공간 25~30평 규모로,<br/>
                <span>&middot;</span>작품은 입력하는 값에 따라 크기 설정이 가능합니다.<br/>
                <span>&middot;</span>작품 사이즈 50cm, 작품 이미지 해상도 1000px 이상 크기부터 이상적으로 잘 보입니다.<br/>
                <span>&middot;</span>디스플레이 간격, 방식에 따라 차이가 발생할 수 있습니다.<br/>
                <span>&middot;</span>하나의 가상공간 내에 너무 많은 작품을 전시하는 경우 로딩 속도가 느려질 수 있습니다.
            </p>
            <div class="work-size-table">
                <p>&lt; 작품 사이즈 별 추천 작품 개수 &gt;</p>
                <table class="size-amount">
                    <thead>
                        <tr>
                            <th>8절지<br/><span>39 x 27cm</span></th>
                            <th>25호<br/><span>80 x 65cm</span></th>
                            <th>100호<br/><span>162 x 130cm</span></th>
                            <th>300호<br/><span>290 x 220cm</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>35점</td>
                            <td>15점</td>
                            <td>11점</td>
                            <td>5점</td>
                        </tr>
                    </tbody>
                </table><!--size-amount end-->
                
                
                
                <div class="rent-calculate">
                    <div class="auto-cal">
                        <input type="text" id="number_place" size="20" maxlength="3" placeholder="2" required>개관
                        <input type="text" id="length_month" size="20" maxlength="3" placeholder="2" required>개월
                        <div class="estimate-btn-nb">VR갤러리 대관 비용 확인하기</div>
                    </div><!--auto-cal end-->
                    <div class="estimate-price">
	                     <span class="price2">660,000</span>&ensp;원
	                    <!-- <input type="text" class="price2" placeholder="2" readonly="readonly">원 -->
	                    <br/>(부가세 포함)
                    </div>
                </div><!--rent-calculate end-->
                <div id="pdfDiv"></div>
                <div class="estimate-btn" id="savePdf">견적서 다운로드</div>
                
                
                
            </div><!--work-size-table end-->
        </div><!--estimate-con .esti-auto end-->
        <div class="estimate-header">
            <h3>이용 요금 결제 안내</h3>
        </div><!--estimate-header end-->
        <div class="estimate-con">
            <div class="estimate-transfer">
                <p>계좌 이체</p>
                <div class="transfer-txt">
                    <p>입금 계좌: OO은행 000-0000-00000 갤러리360</p>
                    <p>입금자 성함이 다른 경우에는 카카오톡으로 문의 남겨주세요.</p>
                    <div class="estimate-btn">계좌 정보 다운로드</div>
                </div><!--transfer-txt end-->
            </div><!--estimate-transfer end-->
            <div class="estimate-credit">
                <p>계좌 이체</p>
                <div class="credit-txt">
                    <p>BC카드 및 국민카드를 제외한 신용카드 결제가 가능합니다.</p>
                    <div class="estimate-btn">신용카드 결제하기</div>
                </div><!--credit-txt end-->
            </div><!--estimate-credit end-->
        </div><!--estimate-con end-->
        <div class="estimate-header">
            <h3>결제 내역 확인</h3>
        </div><!--estimate-header end-->
        <div class="estimate-con">
            <p>서비스 관리 페이지에서 이용 중인 서비스 내역을 확인하시고 필요한 증빙자료를 요청하실 수 있습니다.</p>
        </div><!--estimate-con end-->
    </div><!--estimate-wrap end-->

	
	
	
<!-- javaScript -->	
<script type="text/javascript">

$(document).ready(function() {
	
	/* 금액 콤마(,) 삽입 */
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	
	$('.estimate-btn-nb').click(function(){
		var amount = $("#number_place").val(); //대관개수
		var term = $("#length_month").val(); //사용기간(월)
		var price = 150000;
		
		var all_price = (amount*term*price); //할인 들어가기전 최종금액
		/* var sale = 0;  *///할인 금액
		
		var price1; //최종금액 (세전)
		var price2; //최종금액 (세후)
		
		if(term>=3){
			price1=amount*(price*term*0.89);
			var sale = amount*(price*term*0.11);
		}else{
			price1=amount*(price*term);
		}
		var tax = price1/10;
		
		price2 = price1+tax;
		
		/* 계산 끝 */
		$(".price2").text(numberWithCommas(price2));
	});
	
	$('#savePdf').click(function() { // pdf저장 button id
		
		if($("#number_place").val()==""||$("#length_month").val()==""){
			alert("견적하기 위한 개관과 개월 수를 입력해주세요.")
		}else{
			var newWindow = window.open('/Make_PDF_File/NewFile2.jsp','Estimate_Form','width=750,height=900')			
		}
		
		
/*  	    html2canvas($('#pdfDiv')[0]).then(function(canvas) { //저장 영역 div id
	    	
		   	var newWindow = window.open('/Make_PDF_File/NewFile2.jsp', 'test', 'width=750,height=900');	
		    // 캔버스를 이미지로 변환
		    var imgData = newWindow.toDataURL('image/png');
		    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var imgHeight = canvas.height * imgWidth / canvas.width;
		    var heightLeft = imgHeight;
		    var margin = 10; // 출력 페이지 여백설정
		    var doc = new jsPDF('p', 'mm','a4');
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
		    
		    // 파일 저장
		    doc.save('file-name1.pdf');

		});  */

	});
	
	
})

</script>

</body>
</html>