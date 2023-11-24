package com.itwillbs.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.OrderManagementDTO;
import com.itwillbs.domain.PageDTO;

@Repository 
public class OrderManagementDAO {
	 
	// mybatis 객체생성 
	@Inject
	private SqlSession sqlSession;
		
	// 이름이 너무 기니까 변수로 저장
	private static final String namespace = "com.itwillbs.mappers.OrderManagementMapper";

	public void insertOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementDAO insertOrderManagement()");
		sqlSession.insert(namespace+".insertOrderManagement", ordermanagementDTO);
	}

	// home 페이징처리, 검색기능
	public List<OrderManagementDTO> getOrderManagementList(PageDTO pageDTO) {
		System.out.println("OrderManagementDAO getOrderManagementList()");
		return sqlSession.selectList(namespace+".getOrderManagementList", pageDTO);
	}
	
	// home 페이징처리, 검색기능
	public int getOrderManagementCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsDAO getOrderManagementCount()");
		return sqlSession.selectOne(namespace+".getOrderManagementCount",pageDTO);
	}
	
	// 체크박스로 선택삭제
	public void delete(String buyNum){
		sqlSession.delete(namespace + ".delete", buyNum); 
	}

	public OrderManagementDTO getDetail(String buyNum) {
		System.out.println("OrderManagementDAO getDetail()");
		return sqlSession.selectOne(namespace+".getDetail", buyNum);
	}

	public void updateOrderManagement(OrderManagementDTO ordermanagementDTO) {
		System.out.println("OrderManagementDAO updateOrderManagement()");
		sqlSession.update(namespace+".updateOrderManagement", ordermanagementDTO);
	}

	// 엑셀
	public List<OrderManagementDTO> getOrderManagementList2() {
		return sqlSession.selectList(namespace+".getOrderManagementList2");
	}

	// buyDate가 오늘 또는 이전인 경우, buyInstate가 '신청완료'에서 '발주완료'로 변경
	public void updateBuyInstate(Date today) {
		sqlSession.update(namespace+".updateBuyInstate", today);
	}
	
}