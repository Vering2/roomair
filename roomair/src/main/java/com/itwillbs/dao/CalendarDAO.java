package com.itwillbs.dao;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.SellDTO;

@Repository
public class CalendarDAO {

	
	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.calendarMapper.";
	
	public List<CalendarDTO> getCalendarList() {
		return sqlSession.selectList(namespace+"getCalendarList");
	}

	public List<ChartDTO> getSalesList() {
		return sqlSession.selectList(namespace+"getSalesList");
	}

	public List<ChartDTO> getStockList() {
		return sqlSession.selectList(namespace+"getStockList");
	}

	public List<ChartDTO> getPerfList() {
		return sqlSession.selectList(namespace+"getPerfList");
	}
	
	public List<ChartDTO> getLinePerfList() {
		return sqlSession.selectList(namespace+"getLinePerfList");
	}

	public void insertSellCalendar(CalendarDTO calendarDTO) {
		sqlSession.selectList(namespace+"insertSellCalendar", calendarDTO);
	}

	public ClientDTO getClient(String code) {
		return sqlSession.selectOne(namespace+"getClient", code);
	}

	public void deleteSellCalendar(List<String> checked) {
		Iterator<String> it = checked.iterator();

		while (it.hasNext()) {
			String code = it.next();
			System.out.println("삭제할 코드 값 : " + code);
			sqlSession.delete(namespace + "deleteSellCalendar", code);
		}
	}

	

}
