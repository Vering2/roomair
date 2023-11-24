package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.LineService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/line/*")
public class LineController {
	
	@Inject
	private LineService lineService;
	
//	라인관리 홈
	@GetMapping("/line")
	public String line(HttpServletRequest request,Model model) {
		String search = request.getParameter("search");
		int pageSize = 10;
		String pageNum=request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		PageDTO pageDTO =new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch(search);
		List<LineDTO> lineList= lineService.getlineList(pageDTO);
		int count = lineService.getlineCount(pageDTO);
		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("lineList", lineList);
		return "line/line";	
	}
	
//	라인등록 홈
	@GetMapping("/line2")
	public String line2() {	
		return "line/line2";	
	}
	
//	라인등록
	@PostMapping("/insertPro")
	public String insertPro(LineDTO lineDTO) {
		lineService.insertLine(lineDTO);
		return "redirect:/line/line";
	}
	
	// 게시물 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	lineService.delete(ajaxMsg[i]);
        }
        return "redirect:/line/line";
    }//delete
    
//    라인수정 홈
    @GetMapping("/update")
	public String update(HttpServletRequest request,Model model) {
		String lineCode = request.getParameter("lineCode");
		LineDTO lineDTO = lineService.getLine(lineCode);
		model.addAttribute("lineDTO", lineDTO);
		return "line/line3";
	}//update
    
//    라인수정
    @PostMapping("/updatePro")
	public String updatePro(LineDTO lineDTO, RedirectAttributes rttr) {
	    lineService.updateLine(lineDTO);
	    rttr.addFlashAttribute("refreshAndClose", true);
	    return "redirect:/line/line";
	}
    


}
