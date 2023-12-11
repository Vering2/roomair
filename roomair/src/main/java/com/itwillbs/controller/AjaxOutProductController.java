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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.OutProductDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.service.OutProductService;
/*
 * AjaxOutProductController: 이 클래스는 출고와 관련된 Ajax 요청을 처리하는 Spring MVC 컨트롤러입니다.
 */

@RestController
@RequestMapping("/outProduct/*")
public class AjaxOutProductController {

	@Inject
	private OutProductService outProductService;
	 /*
     * 출고 리스트를 조회하는 메서드입니다.
     * 
     * @param outProductDTO 출고 정보를 담은 DTO
     * @param request       HTTP 요청 객체
     * @return ResponseEntity<List<OutProductDTO>> 출고 리스트에 대한 응답
     */
//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	@RequestMapping(value = "/listSearch", method = RequestMethod.POST)
	public ResponseEntity<List<OutProductDTO>> outProductList(OutProductDTO outProductDTO, HttpServletRequest request) {
		System.out.println("출고코드" + outProductDTO.getOutCode());
		System.out.println("제품이름" + outProductDTO.getProdName());
		System.out.println("거래처이름" + outProductDTO.getClientCompany());
		System.out.println("거래 상태 " + outProductDTO.getSellState());

		if ("".equals(outProductDTO.getOutCode()) || "null".equals(outProductDTO.getOutCode())
				|| outProductDTO.getOutCode() == null) {
			System.out.println("출고 코드 변경");
			outProductDTO.setOutCode("");
		}
		if ("".equals(outProductDTO.getProdName()) || "null".equals(outProductDTO.getProdName())
				|| outProductDTO.getProdName() == null) {
			System.out.println("제품 이름 변경");
			outProductDTO.setProdName("");
		}
		if ("".equals(outProductDTO.getClientCompany()) || "null".equals(outProductDTO.getClientCompany())
				|| outProductDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			outProductDTO.setClientCompany("");
		}
		if ("".equals(outProductDTO.getSellState()) || "null".equals(outProductDTO.getSellState())
				|| outProductDTO.getSellState() == null) {
			System.out.println("출고 상태");
			outProductDTO.setSellState("");
		}

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
		outProductDTO.setCurrentPage(currentPage);
		outProductDTO.setPageNum(pageNum);
		outProductDTO.setPageSize(pageSize);

//		검색어는 이미 outProductDTO에 담겨져있다

//		게시판 전체 글 개수 구하기

		List<OutProductDTO> outProductList = outProductService.getOutProductList(outProductDTO);

		int count = outProductService.getOutProductListCount(outProductDTO);

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

		outProductDTO.setCount(count);
		outProductDTO.setPageBlock(pageBlock);
		outProductDTO.setStartPage(startPage);
		outProductDTO.setEndPage(endPage);
		outProductDTO.setPageCount(pageCount);

//		페이징을 저장 후 마지막 outProductList의 마지막에 삽입 
		outProductList.add(outProductDTO);

		ResponseEntity<List<OutProductDTO>> entity = new ResponseEntity<>(outProductList, HttpStatus.OK);
		return entity;
	}
	  /*
     * 출고 리스트를 엑셀로 다운로드하는 메서드입니다.
     * 
     * @param outProductDTO 출고 정보를 담은 DTO
     * @return ResponseEntity<List<OutProductDTO>> 출고 리스트에 대한 응답
     */
//	OutProductController 에서 페이지 이동을 하고 ajaxcontroller에서 리스트 불러오는것
	@RequestMapping(value = "/excel", method = RequestMethod.POST)
	public ResponseEntity<List<OutProductDTO>> excelList(OutProductDTO outProductDTO) {
		System.out.println("출고코드" + outProductDTO.getOutCode());
		System.out.println("제품이름" + outProductDTO.getProdName());
		System.out.println("거래처이름" + outProductDTO.getClientCompany());
		System.out.println("거래 상태 " + outProductDTO.getSellState());

		if ("".equals(outProductDTO.getOutCode()) || "null".equals(outProductDTO.getOutCode())
				|| outProductDTO.getOutCode() == null) {
			System.out.println("출고 코드 변경");
			outProductDTO.setOutCode("");
		}
		if ("".equals(outProductDTO.getProdName()) || "null".equals(outProductDTO.getProdName())
				|| outProductDTO.getProdName() == null) {
			System.out.println("제품 이름 변경");
			outProductDTO.setProdName("");
		}
		if ("".equals(outProductDTO.getClientCompany()) || "null".equals(outProductDTO.getClientCompany())
				|| outProductDTO.getClientCompany() == null) {
			System.out.println("거래처 이름 변경");
			outProductDTO.setClientCompany("");
		}
		if ("".equals(outProductDTO.getSellState()) || "null".equals(outProductDTO.getSellState())
				|| outProductDTO.getSellState() == null) {
			System.out.println("거래처 이름 변경");
			outProductDTO.setSellState("");
		}

//		게시판 전체 글 개수 구하기
		List<OutProductDTO> outProductList = outProductService.getExcelList(outProductDTO);

		System.out.println("엑셀 출력 데이터 " + outProductList);
		ResponseEntity<List<OutProductDTO>> entity = new ResponseEntity<>(outProductList, HttpStatus.OK);
		return entity;
	}
	   /*
     * 출고 정보를 업데이트하는 메서드입니다.
     * 
     * @param outProductDTO    업데이트할 출고 정보를 담은 DTO
     * @param request          HTTP 요청 객체
     * @param response         HTTP 응답 객체
     * @return String          업데이트 결과를 나타내는 문자열 ("success", "error1", "error2")
     */
//	페이지 세부정보 에서 출고처리 버튼
	@PostMapping("/outProductUpdate")
	public String outProductUpdate(OutProductDTO outProductDTO, HttpServletRequest request,
			HttpServletResponse response) {
//		디비에 저장된 outProductDTO2 		업데이트된 내용이 들어있는 outProductDTO
		OutProductDTO outProductDTO2 = outProductService.outProductContent(outProductDTO.getOutCode());
		System.out.println("클라이언트에 저장된 내용" + outProductDTO);
		System.out.println("디비에 저장된 내용" + outProductDTO2);
//		수주의 수량을 넘어선 출고의 개수가 입력이 되면 
		if (outProductDTO.getSellCount() < outProductDTO.getOutCount()
				|| outProductDTO.getOutCount() < outProductDTO2.getOutCount()) {
			return "error1";
		}
//		저장된 재고의 개수와 출고할 개수를 비교해서 실행
		if (outProductDTO2.getStockCount() >= (outProductDTO.getOutCount() - outProductDTO2.getOutCount())
				&& outProductDTO.getOutCount() != 0) {
			// sellState 변경
			if (outProductDTO.getOutCount() < outProductDTO.getSellCount()) {
				if (outProductDTO.getOutCount() == 0) {
					outProductDTO.setSellState("미출고");
				} else {
					outProductDTO.setSellState("중간납품");
				}
			} else if (outProductDTO.getOutCount() == outProductDTO.getSellCount()) {
				outProductDTO.setSellState("출고완료");
			}

			outProductService.updateSellState(outProductDTO);

			// Timestamp를 Date로 변환
			Date currentDate = new Date();

			// Date를 원하는 형식의 문자열로 변환
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String current = dateFormat.format(currentDate);

			// 중간납품이 아니면 출고일세팅
			if (outProductDTO.getOutDate() == null || "".equals(outProductDTO.getOutDate())) {
				outProductDTO.setOutDate(current);
				outProductService.updateOutDate(outProductDTO);
			} else {
				outProductDTO.setOutRedate(current);
				outProductService.updateOutRedate(outProductDTO);
			}
			// 3차 출고 테이블 출고개수 출고비고 업데이트 / 나중에 담당자도 업뎃 / 매출액 계산해서 업데이트
			outProductService.updateOutProductContent(outProductDTO);
			int price = (outProductDTO.getOutCount() - outProductDTO2.getOutCount())
					* (int) outProductDTO.getProdPrice();

			outProductDTO.setClientSale(price);
			outProductService.updateClientSale(outProductDTO);

			// 4차
			// 재고 테이블에서 제품코드로 출고한만큼 개수 감소
			if (outProductDTO2.getOutCount() < outProductDTO.getOutCount()) {
				System.out.println("1 디비에 저장된 값 " + outProductDTO2.getOutCount());
				System.out.println("2 디비에 저장된 값 " + outProductDTO2.getOutCount());
				System.out.println("3 뺄 값 " + outProductDTO.getOutCount());
				System.out.println("4 뺄 값 " + outProductDTO.getOutCount());
				outProductDTO.setOutCount(outProductDTO.getOutCount() - outProductDTO2.getOutCount());
				System.out.println("5 디비에 저장된 값 " + outProductDTO2.getOutCount());
				System.out.println("6 디비에 저장된 값 " + outProductDTO2.getOutCount());
				System.out.println("7 뺄 값 " + outProductDTO.getOutCount());
				System.out.println("8 뺄 값 " + outProductDTO.getOutCount());
				outProductService.updateWhseCount(outProductDTO);
			}
			return "success";
		} else {
			return "error2";
		}

	}
	 /*
     * 직원 정보를 조회하는 메서드입니다.
     * 
     * @param employeesDTO 조회할 직원 정보를 담은 DTO
     * @return EmployeesDTO 조회된 직원 정보에 대한 응답
     */
	@PostMapping("/outProductEmpInfo")
	public EmployeesDTO OutProductEmpInfo(EmployeesDTO employeesDTO) {
		System.out.println(employeesDTO);

		EmployeesDTO employeesDTO2 = outProductService.outProductEmpInfo(employeesDTO);

		return employeesDTO2;
	}
	 /*
     * 제품 정보를 조회하는 메서드입니다.
     * 
     * @param data 클라이언트로부터 전달된 데이터
     * @return ResponseEntity<ProdDTO> 조회된 제품 정보에 대한 응답
     */
	@RequestMapping(value = "/productInfo", method = RequestMethod.POST)
	public ResponseEntity<ProdDTO> getProductInfo(@RequestParam String data) {
		// data 변수에 클라이언트로부터 전달된 데이터가 들어옵니다.
		// 여기에서 data를 사용하여 필요한 서비스 호출 및 데이터 처리를 수행합니다.

		// 예시로, 받은 데이터를 그대로 응답으로 보내는 코드:
		ProdDTO prodDTO = outProductService.getProdInfo(data);

		ResponseEntity<ProdDTO> entity = new ResponseEntity<>(prodDTO, HttpStatus.OK);
		return entity;
	}

	@RequestMapping(value = "/clientInfo", method = RequestMethod.POST)
	public ResponseEntity<ClientDTO> getClientInfo(@RequestParam String data) {
		// data 변수에 클라이언트로부터 전달된 데이터가 들어옵니다.
		// 여기에서 data를 사용하여 필요한 서비스 호출 및 데이터 처리를 수행합니다.

		// 예시로, 받은 데이터를 그대로 응답으로 보내는 코드:
		ClientDTO clientDTO = outProductService.getClientInfo(data);

		ResponseEntity<ClientDTO> entity = new ResponseEntity<>(clientDTO, HttpStatus.OK);
		return entity;
	}

	@RequestMapping(value = "/rawMaterialInfo", method = RequestMethod.POST)
	public ResponseEntity<RawmaterialsDTO> getRawMaterialInfo(@RequestParam String data) {
		// data 변수에 클라이언트로부터 전달된 데이터가 들어옵니다.
		// 여기에서 data를 사용하여 필요한 서비스 호출 및 데이터 처리를 수행합니다.

		// 예시로, 받은 데이터를 그대로 응답으로 보내는 코드:
		RawmaterialsDTO rawmaterialsDTO = outProductService.getRawMaterialInfo(data);

		ResponseEntity<RawmaterialsDTO> entity = new ResponseEntity<>(rawmaterialsDTO, HttpStatus.OK);
		return entity;
	}

}
