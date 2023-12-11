package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.service.PerformanceService;

import lombok.extern.slf4j.Slf4j;

/*
 * AjaxPerformanceController: 이 클래스는 성능과 관련된 Ajax 요청을 처리하는 Spring MVC 컨트롤러입니다.
 */

@RestController
@Slf4j
@RequestMapping("/perfajax")
public class AjaxPerformanceController {

    @Inject
    PerformanceService perfService;

    /*
     * 특정 성능 데이터를 삭제하는 메서드입니다.
     * 
     * @param perfCode 삭제할 성능 코드
     * @return ResponseEntity<String> 삭제 결과에 대한 응답
     */
    @PostMapping("/delete")
    public ResponseEntity<String> perfdelete(@RequestParam("perfCode") String perfCode) {

        log.debug("perfDelete 요청");

        // 삭제 로직 수행
        boolean success = perfService.perfdelete(perfCode);

        if (success) {
            return ResponseEntity.ok("삭제 성공");
        } else {
            return ResponseEntity.status(500).body("삭제 실패"); // 실패 응답, 500은 서버 오류 코드
        }
    }

    /*
     * 도넛 차트 데이터를 가져오는 메서드입니다.
     * 
     * @param lineCode 라인 코드 목록
     * @return ResponseEntity<List<PerformanceDTO>> 도넛 차트 데이터 목록에 대한 응답
     */
    @PostMapping("/perfdonut")
    public ResponseEntity<List<PerformanceDTO>> getdonut(@RequestBody List<String> lineCode) {
        System.out.println("Line Codes: " + lineCode);
        List<PerformanceDTO> getdonutdata = perfService.getdonut(lineCode);
        log.debug("가져오는값:" + lineCode);
        return ResponseEntity.ok(getdonutdata);
    }

    /*
     * 성능 데이터를 업데이트하는 메서드입니다.
     * 
     * @param perfDTO 업데이트할 성능 데이터를 담고 있는 PerformanceDTO 객체
     * @return String 업데이트 결과를 나타내는 문자열 ("true" 또는 "false")
     */
    @PostMapping("/updatePro")
    public String perfupdate(PerformanceDTO perfDTO) {
        System.out.println("실적 업데이트 데이터 " + perfDTO);

        // 서버에서 받아오는 값
        PerformanceDTO perfDTO2 = perfService.getdetail(perfDTO.getPerfCode());

        System.out.println("받아온 데이터" + perfDTO2);

        // 같아도 해주는 이유는 다른 정보를 업뎃할 수 있어서
        if (perfDTO2.getPerfFair() <= perfDTO.getPerfFair()) {
            int realFair = perfDTO.getPerfFair() - perfDTO2.getPerfFair();

            System.out.println("실제 양품수 " + realFair);
            perfDTO.setPerfFair(realFair); // 실제 양품수 세팅
            int result1 = perfService.updateperf(perfDTO); // 실적 테이블 세팅
            int result2 = perfService.updateStock(perfDTO); // 스톡 테이블 세팅

            if (result1 > 0 && result2 > 0) {
                return "true";
            } else {
                return "false";
            }
        } else {
            // 양품수가 줄었을 경우
            int realFair = perfDTO2.getPerfFair() - perfDTO.getPerfFair(); // 디비 50 - 받아온거 40 나머지 10
            System.out.println("실제 양품수 " + realFair);
            perfDTO.setPerfFair(realFair); // 실제 양품수 세팅
            int result1 = perfService.updateperfSub(perfDTO); // 실적 테이블 세팅
            int result2 = perfService.updateStockSub(perfDTO); // 스톡 테이블 세팅

            if (result1 > 0 && result2 > 0) {
                return "true";
            } else {
                return "false";
            }
        }
    }
}
