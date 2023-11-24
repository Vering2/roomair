package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.PerformanceDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PerformanceService {
	
	@Inject
	private PerformanceDAO perfDAO;
	
	public List<PerformanceDTO> getperflist(PageDTO pageDTO) {
		
		// 10개씩 가져올때 현페이지에 대한 시작하는 행번호 구하기
   		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
   		// 끝나는 행번호 구하기
   		int endRow = startRow + pageDTO.getPageSize() - 1;

   		// 디비 startRow - 1
   		pageDTO.setStartRow(startRow - 1);
   		pageDTO.setEndRow(endRow);
   		
		
		return perfDAO.getperflist(pageDTO);
	}

	public List<LineDTO> getlinelist() {
		
		return perfDAO.getlinelist();
	}

	public List<ProdDTO> getprodList() {
		
		return perfDAO.getprodlist();
	}

	public List<WorkOrderDTO> getworkList() {
	
		return perfDAO.getworklist();
	}



	public PerformanceDTO getdetail(String perfCode) {
		
		return perfDAO.getdetail(perfCode);
	}


	
	public boolean perfdelete(String perfCode) {
		
		
		return perfDAO.perfdelete(perfCode);
	}

	public List<PerformanceDTO> getSearch(PerformanceDTO perfDTO, PageDTO pageDTO) {
		
		System.out.println("PerformanceService getSearch++++++++++++");
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		
		return perfDAO.getSearch(perfDTO,pageDTO);
	}
	
     public int getSearchcount(PerformanceDTO perfDTO) {
		
		return perfDAO.getSearchcount(perfDTO);
	}
	
     public int getperfCount(PageDTO pageDTO) {
 		
		 return perfDAO.getperfCount(pageDTO);
	}
     
     // 도넛차트 값 가져오기
     public List<PerformanceDTO> getdonut(List<String> lineCode) {
    	 
    	 System.out.println("ajaxPerformance getdount() 컨트롤러에서 가져온 값:" +lineCode);
         return perfDAO.getdonut(lineCode);

     }

	public int updateperf(PerformanceDTO perfDTO) {
		
		System.out.println("PerfService ++++++++++++++++" + perfDTO);
		
		return perfDAO.updateperf(perfDTO);
		
	}

	public int updateStock(PerformanceDTO perfDTO) {
		return perfDAO.updateStock(perfDTO);
	}

	public int updateperfSub(PerformanceDTO perfDTO) {
		return perfDAO.updateperfSub(perfDTO);
	}

	public int updateStockSub(PerformanceDTO perfDTO) {
		return perfDAO.updateStockSub(perfDTO);
	}

	



}
