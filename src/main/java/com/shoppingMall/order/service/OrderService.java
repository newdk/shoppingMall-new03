package com.shoppingMall.order.service;



import java.util.List;


import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;

public interface OrderService {
	
	public void orderInfo(OrderVO orderVO) throws Exception;
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws Exception;
	public void deleteCart(String member_id) throws Exception;
	public List<OrderVO> orderList(OrderVO orderVO) throws Exception;
	public List<OrderListVO> orderView(OrderVO orderVO) throws Exception;

}
