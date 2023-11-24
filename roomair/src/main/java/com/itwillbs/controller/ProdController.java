package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.service.ProdService;


@Controller
@RequestMapping("/product/*")
public class ProdController {

	@Inject
	private ProdService prodService;

	// 소요량관리 정보 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String productDelete(@RequestParam(value = "checked[]") List<String> checked) throws Exception {

		// 서비스 - 소요량관리 삭제
		prodService.productDelete(checked);

		return "redirect:/product/list";
	}

	@GetMapping("/list")
	public String list(ProdDTO prodDTO, Model model, HttpServletRequest request) {
		System.out.println("1");
		
	
		// 검색어 가져오기
		// 페이징-------------------------------------------
		// 한 화면에 보여줄 글개수 설정
		int pageSize = 10;
		// 현 페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		// 페이지 번호가 없을 경우 => "1"로 설정
		if (pageNum == null) {
			pageNum = "1";
		}

		// 페이지 번호 => 정수형 변경
		int currentPage = Integer.parseInt(pageNum);

		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);

		List<ProdDTO> prodList;
		int count;
		if (prodDTO.getProdCode() != null || prodDTO.getProdName() != null || prodDTO.getClientCompany() != null) {
			prodList = prodService.getSearch(prodDTO, pageDTO);
			count = prodService.getSearchcount(prodDTO);

		} else {
			prodList = prodService.getProdList(pageDTO);
			count = prodService.getProdCount(pageDTO);
		}

		// 한화면에 보여줄 페이지 개수 설정
		int pageBlock = 10;
		// 시작하는 페이지 번호
		int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
		// 끝나는 페이지 번호
		int endPage = startPage + pageBlock - 1;
		// 전체페이지 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 끝나는 페이지 번호 전체페이지 개수 비교
		// => 끝나는 페이지 번호가 크면 전체페이지 개수로 변경
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);

		model.addAttribute("prodList", prodList);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("prodDTO", prodDTO);

		return "product/list";
	}//

	@GetMapping("/write")
	public String write(Model model) {
		String code = prodService.makeCode();
		ProdDTO prodDTO = new ProdDTO();
		prodDTO.setProdCode(code);
		model.addAttribute("prodDTO", prodDTO);
		return "product/write";
	}//

	@PostMapping("/writePro")
	public String writePro(ProdDTO prodDTO) {

		System.out.println("ProdController writePro()");
		System.out.println(prodDTO);
		// 디비에 글쓰기
		prodService.insert(prodDTO);

		// 글목록 주소변경하면서 이동 /board/list
		return "redirect:/product/list";
	}//

	@GetMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("prodController update()");
		String prodCode = request.getParameter("prodCode");

		// 내용가져오기
		ProdDTO prodDTO = prodService.getProd(prodCode);

		model.addAttribute("prodDTO", prodDTO);

		return "product/update";
	}

	@PostMapping("/updatePro")
	public String updatePro(ProdDTO prodDTO) {
		System.out.println("ProdController updatePro()");
		// 수정
		prodService.updateProd(prodDTO);

		return "redirect:/product/list";
	}//

	// ----------------------------------------------------- 비고 보기
	// ---------------------------------------
	@GetMapping("/memo")
	public String memo(HttpServletRequest request, Model model) {
		System.out.println("ProdController memo()");

		String prodCode = request.getParameter("prodCode");

		// PordMemo 가져오기
		ProdDTO prodDTO = prodService.getProdMemo(prodCode);
		System.out.println("prodDTO" + prodDTO);
		model.addAttribute("prodDTO", prodDTO);

		return "product/memo";

	}// prodMemo

	// ----------------------------------------------------- 비고 추가
	// ---------------------------------------
	@GetMapping("/memotype")
	public String prodMemoAdd(HttpServletRequest request, Model model) {
		System.out.println("ProdController memotype()");
		String prodCode = request.getParameter("prodCode");
		System.out.println(prodCode);

		ProdDTO prodDTO = prodService.getProdMemo(prodCode);
		String memotype = request.getParameter("memotype");
		System.out.println(memotype);

		model.addAttribute("prodDTO", prodDTO);
		model.addAttribute("memotype", memotype);

		return "product/memotype";
	}// prodMemotype

	@PostMapping("/memotypePro")
	public ResponseEntity<String> prodMemoAddPro(ProdDTO prodDTO) {
		System.out.println("ProdController memotypePro()");
		System.out.println(prodDTO);
		prodService.insertProdMemo(prodDTO);
		return ResponseEntity.ok("<script>window.onunload = function() { if (window.opener && !window.opener.closed) { window.opener.location.reload(); } }; window.close();</script>");


	}// prodMemotypePro

	// ----------------------------------------------------- 비고 수정
	// ---------------------------------------
	@GetMapping("/memoUpdate")
	public String updateProdMemo(HttpServletRequest request, Model model) {
		System.out.println("ProdController memoUpdate()");

		String prodCode = request.getParameter("prodCode");

		// 글가져오기
		ProdDTO prodDTO = prodService.getProdMemo(prodCode);

		model.addAttribute("prodDTO", prodDTO);

		return "product/updateMemo";
	}// prodMemoUpdate

	@PostMapping("/memoUpdatePro")
	public ResponseEntity<String> memoUpdatePro(ProdDTO prodDTO) {
		System.out.println("ProdController memoUpdatePro()");
		System.out.println(prodDTO);
		prodService.updateProdMemo(prodDTO);
		// 창을 닫기 위한 스크립트를 반환합니다.
		return ResponseEntity.ok("<script>window.onunload = function() { if (window.opener && !window.opener.closed) { window.opener.location.reload(); } }; window.close();</script>");

	}// memoUpdatePro
	
	
	@PostMapping("/getExcel")
	public ResponseEntity<List<ProdDTO>> excelList(ProdDTO prodDTO) {
		
		if("".equals(prodDTO.getProdCode()) || "null".equals(prodDTO.getProdCode()) || prodDTO.getProdCode() == null) {
			System.out.println("제품 코드 변경");
			prodDTO.setProdCode("");
		}
		if("".equals(prodDTO.getProdName()) || "null".equals(prodDTO.getProdName()) || prodDTO.getProdName() == null) {
			System.out.println("제품 이름 변경");
			prodDTO.setProdName("");
		}
		if("".equals(prodDTO.getClientCompany()) || "null".equals(prodDTO.getClientCompany()) || prodDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			prodDTO.setClientCompany("");
		}
		
		List<ProdDTO> prodList =  prodService.getExcelProdSearch(prodDTO);
	

		ResponseEntity<List<ProdDTO>> entity = new ResponseEntity<>(prodList, HttpStatus.OK);
		return entity;
		
	}
}
