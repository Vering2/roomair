package com.itwillbs.dao;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.SellDTO;

@Repository
public class SellDAO {
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.sellMapper";
	private static final Logger logger = LoggerFactory.getLogger(SellDAO.class);;
	
//----------------------------------------------------- 수주 목록 --------------------------------------------------------	
	public List<SellDTO> getSellList(SellDTO sellDTO) {
		System.out.println("SellDAO getSellList()");

		return sqlSession.selectList(namespace + ".getSellList", sellDTO);
	}// getSellList

//----------------------------------------------------- 수주 개수 --------------------------------------------------------
	public int getSellCount() {
		System.out.println("SellDAO getSellCount()");

		return sqlSession.selectOne(namespace + ".getSellCount");
	}// getSellCount
 
//----------------------------------------------------- 수주 추가 --------------------------------------------------------
	public void insertSell(SellDTO sellDTO) {
		System.out.println("SellDAO insertSell()");

		sqlSession.insert(namespace + ".insertSell", sellDTO);
	}// insertSell
	
//----------------------------------------------------- 수주 정보 보기 ---------------------------------------
	public SellDTO getSell(String sellCode) {
		return sqlSession.selectOne(namespace+".getSell", sellCode);
	}//getSell

//----------------------------------------------------- 수주 수정 ---------------------------------------	
	public void sellUpdate(SellDTO sellDTO) {
		sqlSession.update(namespace+".sellUpdate",sellDTO);
		
	}//sellUpdate
	
//----------------------------------------------------- 수주 삭제 --------------------------------------------------------
	public int sellDelete(List<String> checked) throws Exception {

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String sellCode = it.next();
			System.out.println("삭제할 코드 값 : " + sellCode);
			result += sqlSession.delete(namespace + ".sellDelete", sellCode);
		}
		return result;
	}//sellDelete
	
//----------------------------------------------------- 비고 추가 --------------------------------------------------------
	public void insertSellMemo(SellDTO sellDTO) {
		System.out.println("SellDAO insertSellMemo()");
		System.out.println(sellDTO);


		sqlSession.insert(namespace + ".insertSellMemo", sellDTO);
	}// insertSellMemo
	
//----------------------------------------------------- 비고 보기 --------------------------------------------------------		
		public SellDTO getSellMemo(String sellCode) {
			System.out.println("SellDAO getSellMemo()");
			
			return sqlSession.selectOne(namespace+".getSellMemo", sellCode);
	
		}//getSellMemo
		
//----------------------------------------------------- 비고 수정 ---------------------------------------
		public void updateSellMemo(SellDTO sellDTO) {
			System.out.println("SellDAO updateSellMemo()");

			sqlSession.update(namespace + ".updateSellMemo", sellDTO);
		}// updateSellMemo

		
		//---------------------------------------------- 수주 조회 목록 ------------------------------------------------
		public List<SellDTO> getSellListSearch(SellDTO sellDTO) {
			/*if("전체".equals(sellDTO.getSellState())) {*/
				return sqlSession.selectList(namespace + ".getSellListAllSearch", sellDTO);
				/*
				 * }else { return sqlSession.selectList(namespace + ".getSellListSearch",
				 * sellDTO); }
				 */
		}//getSellListSearch

	//----------------------------------------------------- 수주 조회 개수 --------------------------------------------------------
		public int getSellSearchCount(SellDTO sellDTO) {
			System.out.println("SellDAO getSellSearchCount()");

			return sqlSession.selectOne(namespace + ".getSellSearchCount", sellDTO);
		}//getSellSearchCount

		public List<SellDTO> getExcelList(SellDTO sellDTO) {
			return sqlSession.selectList(namespace + ".getExcelList", sellDTO);
		}
		
		

		
		



}// class
