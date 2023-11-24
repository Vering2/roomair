package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.service.StockService;

@Controller
public class StockController {
	
	// StockService 객체생성
	@Inject
	private StockService stockService;
	
	@RequestMapping(value="/stock/listraw", method=RequestMethod.GET)
	public String listraw(HttpServletRequest request,Model model) {
		
		String search1 = request.getParameter("search1");
		System.out.println("search1 : " + search1);
		String search2 = request.getParameter("search2");
		System.out.println("search2 : " + search2);
		
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum="1";
		}
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch1(search1); // 검색어저장
		pageDTO.setSearch2(search2);
		
		List<StockDTO> stockListR=stockService.getstockListR(pageDTO);
		
		int count = stockService.getStockCountR(pageDTO);
		int pageBlock = 10;
		int startPage = (currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		if(endPage>pageCount) {
			endPage = pageCount;
		}
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		model.addAttribute("stockListR", stockListR);
		model.addAttribute("pageDTO", pageDTO);
        
		// stock/list.jsp
		// WEB-INF/views/stock/list.jsp
		return "stock/listraw";
	} // list
	
	@RequestMapping(value="/stock/listpro", method=RequestMethod.GET)
	public String listpro(HttpServletRequest request,Model model) {
		
		String search1 = request.getParameter("search1");
		System.out.println("search1 : " + search1);
		String search2 = request.getParameter("search2");
		System.out.println("search2 : " + search2);
		
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum="1";
		}
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch1(search1); // 검색어저장
		pageDTO.setSearch2(search2);
		
		List<StockDTO> stockListP=stockService.getstockListP(pageDTO);
		
		int count = stockService.getStockCountP(pageDTO);
		int pageBlock = 10;
		int startPage = (currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		if(endPage>pageCount) {
			endPage = pageCount;
		}
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		model.addAttribute("stockListP", stockListP);
		model.addAttribute("pageDTO", pageDTO);
        
		// stock/list.jsp
		// WEB-INF/views/stock/list.jsp
		return "stock/listpro";
	} // listpro
	
	@RequestMapping(value = "/stock/updateR", method = RequestMethod.GET)
	public String updateR(HttpServletRequest request, Model model) {
		System.out.println("StockController update()");
		int stockNum = Integer.parseInt(request.getParameter("stockNum"));
		// num에 대한 게시판 글 가져오기
        StockDTO stockDTO = stockService.getBoardR(stockNum);		
		model.addAttribute("stockDTO", stockDTO);
		// stock/update.jsp
		// WEB-INF/views/stock/update.jsp
		return "stock/updateR";
	}// update
	
	@RequestMapping(value = "/stock/updateP", method = RequestMethod.GET)
	public String updateP(HttpServletRequest request, Model model) {
		System.out.println("StockController update()");
		int stockNum = Integer.parseInt(request.getParameter("stockNum"));
		// num에 대한 게시판 글 가져오기
        StockDTO stockDTO = stockService.getBoardP(stockNum);		
		model.addAttribute("stockDTO", stockDTO);
		// stock/update.jsp
		// WEB-INF/views/stock/update.jsp
		return "stock/updateP";
	}// update
	
	@RequestMapping(value="/stock/updatePro", method = RequestMethod.POST)
	public String updatePro(StockDTO stockDTO) {
		System.out.println("StockController updatePro()");
		System.out.println(stockDTO);
		// prodCode에 대한 게시판 글 수정
		stockService.updateBoard(stockDTO);
		
		return "redirect:/stock/listraw";
	} // updatePro
	

}
