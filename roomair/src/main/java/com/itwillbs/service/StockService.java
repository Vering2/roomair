package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.StockDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

@Service
public class StockService {
	
	// StockDAO 객체생성
	@Inject
	private StockDAO stockDAO;

	public void insertBoard(StockDTO stockDTO) {
		System.out.println("StockService insertBoard()");
		stockDAO.insertBoard(stockDTO);
	} // insertBoard()







	public void updateBoard(StockDTO stockDTO) {
		System.out.println("StockService updateBoard()");
		stockDAO.updateBoard(stockDTO);
	} // updateboard


	public List<StockDTO> getstockListR(PageDTO pageDTO) {
		System.out.println("StockService getBoardList()");
		// 시작하는 행번호
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		// 끝나느 행번호
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		// 디비작업 startRow -1
		pageDTO.setStartRow(startRow-1);
		pageDTO.setEndRow(endRow);
		
		return stockDAO.getstockListR(pageDTO);
	}


	public List<StockDTO> getstockListP(PageDTO pageDTO) {
		System.out.println("StockService getBoardList()");
		// 시작하는 행번호
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		// 끝나느 행번호
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		// 디비작업 startRow -1
		pageDTO.setStartRow(startRow-1);
		pageDTO.setEndRow(endRow);
		
		return stockDAO.getstockListP(pageDTO);
	}


	public int getStockCountR(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return stockDAO.getStockCountR();
	}




	public int getStockCountP(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return stockDAO.getStockCountP();
	}




	public StockDTO getBoardR(int stockNum) {
		// TODO Auto-generated method stub
		return stockDAO.getBoardR(stockNum);
	}







	public StockDTO getBoardP(int stockNum) {
		// TODO Auto-generated method stub
		return stockDAO.getBoardP(stockNum);
	}

} // StockService
