package com.shoppingMall.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.order.dao.OrderDAO;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;

@Service("orderService")
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderDAO;
	
	// 주문 정보 저장
	@Override
	public void orderInfo(OrderVO orderVO) throws Exception {
		orderDAO.orderInfo(orderVO);
	}

	// 주문 상세 정보 저장
	@Override
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws Exception {
		orderDAO.orderInfoDetails(orderDetailvo);
	}

	// 주문 후 장바구니 비우기
	@Override
	public void deleteCart(String member_id) throws Exception {
		orderDAO.deleteCart(member_id);
	}

	// 특정 회원의 주문 정보 조회
	@Override
	public List<OrderVO> orderList(OrderVO orderVO) throws Exception {
		return orderDAO.orderList(orderVO);
	}

	// 주문 정보와 주문 상세 정보 조회
	@Override
	public List<OrderListVO> orderView(OrderVO orderVO) throws Exception {
		return orderDAO.orderView(orderVO);
	}

}
