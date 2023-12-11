package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.PerformanceService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/perf/*")
public class PerformanceController {

	@Inject
	private PerformanceService perfService;

	// 메인 페이지 (실적 코드 목록)
	@GetMapping("/perf")
	public String perf(Model model, HttpServletRequest request, PerformanceDTO perfDTO, PageDTO pageDTO) {

		String cntPerPageParam = request.getParameter("cntPerPage");
		// <----------------------------------->
		// 한 화면에 보여줄 글 개수
		int pageSize = 10;
		if (cntPerPageParam != null && !cntPerPageParam.isEmpty()) {
			try {
				int cntPerPage = Integer.parseInt(cntPerPageParam);
				pageSize = cntPerPage;
			} catch (NumberFormatException e) {
				// 정수 변환이 실패한 경우 기본값 사용
				// 사용자에게 오류 메시지 표시 또는 기본값 설정 등의 처리를 추가할 수 있음
			}
		}
		// 현재 페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		// 페이지 번호가 없을 경우에는 1로 설정
		if (pageNum == null) {
			pageNum = "1";
		}

		// 페이지 번호를 정수로 변환
		int currentPage = Integer.parseInt(pageNum);
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);

		int count;
		int pageBlock = 5;
		// 시작하는 페이지 번호
		int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
		// 끝나는 페이지 번호
		int endPage = startPage + pageBlock - 1;

		List<PerformanceDTO> perflist;

		if (perfDTO.getLineCode() != null || perfDTO.getProdCode() != null) {

			count = perfService.getSearchcount(perfDTO);

			perflist = perfService.getSearch(perfDTO, pageDTO);

			log.debug("검색 조건이 있는 경우 - perflist: " + perflist);
			log.debug("검색 조건이 있는 경우 - count: " + count);
		} else {
			count = perfService.getperfCount(pageDTO);
			perflist = perfService.getperflist(pageDTO);

			log.debug("검색 조건이 없는 경우 - perflist: " + perflist);
			log.debug("검색 조건이 없는 경우 - count: " + count);
		}

		// 전체 페이지 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);

		log.debug("PerformanceController - 메인 페이지 요청");
		log.debug("실적 코드 목록: " + perflist);
		log.debug("실적 코드 카운트: " + count);

		model.addAttribute("perflist", perflist);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("perfDTO", perfDTO);

		return "perf/perf";
	}

	// 실적 추가 페이지
	@GetMapping("/perfinsert")
	public String perfInsert(Model model) {

		log.debug("PerformanceController - 실적 추가 페이지 요청");

		return "perf/perfinsert";
	}

	// 생산 라인 목록 조회
	@GetMapping("/linelist")
	public String linelist(Model model) {

		log.debug("팝업창 linelist 요청 ");
		List<LineDTO> linelist = perfService.getlinelist();

		model.addAttribute("linelist", linelist);
		log.debug("라인 목록: " + linelist);

		return "perf/linelist";
	}

	// 제품 목록 조회
	@GetMapping("/prodlist")
	public String prodlist(Model model) {

		log.debug("팝업창 prodlist 요청 ");

		List<ProdDTO> prodlist = perfService.getprodList();
		model.addAttribute("prodlist", prodlist);
		log.debug("제품 목록: " + prodlist);

		return "perf/prodlist";
	}

	// 작업 지시 목록 조회
	@GetMapping("/worklist")
	public String worklist(Model model) {

		log.debug("작업 지시 목록 요청 ");

		List<WorkOrderDTO> worklist = perfService.getworkList();
		model.addAttribute("worklist", worklist);
		log.debug("작업 지시 목록: " + worklist);

		return "perf/worklist";
	}

	// 실적 상세 페이지
	@GetMapping("/detail")
	public String perfdetail(HttpServletRequest req, Model model, PerformanceDTO perfDTO, HttpSession session) {

		String perfCode = req.getParameter("perfCode");
		log.debug(perfCode);

		PerformanceDTO perfDTO1 = perfService.getdetail(perfCode);
		model.addAttribute("perfDTO", perfDTO1);

		// 세션에서 아이디 값을 가져옵니다. (예시: "userId"는 세션에 저장된 사용자 아이디 키)
		HttpSession session1 = req.getSession();
		session.setAttribute("EmpId", perfDTO.getPerfEmpId());

		return "perf/perfdetail";
	}
}
