<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="product" value="${productMap.productVO}" />
<c:set var="imageList" value="${productMap.imageList }" />
<%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>

<head>
<link href="${path}/resources/css/productDetail.css" rel="stylesheet" type="text/css" media="screen">
    <style>
        #layer {
            z-index: 2;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            font:10px
        }

        #popup {
            z-index: 3;
            position: fixed;
            text-align: center;
            left: 50%;
            top: 45%;
            width: 300px;
            height: 200px;
            background-color: #fff;
            border: 3px solid #87cb42;
            font:10px
        }

        #close {
            z-index: 4;
            float: right;
        }

    </style>
    
   <script src="${path }/resources/js/jquery-1.6.2.min.js"></script> <!-- tab_container JS --> 
   <script src="${path }/resources/js/tabs.js"></script> <!-- tab_container JS --> 
    
    <script type="text/javascript">
        function add_cart(product_no) {
        	if(${member != null}){
	            $.ajax({
	                type: "post",
	                url: "${path}/cart/addProductInCart.do",
	                data: {
	                    product_no:product_no
	                },
	                success : function(data, textStatus) {
	    				if(data.trim()=='add_success'){
	    					imagePopup('open');	
	    				}else if(data.trim()=='already_existed'){
	    					alert("이미 카트에 등록된 상품입니다.");	
	    				}
	    			},
	                error: function(data, textStatus) {
	                    alert("에러가 발생했습니다. 관리자에게 문의하여 주세요." + data);
	                },
	                complete: function(data, textStatus) {
	                    //alert("작업을완료 했습니다");
	                }
	            }); //end ajax	
        	}else {
        		alert("쇼핑몰 회원만 이용가능합니다. 로그인 후 이용해주세요.");
        		location.href = "${path }/member/loginForm.do";
        	}
        }

        function imagePopup(type) {
            if (type == 'open') {
                jQuery('#layer').attr('style', 'visibility:visible');
                jQuery('#layer').height(jQuery(document).height());
            } else if (type == 'close') {
                jQuery('#layer').attr('style', 'visibility:hidden');
            }
        }

      /*   function fn_order_each_product(product_no, product_name, sales_price, file_name) {
            var _isLogOn = document.getElementById("isLogOn");
            var isLogOn = _isLogOn.value;

            if (isLogOn == "false" || isLogOn == '') {
                alert("로그인 후 주문이 가능합니다!!!");
            }


            var total_price, final_total_price;
            var order_product_qty = document.getElementById("order_product_qty");

            var formObj = document.createElement("form");
            var i_product_no = document.createElement("input");
            var i_product_title = document.createElement("input");
            var i_product_sales_price = document.createElement("input");
            var i_fileName = document.createElement("input");
            var i_order_product_qty = document.createElement("input");

            i_product_no.name = "product_no";
            i_product_title.name = "product_title";
            i_product_sales_price.name = "product_sales_price";
            i_fileName.name = "product_fileName";
            i_order_product_qty.name = "order_product_qty";

            i_product_no.value = product_no;
            i_order_product_qty.value = order_product_qty.value;
            i_product_title.value = product_title;
            i_product_sales_price.value = product_sales_price;
            i_fileName.value = fileName;

            formObj.appendChild(i_product_no);
            formObj.appendChild(i_product_title);
            formObj.appendChild(i_product_sales_price);
            formObj.appendChild(i_fileName);
            formObj.appendChild(i_order_product_qty);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${path}/order/orderEachGoods.do";
            formObj.submit();
        } */

    </script>
</head>

<body>
<div class="product_container">
<div class="productDetail inbox">
    <div class="flex_right">
        <!-- 나중에 수정하기 -->
        <a href=""><img src="" alt="">WHOSBAG</a> &gt;
        <a href="">LEATHER BAG</a> &gt;
        <a href="">TOTE - ${product.product_no}</a>
    </div>
    <div class="product_wrap">
    <div class="product_wrap_01">
        <figure>
            <img alt="상품이미지" src="${path}/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}">
        </figure>
    </div>
    
    <div class="product_wrap_02">
        <h3 class="tit-prd">${product.product_name } [${product.product_color } COLOR] </h3>
            <!-- 베스트 이미지 등.. 넣기 -->
         
            <div class="icons"> 
	             <span class="MK-product-icons red">
                   <c:if test="${product.product_sort == '신상품'}">NEW ${product.discount_rate}%</c:if>
	             </span>
	             <span class="MK-product-icons blue">
	                <c:if test="${product.product_sort == '베스트'}">BEST</c:if>
	             </span>
	             <span class="MK-product-icons green">
	                <c:if test="${product.product_sort == '잇백'}">ITBAG</c:if>
	            </span>                                 
            </div> 
            
            
            <div class="SMS_table_opt1">
                <!-- 판매가격 -->
                <dl class="SMS_price cb_clear">
                    <dt>ORIGIN PRICE</dt>
                    <dd>
                        <span class="SMS_main_display_sales_p strike"><fmt:formatNumber value="${product.origin_price }" pattern="###,###,###"/></span>
                        <span class="sale">(${product.discount_rate }% 할인)</span>
                    </dd>
                </dl>
                 <dl class="SMS_price cb_clear">
                    <dt>SALE PRICE</dt>
                    <dd>
                        <span class="SMS_main_display_discount_p"><fmt:formatNumber value="${product.sale_price }" pattern="###,###,###"/></span>
                        
                    </dd>
                </dl>
                <!-- 포인트 자리 -->
                <!--  <dl class="SMS_reserve 22 cb_clear">
                    <dt>POINT</dt>
                    <dd>
                        1% </dd>
                </dl> -->
            </div>
    

        <div class="SMS_table_opt4">
            <!-- 기본 옵션 (기본) -->
            <div class="opt-wrap">
                <div class="SMS_optcountbox">
                    <dl class="SMS_optcount cb_clear">
                        <!-- 기본옵션 -->
                        <dt>COLOR</dt>
                        <dd>
                            <!-- <select id="optionlist_0" name="optionlist[]" class="vo_value_list" onchange="priceCalculate(this);" mandatory="Y"> -->
                            <select name="product_color" class="form-control">
                                <option value="상품색상">색상을 선택하세요</option>
                                <option value="머드">머드</option>
                                <option value="카멜">카멜</option>
                                <option value="브라운">브라운</option>
                                <option value="블랙">블랙</option>
                                <option value="아이보리">아이보리</option>
                                <option value="베이지">베이지</option>
                                <option value="카키">카키</option>
                                <option value="네이비">네이비</option>
                                <option value="그레이">그레이</option>
                                <option value="그린">그린</option>
                                <option value="옐로우">옐로우</option>
                                <option value="오렌지">오렌지</option>
                                <option value="화이트">화이트</option>
                                <option value="스카이">스카이</option>
                                <option value="라벤더">라벤더</option>
                                <option value="핑크">핑크</option>
                                <option value="올리브">올리브</option>
                                <option value="차콜">차콜</option>
                                <option value="와인">와인</option>
                                <option value="코발트블루">코발트블루</option>
                                <option value="타프베이지">타프베이지</option>
                                <option value="실버">실버</option>
                            </select>
                        </dd>
                    </dl>
                </div>
            </div>
        </div>

        <div class="SMS_table_opt4">
            <div class="opt-wrap">
                <dl class="SMS_quantity cb_clear">
                    <dt>QUANTITY</dt>
                    <dd>
                        <div class="opt-btns">
                            <!-- 수량 증가, 감소 -->
                            <a href="javascript:CountChange('down');">-</a>
                            <input type="text" id="product_amount" name="amount" value="1" size="4" >
                            <a href="javascript:CountChange('up');">+</a>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>

        <div class="SMS_table_opt3">
	        <!-- 옵션적용가격 -->
	            <dt></dt>
	            <%-- <dd><span class="tit_txt">전체 상품 가격 : </span><span class="total_price"><span id="price_text">${product.sale_price }</span></span>원</dd> --%>
	            <dd><span class="tit_txt">전체 상품 가격 : </span><span class="total_price">
	            <fmt:formatNumber value="${product.sale_price}" pattern="###,###,###"/></span>원</dd>
	        </dl>
        </div>
          <!-- 나중에 수정하기 -->  
         <div class="prd-btns">
			<a href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title }','${goods.goods_sales_price}','${goods.goods_fileName}');">
				<img class="smp-btn-cart tb_tagManagerCart" src="${path }/resources/image/btn_h46_order.gif" alt="주문하기" title="주문하기" /></a>
			<a id="cartBtn" href="javascript:add_cart('${product.product_no }')">
				<img class="smp-btn-cart tb_tagManagerCart" src="${path }/resources/image/btn_h46_cart_add.gif" alt="장바구니 담기" title="장바구니 담기" /></a>
		 </div>
		
    	</div> <!-- SMS_table_opt4 -->
</div> <!--product_container -->


<section class="login_banner">
	    <div class="login_banner_box">
	        <ul>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_01.jpg" title="신규회원" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_02.jpg" title="추천인" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_03.jpg" title="회원구매" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_04.jpg" title="1회이상구매" /></a></li>
	        </ul>
	    </div>
	</section> <!-- .login_banner -->

	<!-- 내용 들어 가는 곳 tab_container  -->
	<div class="tab_container">
	
	    <div id="container" class="inbox">
			
			<div class="tab_container_wrap">
				<div class="detailinfo">
					<div class="tab_content tab1" id="tab1">
						<ul class="tabs">
							<li><a href="#tab1" class="active">상품상세</a></li>
							<li><a href="#tab2">배송안내</a></li>
							<li><a href="#tab3">관련상품</a></li>
							<li><a href="#tab4">상품후기</a></li>
							<li><a href="#tab5">상품문의</a></li>
						</ul>
						<h4 class="bld">상품상세</h4>				
						<c:forEach var="image" items="${imageList }">
							<img src="${path}/download?product_no=${product.product_no}&fileName=${image.file_name}">
						</c:forEach>
					</div>	
					<div class="more__button">
	                    <button type="button" class="more">더보기 ▼</button>
	                </div><!-- more__button-->
				</div> <!-- detailinfo -->
				<div class="detailinfo">
					<div class="tab_content tab2" id="tab2">
						<ul class="tabs">
							<li><a href="#tab1">상품상세</a></li>
							<li><a href="#tab2" class="active">배송안내</a></li>
							<li><a href="#tab3">관련상품</a></li>
							<li><a href="#tab4">상품후기</a></li>
							<li><a href="#tab5">상품문의</a></li>
						</ul>
						<h4 class="bld">배송안내</h4>
						<img alt="whosbagnotice" src="${path }/resources/image/whosbagnotice.jpg">
					</div>
					<div class="more__button">
	                    <button type="button" class="more">더보기 ▼</button>
	                </div><!-- more__button-->
				</div> <!-- detailinfo -->
				<div class="detailinfo">
					<div class="tab_content tab3" id="tab3">
						<ul class="tabs">
							<li><a href="#tab1">상품상세</a></li>
							<li><a href="#tab2">배송안내</a></li>
							<li><a href="#tab3" class="active">관련상품</a></li>
							<li><a href="#tab4">상품후기</a></li>
							<li><a href="#tab5">상품문의</a></li>
						</ul>
						<h4 class="bld">관련상품</h4>
					</div>
				</div> <!-- detailinfo -->
				<div class="detailinfo">
					<div class="tab_content tab4" id="tab4">
						<ul class="tabs">
							<li><a href="#tab1">상품상세</a></li>
							<li><a href="#tab2">배송안내</a></li>
							<li><a href="#tab3">관련상품</a></li>
							<li><a href="#tab4" class="active">상품후기</a></li>
							<li><a href="#tab5">상품문의</a></li>
						</ul>
						<h4 class="bld">상품후기</h4>
					</div>
				</div> <!-- detailinfo -->
				<div class="detailinfo">
					<div class="tab_content tab5" id="tab5">
						<ul class="tabs">
							<li><a href="#tab1">상품상세</a></li>
							<li><a href="#tab2">배송안내</a></li>
							<li><a href="#tab3">관련상품</a></li>
							<li><a href="#tab4">상품후기</a></li>
							<li><a href="#tab5" class="active">상품문의</a></li>
						</ul>
						<h4 class="bld">상품문의</h4>
					</div> <!-- detailinfo -->
				
	            </div>
			</div> <!-- tab_container_wrap -->
		</div> 	<!-- #container inbox -->	
	
	</div> <!-- tab_container -->
	
	
	<!-- updown버튼 - JS 완료  -->
	<div class="updown_container">
	    <div class="wrap_fixed_updown fixed">
	        <div class="fixed_updown_btn">
	            <button type="button" class="btn_updown btn_up">▲ Top</button>
	            <button type="button" class="btn_updown btn_down">Down ▼</button>
	        </div>
	    </div>
	</div>		       
    <input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
</div>	<!-- productDetail -->
</div> <!-- product_container -->
</body>

</html>
