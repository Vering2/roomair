package com.itwillbs.controller;

import javax.inject.Inject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/KDMajax/*")
public class KDMAjaxController {

	@Inject
	private ModalService modalservice;

	// 검색
	
	///////////////////////////////////////////////// modalprod////////////////////////////////////
	@GetMapping("modalprod")
	public ProdDTO modalprod(@RequestParam("prodCode") String prodCode) throws Exception {
	return modalservice.modalprod(prodCode);
	}
	
///////////////////////////////////////////////// modalraw////////////////////////////////////
@GetMapping("modalraw")
public RawmaterialsDTO modalraw(@RequestParam("rawCode") String rawCode) throws Exception {
return modalservice.modalraw(rawCode);
	}
///////////////////////////////////////////////// modalsell////////////////////////////////////
@GetMapping("modalsell")
public SellDTO modalsell(@RequestParam("sellCode") String sellCode) throws Exception {
return modalservice.modalsell(sellCode);
	}
///////////////////////////////////////////////// modalworkinfo////////////////////////////////////
@GetMapping("modalworkorder")
public WorkOrderDTO modalinfo(@RequestParam("workCode") String workCode) throws Exception {
return modalservice.modalworkinfo(workCode);
}

@GetMapping("modalclient")
public ClientDTO modalclient(@RequestParam("clientCode") String clientCode) throws Exception {
return modalservice.modalclient(clientCode);
}

@GetMapping("modalwhse")
public WarehouseDTO modalwhse(@RequestParam("whseCode") String whseCode) throws Exception {
return modalservice.modalwhse(whseCode);
}

@GetMapping("modalemp")
public EmployeesDTO modalemp(@RequestParam("empId") String empId) throws Exception {
return modalservice.modalemp(empId);
	}

}