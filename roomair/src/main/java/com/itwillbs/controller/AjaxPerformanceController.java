package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ChartDTO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.service.PerformanceService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/perfajax")
public class AjaxPerformanceController {

	@Inject
	PerformanceService perfService;

	@PostMapping("/delete")
	public ResponseEntity<String> perfdelete (@RequestParam("perfCode") String perfCode) {

		log.debug("perfDelete 요청");

		// 삭제 로직 수행
	    boolean success = perfService.perfdelete(perfCode);
	    System.out.println(success);

	    if (success) {
	        return ResponseEntity.ok("삭제 성공");
	    } else {
	        return ResponseEntity.status(500).body("삭제 실패"); // 실패 응답, 500은 서버 오류 코드
	    }
	}
	
	/*
	 * @PostMapping("/ajaxinsert") public ResponseEntity<String> ajaxinsert (
	 * PerformanceDTO perfDTO ) { log.debug("perfInsert요청");
	 * 
	 * boolean success = perfService.perfinsert(perfDTO);
	 * System.out.println(success); if (success) { return
	 * ResponseEntity.ok("등록 성공");
	 * 
	 * } else {
	 * 
	 * return ResponseEntity.status(500).body("등록 실패"); // 실패 응답, 500은 서버 오류 코드 } }
	 */
	
	@PostMapping("/perfdonut")
	public ResponseEntity<List<PerformanceDTO>> getdonut(@RequestBody List<String> lineCode) {
		 System.out.println("Line Codes: " + lineCode);
	    List<PerformanceDTO> getdonutdata = perfService.getdonut(lineCode);
	    log.debug("가져오는값:"+ lineCode);
	    return ResponseEntity.ok(getdonutdata);
	    

	}
	
	@PostMapping("/updatePro")
	public String perfupdate(PerformanceDTO perfDTO) {
		System.out.println("실적 업데이트 데이터 "+perfDTO);
		// 서버에서 받아오는 값 
		PerformanceDTO perfDTO2 = perfService.getdetail(perfDTO.getPerfCode());
		
		System.out.println("받아온 데이터" + perfDTO2);
		// 같아도 해주는 이유는 다른 정보를 업뎃할수있어서 
		if(perfDTO2.getPerfFair() <= perfDTO.getPerfFair()) {
			int realFair = perfDTO.getPerfFair() - perfDTO2.getPerfFair();
			
			System.out.println("실제 양품수 " + realFair);
			perfDTO.setPerfFair(realFair); // 실제 양품수 세팅 
			int result1 = perfService.updateperf(perfDTO); // 실적 테이블 세팅
			int result2 = perfService.updateStock(perfDTO); // 스톡 테이블 세팅
			if(result1 > 0 && result2 > 0) {
				return "true";
			}else {
				return "false";
			}
		}else {
			// 양품수가 줄었을 경우
			int realFair = perfDTO2.getPerfFair() - perfDTO.getPerfFair(); // 디비 50 - 받아온거 40 나머지 10 
			System.out.println("실제 양품수 " + realFair);
			perfDTO.setPerfFair(realFair); // 실제 양품수 세팅 
			int result1 = perfService.updateperfSub(perfDTO); // 실적 테이블 세팅
			int result2 = perfService.updateStockSub(perfDTO); // 스톡 테이블 세팅
			if(result1 > 0 && result2 > 0) {
				return "true";
			}else {
				return "false";
			}
			
		}
			
	
	}
}
	

	