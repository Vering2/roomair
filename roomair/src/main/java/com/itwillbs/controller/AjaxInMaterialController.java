package com.itwillbs.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.InMaterialDTO;
import com.itwillbs.service.InMaterialService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/inMaterial/*")
public class AjaxInMaterialController {
	/*
	 * AjaxInMaterialController: 이 클래스는 원자재 입고와 관련된 AJAX 요청을 처리하는 Spring MVC
	 * 컨트롤러입니다.
	 */

	@Inject
	private InMaterialService inMaterialService;
	/*
	 * 원자재 입고 리스트를 AJAX로 요청하는 엔드포인트입니다.
	 * 
	 * @param inMaterialDTO AJAX 요청으로부터 받은 원자재 입고 관련 검색 조건이 담긴 DTO.
	 * 
	 * @param request HTTP 요청 객체.
	 * 
	 * @return ResponseEntity<List<InMaterialDTO>> 원자재 입고 리스트를 JSON 형태로 반환합니다.
	 */
//--------------------------------------------------------------

//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	@RequestMapping(value = "/listSearch", method = RequestMethod.POST)
	public ResponseEntity<List<InMaterialDTO>> inMaterialList(InMaterialDTO inMaterialDTO, HttpServletRequest request) {
		System.out.println("입고번호" + inMaterialDTO.getInNum());
		System.out.println("원자재 품명" + inMaterialDTO.getRawName());
		System.out.println("거래처명" + inMaterialDTO.getClientCompany());
		System.out.println("입고 상태 " + inMaterialDTO.getInState());
		log.debug("호출한 곳");

		if ("".equals(inMaterialDTO.getInNum()) || "null".equals(inMaterialDTO.getInNum())
				|| inMaterialDTO.getInNum() == null) {
			System.out.println("입고 번호 변경");
			inMaterialDTO.setInNum("");
		}
		if ("".equals(inMaterialDTO.getRawName()) || "null".equals(inMaterialDTO.getRawName())
				|| inMaterialDTO.getRawName() == null) {
			System.out.println("원자재 이름(품명) 변경");
			inMaterialDTO.setRawName("");
		}
		if ("".equals(inMaterialDTO.getClientCompany()) || "null".equals(inMaterialDTO.getClientCompany())
				|| inMaterialDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			inMaterialDTO.setClientCompany("");
		}
		if ("".equals(inMaterialDTO.getInState()) || "null".equals(inMaterialDTO.getInState())
				|| inMaterialDTO.getInState() == null) {
			System.out.println("입고 상태 변경");
			inMaterialDTO.setInState("");
		} // ... (검색 조건에 따른 처리)

//		한페이지에서 보여지는 글개수 설정
		int pageSize = 10;

//		페이지 번호
		String pageNum = request.getParameter("pageNum");
//		패이지 번호가 없으면 1페이지 설정
		if (pageNum == null) {
			pageNum = "1";
		}
//		페이지 번호를 정수형 변경 
		int currentPage = Integer.parseInt(pageNum);
//		페이지 번호를 저장
		inMaterialDTO.setCurrentPage(currentPage);
		inMaterialDTO.setPageNum(pageNum);
		inMaterialDTO.setPageSize(pageSize);

//		검색어는 이미 outProductDTO에 담겨져있다

//		게시판 전체 글 개수 구하기

		List<InMaterialDTO> inMaterialList = inMaterialService.getInMaterialList(inMaterialDTO);

		int count = inMaterialService.getInMaterialListCount(inMaterialDTO);

//		한화면에 보여줄 페이지 개수 설정
		int pageBlock = 5;
//		시작하는 페이지 번호
//		currentPage 			pageBlock => startPage
//		1~10(0~9)/10 = 0		    10    => 0*10+1  => 1
//		11~20(10~19)/10 = 1			10    => 1*10+1  => 11
//		21~30(20~29)/10 = 2			10    => 2*10+1  => 21
		int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
//		끝나는 페이지 번호
//		startPage  pageBlock => endPage
//		1			10		 =>  10
//		2			10		 =>  20
//		3			10		 =>  30
//		계산한값 endPage 10 => 실제 페이지는 2 
		int endPage = startPage + pageBlock - 1;

//		전체페이지 구하기 
//		글개수 50 한화면에 보여줄 글 개수 10 => 페이지수 5
//		count%pageBlock == 0 ? count/pageBlock : count/pageBlock+1;
		int pageCount = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		inMaterialDTO.setCount(count);
		inMaterialDTO.setPageBlock(pageBlock);
		inMaterialDTO.setStartPage(startPage);
		inMaterialDTO.setEndPage(endPage);
		inMaterialDTO.setPageCount(pageCount);

//		페이징을 저장 후 마지막 outProductList의 마지막에 삽입 
		inMaterialList.add(inMaterialDTO);// 페이지 관련 정보 설정 및 검색

		ResponseEntity<List<InMaterialDTO>> entity = new ResponseEntity<>(inMaterialList, HttpStatus.OK);
		return entity;// 검색 결과와 페이징 정보를 JSON으로 반환
	}

//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	/*
	 * 원자재 입고 리스트를 엑셀로 다운로드하는 엔드포인트입니다.
	 * 
	 * @param inMaterialDTO 엑셀 다운로드를 위한 검색 조건이 담긴 DTO.
	 * 
	 * @param request HTTP 요청 객체.
	 * 
	 * @return ResponseEntity<List<InMaterialDTO>> 원자재 입고 리스트를 JSON 형태로 반환합니다.
	 */
	@RequestMapping(value = "/excel", method = RequestMethod.POST)
	public ResponseEntity<List<InMaterialDTO>> excelList(InMaterialDTO inMaterialDTO, HttpServletRequest request) {
		System.out.println("입고번호" + inMaterialDTO.getInNum());
		System.out.println("원자재 품명" + inMaterialDTO.getRawName());
		System.out.println("거래처명" + inMaterialDTO.getClientCompany());
		System.out.println("입고 상태 " + inMaterialDTO.getInState());
		log.debug("호출한 곳");

		if ("".equals(inMaterialDTO.getInNum()) || "null".equals(inMaterialDTO.getInNum())
				|| inMaterialDTO.getInNum() == null) {
			System.out.println("입고 번호 변경");
			inMaterialDTO.setInNum("");
		}
		if ("".equals(inMaterialDTO.getRawName()) || "null".equals(inMaterialDTO.getRawName())
				|| inMaterialDTO.getRawName() == null) {
			System.out.println("원자재 이름(품명) 변경");
			inMaterialDTO.setRawName("");
		}
		if ("".equals(inMaterialDTO.getClientCompany()) || "null".equals(inMaterialDTO.getClientCompany())
				|| inMaterialDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			inMaterialDTO.setClientCompany("");
		}
		if ("".equals(inMaterialDTO.getInState()) || "null".equals(inMaterialDTO.getInState())
				|| inMaterialDTO.getInState() == null) {
			System.out.println("입고 상태 변경");
			inMaterialDTO.setInState("");
		} // ... (검색 조건에 따른 처리)

		// 게시판 전체 글 개수 구하기
		List<InMaterialDTO> inMaterialList = inMaterialService.getExcelList(inMaterialDTO);
		ResponseEntity<List<InMaterialDTO>> entity = new ResponseEntity<>(inMaterialList, HttpStatus.OK);
		return entity; // 다운로드할 원자재 입고 리스트를 JSON으로 반환
	}

//	public String inMaterialUpdate(InMaterialDTO inMaterialDTO,HttpServletRequest request, HttpServletResponse response) {

//	페이지 세부정보 에서 출고처리 버튼
	/*
     * 원자재 입고를 업데이트하는 엔드포인트입니다.
     * 
     * @param inMaterialDTO 업데이트할 원자재 입고 정보가 담긴 DTO.
     * @param request HTTP 요청 객체.
     * @param response HTTP 응답 객체.
     * @return String 원자재 입고 업데이트 결과를 문자열로 반환합니다. ("success": 성공, "error1": 입고 개수 초과 등의 오류)
     */
	@PostMapping("/inMaterialUpdate")
	public String inMaterialUpdate(InMaterialDTO inMaterialDTO, HttpServletRequest request,
			HttpServletResponse response) {
//	public void inMaterialUpdate(InMaterialDTO inMaterialDTO,HttpServletRequest request, HttpServletResponse response) {
//		디비에 저장된 inMaterial2 		업데이트된 내용이 들어있는inMaterialDTO
		InMaterialDTO inMaterialDTO2 = inMaterialService.inMaterialContent(inMaterialDTO.getInNum());
		System.out.println("클라이언트에 저장된 내용" + inMaterialDTO);
		System.out.println("디비에 저장된 내용" + inMaterialDTO2);
//		발주의 수량을 넘어선 입고의 개수가 입력이 되면 
		if (inMaterialDTO.getInCount() < inMaterialDTO.getInCount()
				|| inMaterialDTO.getInCount() < inMaterialDTO2.getInCount()) {
			return "error1";
		}
//		저장된 재고의 개수와 출고할 개수를 비교해서 실행
//		if (inMaterialDTO2.getStockCount() >= (inMaterialDTO.getOutCount()-outProductDTO2.getOutCount()) && outProductDTO.getOutCount() != 0) {
		// sellState 변경
		if (inMaterialDTO.getInCount() < inMaterialDTO.getBuyCount()) {
			if (inMaterialDTO.getInCount() == 0) {
				inMaterialDTO.setInState("미입고");
			} else {
				inMaterialDTO.setInState("입고부족");
			}
		} else if (inMaterialDTO.getInCount() == inMaterialDTO.getBuyCount()) {
			inMaterialDTO.setInState("입고완료");
		}

		inMaterialService.updateInState(inMaterialDTO);

		// Timestamp를 Date로 변환
		Date currentDate = new Date();

		// Date를 원하는 형식의 문자열로 변환
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String current = dateFormat.format(currentDate);

		// 입고부족이 아니면 입고일세팅
		if (inMaterialDTO.getInDate() == null || "".equals(inMaterialDTO.getInDate())) {
			inMaterialDTO.setInDate(current);
			inMaterialService.updateInDate(inMaterialDTO);
		} else {
			inMaterialDTO.setInRedate(current);
			inMaterialService.updateInRedate(inMaterialDTO);
		}
		// 3차
		// 출고 테이블 출고개수 출고비고 업데이트 / 나중에 담당자도 업뎃 / 매출액 계산해서 업데이트
		inMaterialService.updateInMaterialContent(inMaterialDTO);

		// 4차
		// 재고 테이블에서 제품코드로 출고한만큼 개수 감소
		if (inMaterialDTO2.getInCount() < inMaterialDTO.getInCount()) {
			System.out.println("1 디비에 저장된 값 " + inMaterialDTO2.getInCount());
			System.out.println("2 디비에 저장된 값 " + inMaterialDTO2.getInCount());
			System.out.println("3 뺄 값 " + inMaterialDTO.getInCount());
			System.out.println("4 뺄 값 " + inMaterialDTO.getInCount());
			inMaterialDTO.setInCount(inMaterialDTO.getInCount() - inMaterialDTO2.getInCount());
			System.out.println("5 디비에 저장된 값 " + inMaterialDTO2.getInCount());
			System.out.println("6 디비에 저장된 값 " + inMaterialDTO2.getInCount());
			System.out.println("7 뺄 값 " + inMaterialDTO.getInCount());
			System.out.println("8 뺄 값 " + inMaterialDTO.getInCount());
			inMaterialService.updateWhseCount(inMaterialDTO);
		} // ... (입고 업데이트 관련 처리)
		return "success";// 입고 업데이트 결과 반환

	}

}
