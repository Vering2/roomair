package com.itwillbs.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OrderManagementDAO;
import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class OrderManagementService {

	// OrderManagementDAO 객체생성
	@Inject
	private OrderManagementDAO ordermanagementDAO;

	public void insertOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementService insertOrderManagement()");

		ordermanagementDAO.insertOrderManagement(ordermanagementDTO);
	}

	// home 페이징처리, 검색기능
	public List<OrderManagementDTO> getOrderManagementList(PageDTO pageDTO) {
		System.out.println("OrderManagementService getOrderManagementList()");
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return ordermanagementDAO.getOrderManagementList(pageDTO);
	}

	// home 페이징처리, 검색기능
	public int getOrderManagementCount(PageDTO pageDTO) {
		System.out.println("OrderManagementService getOrderManagementCount()");
		return ordermanagementDAO.getOrderManagementCount(pageDTO);
	}

	// 체크박스로 선택삭제
	public void delete(String buyNum) {
		ordermanagementDAO.delete(buyNum);
	}

	public OrderManagementDTO getDetail(String buyNum) {
		System.out.println("OrderManagementService getDetail()");
		return ordermanagementDAO.getDetail(buyNum);
	}

	public void updateOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementService updateOrderManagement()");
		ordermanagementDAO.updateOrderManagement(ordermanagementDTO);
	}

	// 엑셀
	public List<OrderManagementDTO> getOrderManagementList2() {
		return ordermanagementDAO.getOrderManagementList2();
	}

	// buyDate가 오늘 또는 이전인 경우, buyInstate가 '신청완료'에서 '발주완료'로 변경
	public void updateBuyInstate(Date today) {
		ordermanagementDAO.updateBuyInstate(today);
	}

}