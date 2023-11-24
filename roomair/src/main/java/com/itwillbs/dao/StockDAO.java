package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

@Repository
public class StockDAO {
	
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.Mappers.StockMapper";

	public Integer getMaxNum() {
		System.out.println("StockDAO getMaxNum()");
		
		return sqlSession.selectOne(namespace+".getMaxNum");
	} // getMaxNum()

	public void insertBoard(StockDTO stockDTO) {
		System.out.println("StockDAO insertBoard()");
		
		sqlSession.insert(namespace+".insertBoard", stockDTO);
	} // insertBoard()



	public void updateBoard(StockDTO stockDTO) {
		System.out.println("StockDAO updateBoard()");
		sqlSession.update(namespace+".updateBoard", stockDTO);
	} // updateBoard

	public List<StockDTO> getstockListR(PageDTO pageDTO) {
System.out.println("StockDAO getBoardList()");
		
		return sqlSession.selectList(namespace+".getstockListR",pageDTO);
	}

	public List<StockDTO> getstockListP(PageDTO pageDTO) {
		
		return sqlSession.selectList(namespace+".getstockListP",pageDTO);
	}

	public int getStockCountR() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getStockCountR");
	}

	public int getStockCountP() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getStockCountP");
	}

	public StockDTO getBoardR(int stockNum) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getBoardR", stockNum);
	}

	public StockDTO getBoardP(int stockNum) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getBoardP", stockNum);
	}


}
