package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.EmployeesService;
import com.itwillbs.service.PerformanceService;
import com.itwillbs.service.ProdService;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/perf/*")
public class PerformanceController {
	
	@Inject
	private PerformanceService perfService;
	
	@Inject
	private ProdService prodService;
	
	@Inject
	private EmployeesService empService;
	
	private String cont="PerformanceController";
	
	
	@GetMapping("/perf")
	public String perf(Model model,HttpServletRequest request, PerformanceDTO perfDTO, PageDTO pageDTO) {
		
		          //검색어 가져오기
				String search = request.getParameter("search");

				
				
				String cntPerPageParam = request.getParameter("cntPerPage");
				// <----------------------------------->
				// 한 화면에 보여줄 글 개수 
				int pageSize = 10;
				if (cntPerPageParam != null && !cntPerPageParam.isEmpty()) {
				    try {
				        int cntPerPage = Integer.parseInt(cntPerPageParam);
				        pageSize = cntPerPage;
				    } catch (NumberFormatException e) {
				        // Handle the case where the parameter is not a valid integer
				        // You might want to set a default value or show an error message to the user
				    }
				}
				// 현 페이지 번호 가져오기
				String pageNum=request.getParameter("pageNum");
				//페이지 번호가 없을 경우에는 1로 설정
				if (pageNum == null ) {
					pageNum = "1";
				}
				
				// 페이지 번호 => 정수형 변경
				int currentPage = Integer.parseInt(pageNum);
				pageDTO.setPageSize(pageSize);
				pageDTO.setPageNum(pageNum);
				pageDTO.setCurrentPage(currentPage);
				
                   int count;
                   int pageBlock = 5;
   				// 시작하는 페이지 번호
   				int startPage = (currentPage -1)/pageBlock*pageBlock+1;
   				// 끝나는 페이지 번호
   				int endPage = startPage + pageBlock -1;
   				
   			
				
				List<PerformanceDTO> perflist;
				
			//	if (perfDTO.getLineCode() != null || perfDTO.getProdCode() != null || perfDTO.getPerfDate() != null)
				if (perfDTO.getLineCode() != null || perfDTO.getProdCode() != null ) {
				
				count = perfService.getSearchcount(perfDTO);
				
   				// 끝나는 페이지 번호 전체 페이지 개수 비교 
   				
   				
   				perflist = perfService.getSearch(perfDTO, pageDTO);
				
				System.out.println(" IF문 perfList: +++++++++++++ " + perflist);
				System.out.println(" IF문 perfcount: +++++++++++++ " + count);
				}
				else {
					count = perfService.getperfCount(pageDTO);
					perflist = perfService.getperflist(pageDTO);
					
					System.out.println("else문 perfList++++++++++++++++" + perflist);
					System.out.println("else문 perfcount+++++++++++++++"+ count);
				}
			
				//전체페이지 개수 
   				int pageCount = count/pageSize+(count%pageSize==0?0:1);
if(endPage > pageCount ) {
   					
   					endPage= pageCount;
   					
   				}
				
				
				pageDTO.setCount(count);
				pageDTO.setPageBlock(pageBlock);
				pageDTO.setStartPage(startPage);
				pageDTO.setEndPage(endPage);
				pageDTO.setPageCount(pageCount);
	
				 System.out.println("PerformanceController perf메인페이지요청");
				  log.debug("메인페이지  실적코드 요청"); 
				log.debug("실적코드 가지온값들: +++++++"+ perflist);
				log.debug("실적코드 카운트값 출력:++++++++++" + count);
	
		  
		  

		  model.addAttribute("perflist",perflist); 
		  model.addAttribute("pageDTO", pageDTO);
		  model.addAttribute("perfDTO", perfDTO);

		return "perf/perf";
		
	}
	
	@GetMapping("/perfinsert")
	public String perfInsert(Model model) {
		
		System.out.println("PerformanceController perf추가페이지요청");
		log.debug("PerformanceController perf추가페이지요청 ");
		
		/*
		 * List<perfDTO> clientList = clientService.getclientList();
		 * 
		 * 
		 * model.addAttribute("clientList",clientList);
		 * 
		 */
		
		return "perf/perfinsert";
		
		
	}
	
	@GetMapping("/linelist")
	public String linelist(Model model) {
		
		
		log.debug("팝업창 linelist 요청 ");
        List<LineDTO> linelist = perfService.getlinelist();
		
        model.addAttribute("linelist",linelist);
        System.out.println(linelist);
		
		return "perf/linelist";
		
		
	}
	
	@GetMapping("/prodlist")
	public String prodlist(Model model) {
		

		log.debug("팝업창 prodlist 요청 ");
		
        List<ProdDTO> prodlist = perfService.getprodList();
		model.addAttribute("prodlist",prodlist);
		System.out.println(prodlist);
		
		return "perf/prodlist";
		
		
	}
	
	@GetMapping("/worklist")
	public String worklist(Model model) {
		

		log.debug("팝업창 prodlist 요청 ");
		
        List<WorkOrderDTO> worklist = perfService.getworkList();
		model.addAttribute("worklist",worklist);
		System.out.println(worklist);
		
		return "perf/worklist";
		
		
	}
	

@GetMapping("/detail")
public String perfdetail ( HttpServletRequest req , Model model,  PerformanceDTO perfDTO, HttpSession session ) {
	        
	String perfCode=req.getParameter("perfCode");
	log.debug(perfCode);

	PerformanceDTO perfDTO1 = perfService.getdetail(perfCode);
	model.addAttribute("perfDTO", perfDTO1);
	
	// 세션에서 아이디 값을 가져옵니다. (예시: "userId"는 세션에 저장된 사용자 아이디 키)
	HttpSession session1 = req.getSession();
	
	session.setAttribute("EmpId", perfDTO.getPerfEmpId());
	

      


	return "perf/perfdetail";
}






}

