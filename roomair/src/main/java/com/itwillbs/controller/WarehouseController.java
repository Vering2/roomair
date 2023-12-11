package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.service.WarehouseService;

@Controller
@RequestMapping("/Warehouse/")
public class WarehouseController {

	// WarehouseService 객체생성
	@Inject
	private WarehouseService warehouseService;

	@GetMapping("/list")
	public String list(HttpServletRequest request, Model model) {

		String search1 = request.getParameter("search1");
		System.out.println("search1 : " + search1);
		String search2 = request.getParameter("search2");
		System.out.println("search2 : " + search2);
		String search3 = request.getParameter("search3");
		System.out.println("search3 : " + search3);

		// 페이징
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);

		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch1(search1); // 검색어저장
		pageDTO.setSearch2(search2);
		pageDTO.setSearch3(search3);

		List<WarehouseDTO> warehouseList = warehouseService.getWarehouseList(pageDTO);

		int count = warehouseService.getWarehouseCount(pageDTO);
		int pageBlock = 10;
		int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);

		model.addAttribute("warehouseList", warehouseList);
		model.addAttribute("pageDTO", pageDTO);

		return "Warehouse/list";
	} // list

	@GetMapping("/write")
	public String write() {
		return "Warehouse/write";
	} // write

	@PostMapping("/writePro")
	public String writePro(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseController writePro()");
		// 글쓰기
		warehouseService.insertWarehouse(warehouseDTO);
		// 주소 변경 후 이동
		return "redirect:/Warehouse/list";
	} // writePro

	@GetMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("WarehouseController update()");

		String whseCode = request.getParameter("whseCode");

		WarehouseDTO warehouseDTO = warehouseService.getWarehouse(whseCode);
		model.addAttribute("warehouseDTO", warehouseDTO);

		return "Warehouse/update";
	} // update

	@PostMapping("/updatePro")
	public String updatePro(WarehouseDTO warehouseDTO) {
		System.out.println("WarehouseController updatePro()");
		System.out.println(warehouseDTO);
		// 게시판 글 수정
		warehouseService.updateWarehouse(warehouseDTO);
		return "redirect:/Warehouse/list";
	} // updatePro

	// 체크박스로 선택삭제
	@RequestMapping(value = "/delete")
	public String ajaxTest(HttpServletRequest request) throws Exception {
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for (int i = 0; i < size; i++) {
			warehouseService.delete(ajaxMsg[i]);
		}
		return "redirect:/Warehouse/list";
	}

}
