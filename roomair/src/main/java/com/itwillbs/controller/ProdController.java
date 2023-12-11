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

	// 제품 목록 페이지
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

		// 한 화면에 보여줄 페이지 개수 설정
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
	}

	// 제품 등록 페이지
	@GetMapping("/write")
	public String write(Model model) {
		String code = prodService.makeCode();
		ProdDTO prodDTO = new ProdDTO();
		prodDTO.setProdCode(code);
		model.addAttribute("prodDTO", prodDTO);
		return "product/write";
	}

	// 제품 등록 처리
	@PostMapping("/writePro")
	public String writePro(ProdDTO prodDTO) {

		System.out.println("ProdController writePro()");
		System.out.println(prodDTO);
		// 디비에 제품 등록
		prodService.insert(prodDTO);

		// 제품 목록 페이지로 이동
		return "redirect:/product/list";
	}

	// 제품 수정 페이지
	@GetMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("prodController update()");
		String prodCode = request.getParameter("prodCode");

		// 내용 가져오기
		ProdDTO prodDTO = prodService.getProd(prodCode);

		model.addAttribute("prodDTO", prodDTO);

		return "product/update";
	}

	// 제품 수정 처리
	@PostMapping("/updatePro")
	public String updatePro(ProdDTO prodDTO) {
		System.out.println("ProdController updatePro()");
		// 제품 수정
		prodService.updateProd(prodDTO);

		return "redirect:/product/list";
	}

	// 제품 비고 페이지
	@GetMapping("/memo")
	public String memo(HttpServletRequest request, Model model) {
		System.out.println("ProdController memo()");

		String prodCode = request.getParameter("prodCode");

		// 제품 메모 가져오기
		ProdDTO prodDTO = prodService.getProdMemo(prodCode);
		System.out.println("prodDTO" + prodDTO);
		model.addAttribute("prodDTO", prodDTO);

		return "product/memo";
	}

	// 제품 비고 추가 페이지
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
	}

	// 제품 비고 추가 처리
	@PostMapping("/memotypePro")
	public ResponseEntity<String> prodMemoAddPro(ProdDTO prodDTO) {
		System.out.println("ProdController memotypePro()");
		System.out.println(prodDTO);
		prodService.insertProdMemo(prodDTO);
		// 창을 닫기 위한 스크립트를 반환
		return ResponseEntity.ok(
				"<script>window.onunload = function() { if (window.opener && !window.opener.closed) { window.opener.location.reload(); } }; window.close();</script>");
	}

	// 제품 비고 수정 페이지
	@GetMapping("/memoUpdate")
	public String updateProdMemo(HttpServletRequest request, Model model) {
		System.out.println("ProdController memoUpdate()");

		String prodCode = request.getParameter("prodCode");

		// 제품 가져오기
		ProdDTO prodDTO = prodService.getProdMemo(prodCode);

		model.addAttribute("prodDTO", prodDTO);

		return "product/updateMemo";
	}

	//

	@PostMapping("/memoUpdatePro")
	public ResponseEntity<String> memoUpdatePro(ProdDTO prodDTO) {
	    System.out.println("ProdController memoUpdatePro()");
	    System.out.println(prodDTO);
	    // 제품 비고 수정 처리
	    prodService.updateProdMemo(prodDTO);
	    // 창을 닫기 위한 스크립트를 반환합니다.
	    return ResponseEntity.ok(
	        "<script>window.onunload = function() { if (window.opener && !window.opener.closed) { window.opener.location.reload(); } }; window.close();</script>");
	}// memoUpdatePro

	@PostMapping("/getExcel")
	public ResponseEntity<List<ProdDTO>> excelList(ProdDTO prodDTO) {

	    // 검색 조건이 빈 문자열이거나 "null"일 경우 처리
	    if ("".equals(prodDTO.getProdCode()) || "null".equals(prodDTO.getProdCode()) || prodDTO.getProdCode() == null) {
	        System.out.println("제품 코드 변경");
	        prodDTO.setProdCode("");
	    }
	    if ("".equals(prodDTO.getProdName()) || "null".equals(prodDTO.getProdName()) || prodDTO.getProdName() == null) {
	        System.out.println("제품 이름 변경");
	        prodDTO.setProdName("");
	    }
	    if ("".equals(prodDTO.getClientCompany()) || "null".equals(prodDTO.getClientCompany())
	            || prodDTO.getClientCompany() == null) {
	        System.out.println("거래처 이름 변경");
	        prodDTO.setClientCompany("");
	    }

	    // 엑셀 다운로드를 위한 제품 목록 조회
	    List<ProdDTO> prodList = prodService.getExcelProdSearch(prodDTO);

	    // ResponseEntity를 이용하여 데이터와 상태코드 전송
	    ResponseEntity<List<ProdDTO>> entity = new ResponseEntity<>(prodList, HttpStatus.OK);
	    return entity;
	}

}
