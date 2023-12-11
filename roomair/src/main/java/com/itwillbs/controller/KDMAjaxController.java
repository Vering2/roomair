package com.itwillbs.controller;

import javax.inject.Inject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.ModalService;

/*
 * KDMAjaxController: KDM 관련 Ajax 요청을 처리하는 Spring MVC RestController입니다.
 */

@RestController
@RequestMapping("/KDMajax/*")
public class KDMAjaxController {

    @Inject
    private ModalService modalservice;

    /*
     * 제품 정보를 조회하는 메서드입니다.
     * 
     * @param prodCode 조회할 제품 코드
     * @return ProdDTO 제품 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalprod")
    public ProdDTO modalprod(@RequestParam("prodCode") String prodCode) throws Exception {
        return modalservice.modalprod(prodCode);
    }

    /*
     * 원자재 정보를 조회하는 메서드입니다.
     * 
     * @param rawCode 조회할 원자재 코드
     * @return RawmaterialsDTO 원자재 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalraw")
    public RawmaterialsDTO modalraw(@RequestParam("rawCode") String rawCode) throws Exception {
        return modalservice.modalraw(rawCode);
    }

    /*
     * 판매 정보를 조회하는 메서드입니다.
     * 
     * @param sellCode 조회할 판매 코드
     * @return SellDTO 판매 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalsell")
    public SellDTO modalsell(@RequestParam("sellCode") String sellCode) throws Exception {
        return modalservice.modalsell(sellCode);
    }

    /*
     * 작업지시 정보를 조회하는 메서드입니다.
     * 
     * @param workCode 조회할 작업지시 코드
     * @return WorkOrderDTO 작업지시 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalworkorder")
    public WorkOrderDTO modalinfo(@RequestParam("workCode") String workCode) throws Exception {
        return modalservice.modalworkinfo(workCode);
    }

    /*
     * 거래처 정보를 조회하는 메서드입니다.
     * 
     * @param clientCode 조회할 거래처 코드
     * @return ClientDTO 거래처 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalclient")
    public ClientDTO modalclient(@RequestParam("clientCode") String clientCode) throws Exception {
        return modalservice.modalclient(clientCode);
    }

    /*
     * 창고 정보를 조회하는 메서드입니다.
     * 
     * @param whseCode 조회할 창고 코드
     * @return WarehouseDTO 창고 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalwhse")
    public WarehouseDTO modalwhse(@RequestParam("whseCode") String whseCode) throws Exception {
        return modalservice.modalwhse(whseCode);
    }

    /*
     * 직원 정보를 조회하는 메서드입니다.
     * 
     * @param empId 조회할 직원 ID
     * @return EmployeesDTO 직원 정보 객체
     * @throws Exception 예외 발생 시
     */
    @GetMapping("modalemp")
    public EmployeesDTO modalemp(@RequestParam("empId") String empId) throws Exception {
        return modalservice.modalemp(empId);
    }

}
