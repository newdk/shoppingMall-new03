package com.shoppingMall.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;

public interface OrderDAO {
	
	public void orderInfo(OrderVO orderVO) throws DataAccessException;
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws DataAccessException;
	public void deleteCart(String member_id) throws DataAccessException;
	public List<OrderVO> orderList(OrderVO orderVO) throws DataAccessException;
	public List<OrderListVO> orderView(OrderVO orderVO) throws DataAccessException;
}
