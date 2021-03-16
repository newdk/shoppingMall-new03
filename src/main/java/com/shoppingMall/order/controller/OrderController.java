package com.shoppingMall.order.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.order.service.OrderService;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping("/order")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;
	
	@Autowired(required = false)
	private OrderDetailsVO orderDetailVO;
	
	@Autowired(required = false)
	private OrderVO orderVO;

	// 주문 화면
	@RequestMapping(value = "/orderMain.do")
	public ModelAndView orderMain(HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	// 주문 하기
	@RequestMapping(value = "/order.do", method = RequestMethod.POST)
	public ModelAndView order(@RequestParam Map<String, String> orderMap, HttpServletRequest request) {
//		public ModelAndView order(OrderVO orderVO, OrderDetailsVO orderDetailVO, HttpServletRequest request) {
		/*
		   파라미터(맵으로 받아야겠음)
		 	 1. 회원
		 	  - 수령인이름: orderRec
		 	  - 연락처1 : emergency21 + emergency22 + emergency23 -> 합치기
		 	  - 주소 : member_add1 / member_add2 / member_add3 -> 3개 각자 저장
		 	  - 배송 메세지 : order_msg
		 	 
		 	 2. 비회원
		 	  - 이름 :
		 	  - 이메일 : 이메일 앞자리+뒷자리 -> 합치기
		 	  - 전화 번호 : 앞+중+끝 -> 합치기
		*/
		
		// 주문 완료 후 주문한 정보를 보여주는 페이지로 이동 - 아직 안만듦
		String viewName = "/order/orderComplete";
		ModelAndView mav = new ModelAndView(viewName);
		
		logger.info("orderMap:" + orderMap.toString());
		
		// 맵에 저장된 파라미터 뽑기
		String emergency21 = orderMap.get("emergency21");
		String emergency22 = orderMap.get("emergency22");
		String emergency23 = orderMap.get("emergency23");
		String phone = emergency21 + emergency22 + emergency23;
		
		orderVO.setOrderRec(orderMap.get("orderRec"));
		orderVO.setMember_add1(orderMap.get("member_add1"));
		orderVO.setMember_add2(orderMap.get("member_add2"));
		orderVO.setMember_add3(orderMap.get("member_add3"));
		orderVO.setOrder_msg(orderMap.get("order_msg"));
		orderVO.setPhone(phone);

		// 세션에 저장된 로그인한 아이디 뽑기
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		
		// 년/월/일과 랜덤숫자를 이용해 주문 번호 만들기
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		// 무작위 6자리 숫자 생성
		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}

		// 주문번호 = "날짜-랜덤숫자"
		String order_no = ymd + "-" + subNum;

		orderVO.setOrder_no(order_no);
		orderVO.setMember_id(member_id);

		orderDetailVO.setOrder_no(order_no);

		try {
			// 주문 정보 저장
			orderService.orderInfo(orderVO);
			// 주문 상세 정보 저장
			orderService.orderInfoDetails(orderDetailVO);
			// 주문 후 장바구니 지우기
			orderService.deleteCart(member_id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	// 특정 회원의 주문 목록 조회
	@RequestMapping(value="/orderList.do", method = RequestMethod.POST)
	public ModelAndView orderList(HttpServletRequest request) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		
		orderVO.setMember_id(member_id);
		try {
			List<OrderVO> orderList = orderService.orderList(orderVO);
			mav.addObject("orderList", orderList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// 주문 상세 목록(주문 정보, 주문 상세 정보)
	@RequestMapping(value="/orderView.do")
	public ModelAndView orderView(HttpServletRequest request) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
}
