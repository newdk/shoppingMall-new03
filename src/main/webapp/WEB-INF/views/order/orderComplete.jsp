<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료 페이지</title>
<style type="text/css">
	section#content ul li { border:5px solid #eee; padding:10px 20px; margin-bottom:20px; }
 	section#content .orderList span { font-size:20px; font-weight:bold; display:inline-block; width:90px; margin-right:10px; }
</style>
</head>
<body>
	<section id="content">
	 
		 <ul class="orderList">
			  <c:forEach items="${orderList}" var="orderList">
				  <li>
					  <div>
						   <p><span>주문번호</span><a href="/shop/orderView?n=${orderList.order_no}">${orderList.order_no}</a></p>
						   <p><span>수령인</span>${orderList.orderRec}</p>
						   <p><span>주소</span>(${orderList.member_add1}) ${orderList.member_add2} ${orderList.member_add3}</p>
						   <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount}" /> 원</p>
					  </div>
				  </li>
			  </c:forEach>
		 </ul>
		 
		 <div><a href="/member/mypageForm.do">주문내역확인</a></div>

	</section>
</body>
</html>