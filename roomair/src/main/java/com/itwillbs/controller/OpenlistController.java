package com.itwillbs.controller;

import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.service.OpenlistService;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementList;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.mysql.cj.Session;

@Controller
@RequestMapping(value = "/search/*")
public class OpenlistController {

	// 서비스 객체 주입
	@Autowired
	private OpenlistService service;

	private static final Logger logger = LoggerFactory.getLogger(OpenlistController.class);
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String popUpGET(@RequestParam("input") String input, @RequestParam("type") String type, @RequestParam(value = "type2", required = false) String type2) throws Exception {

		logger.debug("@#@#@# C : popUpGET() 호출 @#@#@#");
		logger.debug("@#@#@# C : type = " + type);

		if (type.equals("prod")) { 
			return "redirect:/search/product?input="+input; }
		

		else if (type.equals("raw")) {
			return "redirect:/search/rawmaterial?input=" + input;
		}
		
		else if (type.equals("client")) {
			return "redirect:/search/client?input=" + input;
		}
		else if (type.equals("sell")) {
			return "redirect:/search/sell?input=" + input;
		}
		else if (type.equals("whse")) {
			return "redirect:/search/whse?input=" + input;
		}
		else if (type.equals("buyclient")) {
			return "redirect:/search/buyclient?input=" + input;
		}
		else if (type.equals("sellclient")) {
			return "redirect:/search/sellclient?input=" + input;
		}
		else if (type.equals("emp")) {
			return "redirect:/search/emp?input=" + input + "&type2" + type2;
		}
		return "";

	}


	  
	  @RequestMapping(value = "/product", method = RequestMethod.GET)
	  public String productGET(Model model, ProdDTO dto, RequirementPageDTO pdto, 
	  
	  @RequestParam(value = "nowPage", required = false) String nowPage,
	  
	  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
	  
	  @RequestParam(value = "input", required = false) String input) throws
	  Exception {
	
	  
	  logger.debug("productGET() 호출");
	  List<ProdDTO> products = service.getProdList(pdto);
	  model.addAttribute("products", products);
	  logger.debug("DTO : " + dto);
	  logger.debug(" @@@@@@@@@@ input: " + input +  "@@@@@@@@@@@@@@@");
	  
	  if (dto.getProdCode() != null || dto.getProdName() != null) {
		  int total = service.countProd(dto);
	  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
	  List<ProdDTO> list = service.getProdList(dto, pdto);
	  model.addAttribute("prodList", list);
	  model.addAttribute("paging", pdto);
	  model.addAttribute("DTO", dto);
	  logger.debug("pdto : " + pdto);
	  logger.debug("DTO : " + dto);
	  logger.debug("검색 리스트 가져감");
	  
	  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
	  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	  
	  } else {
		  int total = service.countProd();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ProdDTO> list = service.getProdList(pdto);
		  model.addAttribute("prodList", list);
	  model.addAttribute("paging", pdto);
	  logger.debug(" 모든 리스트 가져감"); }
	  
	  return "openlist/productlist";
	  
	  }
	 
	// =====================================================================================

	
	  // 원자재목록 // http://localhost:8088/search/rawMaterial
	  
	  @RequestMapping(value = "/rawmaterial", method = RequestMethod.GET)
	  public String rawMaterialGET(Model model, RawmaterialsDTO dto, RequirementPageDTO pdto,
	  
	  @RequestParam(value = "nowPage", required = false) String nowPage,
	  
	  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
	  
	  @RequestParam(value = "input", required = false) String input) throws Exception {
	  
	  logger.debug("rawMaterialGET() 호출");
	  List<RawmaterialsDTO> raws = new ArrayList<RawmaterialsDTO>();
	  model.addAttribute("raws", raws);
	  logger.debug("DTO : " + dto);
	  
	  if (dto.getRawCode() != null || dto.getRawName() != null) {
	  
	  logger.debug("if문 호출"); int total = service.countRaw(dto);
	  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
	  List<RawmaterialsDTO> list = service.getRawList(dto, pdto);
	  model.addAttribute("rawList", list);
	  model.addAttribute("paging", pdto);
	  model.addAttribute("DTO", dto);
	  logger.debug("pdto : " + pdto);
	  logger.debug("DTO : " + dto);
	  
	  logger.debug("검색 리스트 가져감");
	  
	  // input 추가
	  if (input != null && !input.equals("")) {
	  model.addAttribute("input", input);
	  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	  }
	  else {
		  logger.debug("else문 호출");
	  int total = service.countRaw();
	  pdto = new RequirementPageDTO(total);
	  logger.debug("pdto : " + pdto);
	  List<RawmaterialsDTO> list = service.getRawList(pdto);
	  model.addAttribute("rawList", list);
	  model.addAttribute("paging", pdto);
	  logger.debug(" 모든 리스트 가져감"); }
	  return "openlist/rawmateriallist";
	  
	  }
	 

	// =====================================================================================

	  
	// 거래처목록 // http://localhost:8088/search/rawMaterial
	  
		  @RequestMapping(value = "/client", method = RequestMethod.GET)
		  public String clientGET(Model model, ClientDTO dto, RequirementPageDTO pdto,
		  
		  @RequestParam(value = "nowPage", required = false) String nowPage,
		  
		  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
		  
		  @RequestParam(value = "input", required = false) String input) throws Exception {
		  
		  logger.debug("clientGET() 호출");
		  List<ClientDTO> client = new ArrayList<ClientDTO>();
		  model.addAttribute("client", client);
		  logger.debug("DTO : " + dto);
		  
		  if (dto.getClientCode() != null || dto.getClientName() != null) {
		  
		  logger.debug("if문 호출"); int total = service.countClient(dto);
		  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
		  List<ClientDTO> list = service.getClientList(dto, pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  model.addAttribute("DTO", dto);
		  logger.debug("pdto : " + pdto);
		  logger.debug("DTO : " + dto);
		  
		  logger.debug("검색 리스트 가져감");
		  
		  // input 추가
		  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
		  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
		  }
		  else {
			  logger.debug("else문 호출");
		  int total = service.countClient();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ClientDTO> list = service.getClientList(pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  logger.debug(" 모든 리스트 가져감"); }
		  return "openlist/clientlist";
		  
		  }
		  
		// 거래처목록 // http://localhost:8088/search/rawMaterial
		  
		  @RequestMapping(value = "/buyclient", method = RequestMethod.GET)
		  public String buyclientGET(Model model, ClientDTO dto, RequirementPageDTO pdto,
		  
		  @RequestParam(value = "nowPage", required = false) String nowPage,
		  
		  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
		  
		  @RequestParam(value = "input", required = false) String input) throws Exception {
		  
		  logger.debug("clientGET() 호출");
		  List<ClientDTO> client = new ArrayList<ClientDTO>();
		  model.addAttribute("client", client);
		  logger.debug("DTO : " + dto);
		  
		  if (dto.getClientCode() != null || dto.getClientName() != null) {
		  
		  logger.debug("if문 호출"); int total = service.buycountClient(dto);
		  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
		  List<ClientDTO> list = service.buygetClientList(dto, pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  model.addAttribute("DTO", dto);
		  logger.debug("pdto : " + pdto);
		  logger.debug("DTO : " + dto);
		  
		  logger.debug("검색 리스트 가져감");
		  
		  // input 추가
		  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
		  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
		  }
		  else {
			  logger.debug("else문 호출");
		  int total = service.buycountClient();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ClientDTO> list = service.buygetClientList(pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  logger.debug(" 모든 리스트 가져감"); }
		  return "openlist/buyclientlist";
		  
		  }
		  
		// 거래처목록 // http://localhost:8088/search/rawMaterial
		  
		  @RequestMapping(value = "/sellclient", method = RequestMethod.GET)
		  public String sellclientGET(Model model, ClientDTO dto, RequirementPageDTO pdto,
		  
		  @RequestParam(value = "nowPage", required = false) String nowPage,
		  
		  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
		  
		  @RequestParam(value = "input", required = false) String input) throws Exception {
		  
		  logger.debug("clientGET() 호출");
		  List<ClientDTO> client = new ArrayList<ClientDTO>();
		  model.addAttribute("client", client);
		  logger.debug("DTO : " + dto);
		  
		  if (dto.getClientCode() != null || dto.getClientCompany() != null) {
		  
		  logger.debug("if문 호출"); int total = service.sellcountClient(dto);
		  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
		  List<ClientDTO> list = service.sellgetClientList(dto, pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  model.addAttribute("DTO", dto);
		  logger.debug("pdto : " + pdto);
		  logger.debug("DTO : " + dto);
		  
		  logger.debug("검색 리스트 가져감");
		  
		  // input 추가
		  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
		  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
		  }
		  else {
			  logger.debug("else문 호출");
		  int total = service.sellcountClient();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ClientDTO> list = service.sellgetClientList(pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  logger.debug(" 모든 리스트 가져감"); }
		  return "openlist/sellclientlist";
		  
		  }
		  
		  
		// =====================================================================================

		  
			// 수주목록 // http://localhost:8088/search/sell
			  
				  @RequestMapping(value = "/sell", method = RequestMethod.GET)
				  public String sellGET(Model model, SellDTO dto, RequirementPageDTO pdto,
				  
				  @RequestParam(value = "nowPage", required = false) String nowPage,
				  
				  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
				  
				  @RequestParam(value = "input", required = false) String input) throws Exception {
				  
				  logger.debug("sellGET() 호출");
				  List<SellDTO> sell = new ArrayList<SellDTO>();
				  model.addAttribute("sell", sell);
				  logger.debug("DTO : " + dto);
				  
				  if (dto.getSellCode() != null || dto.getClientCompany() != null) {
				  
				  logger.debug("if문 호출");
				  int total = service.countSell(dto);
				  System.out.println(total + "total개수");
				  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
				  List<SellDTO> list = service.getSellList(dto, pdto);
				  model.addAttribute("sellList", list);
				  model.addAttribute("paging", pdto);
				  model.addAttribute("DTO", dto);
				  logger.debug("pdto : " + pdto);
				  logger.debug("DTO : " + dto);
				  
				  logger.debug("검색 리스트 가져감");
				  
				  // input 추가
				  if (input != null && !input.equals("")) {
				  model.addAttribute("input", input);
				  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
				  }
				  else {
					  logger.debug("else문 호출");
				  int total = service.countSell();
				  pdto = new RequirementPageDTO(total);
				  logger.debug("pdto : " + pdto);
				  List<SellDTO> list = service.getSellList(pdto);
				  model.addAttribute("sellList", list);
				  model.addAttribute("paging", pdto);
				  logger.debug(" 모든 리스트 가져감"); }
				  return "openlist/selllist";
				  
				  }
				  
				  
				// 창고목록 // http://localhost:8088/search/rawMaterial
				  
				  @RequestMapping(value = "/whse", method = RequestMethod.GET)
				  public String whseGET(Model model, WarehouseDTO dto, RequirementPageDTO pdto,
				  
				  @RequestParam(value = "nowPage", required = false) String nowPage,
				  
				  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
				  
				  @RequestParam(value = "input", required = false) String input) throws Exception {
				  
				  logger.debug("whseGET() 호출");
				  List<WarehouseDTO> whse = new ArrayList<WarehouseDTO>();
				  model.addAttribute("whse", whse);
				  logger.debug("DTO : " + dto);
				  
				  if (dto.getWhseCode() != null || dto.getWhseName() != null) {
				  
				  logger.debug("if문 호출"); int total = service.countWhse(dto);
				  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
				  List<WarehouseDTO> list = service.getWhseList(dto, pdto);
				  model.addAttribute("whseList", list);
				  model.addAttribute("paging", pdto);
				  model.addAttribute("DTO", dto);
				  logger.debug("pdto : " + pdto);
				  logger.debug("DTO : " + dto);
				  
				  logger.debug("검색 리스트 가져감");
				  
				  // input 추가
				  if (input != null && !input.equals("")) {
				  model.addAttribute("input", input);
				  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
				  }
				  else {
					  logger.debug("else문 호출");
				  int total = service.countWhse();
				  pdto = new RequirementPageDTO(total);
				  logger.debug("pdto : " + pdto);
				  List<WarehouseDTO> list = service.getWhseList(pdto);
				  model.addAttribute("whseList", list);
				  model.addAttribute("paging", pdto);
				  logger.debug(" 모든 리스트 가져감"); }
				  return "openlist/whselist";
				  
				  }
				  
				  //////////////////////////////////////// LineList뽑아오기 
				  @RequestMapping(value = "/line", method = RequestMethod.GET)
				  public String lineGET(Model model, LineDTO dto, RequirementPageDTO pdto,
				  
				  @RequestParam(value = "nowPage", required = false) String nowPage,
				  
				  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
				  
				  @RequestParam(value = "input", required = false) String input) throws Exception {


			  
				  logger.debug("DTO : " + dto);
				  
				  int total = service.countline(dto);
				  System.out.println(total + "total개수");
				  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
				  
				  List<LineDTO> linelist = service.getlineList(pdto);
				  model.addAttribute("linelist", linelist);
				  model.addAttribute("paging", pdto);
				  model.addAttribute("DTO", dto);
				  logger.debug("pdto : " + pdto);
				  logger.debug("DTO : " + dto);
			 
				  return "openlist/linelist";
				  
				  }
				
				// 직원목록 // http://localhost:8088/search/emp
				  
				  @RequestMapping(value = "/emp", method = RequestMethod.GET)
				  public String empGET(Model model, EmployeesDTO dto, RequirementPageDTO pdto,
				  
				  @RequestParam(value = "nowPage", required = false) String nowPage,
				  
				  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
				  
				  @RequestParam(value = "input", required = false) String input,
				  
				  @RequestParam(value = "type2", required = false) String type2) throws Exception {
				  
					  
				  logger.debug("empGET() 호출");
				  List<EmployeesDTO> emp = new ArrayList<EmployeesDTO>();
				  model.addAttribute("emp", emp);
				  logger.debug("DTO : " + dto);
				  dto.setEmpDepartment(type2);
				 /* if (dto.getEmpId() != null || dto.getEmpName() != null) {
				 */ 
				  logger.debug("if문 호출");
				  int total = service.countEmp(dto);
				  System.out.println(total + "total개수");
				  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
				  
				  List<EmployeesDTO> list = service.getEmpList(dto, pdto);
				  model.addAttribute("empList", list);
				  model.addAttribute("paging", pdto);
				  model.addAttribute("DTO", dto);
				  logger.debug("pdto : " + pdto);
				  logger.debug("DTO : " + dto);
				  
				  logger.debug("검색 리스트 가져감");
				  
				  // input 추가
				  if (input != null && !input.equals("")) {
				  model.addAttribute("input", input);
				  model.addAttribute("dto", dto);
				  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
				/* } */
					/*
					 * else { logger.debug("else문 호출"); int total = service.countEmp(); pdto = new
					 * RequirementPageDTO(total); dto.setEmpDepartment(type2);
					 * logger.debug("pdto : " + pdto); List<EmployeesDTO> list =
					 * service.getEmpList(pdto); model.addAttribute("empList", list);
					 * model.addAttribute("paging", pdto); logger.debug(" 모든 리스트 가져감"); }
					 */				  return "openlist/emplist";
				  
				  }
				  
				  
				  /////////////////////////////////

					// 수주목록 // http://localhost:8088/search/sell

					  @RequestMapping(value = "/openworklist", method = RequestMethod.GET)
					  public String workGET(Model model, WorkOrderDTO dto, RequirementPageDTO pdto,

					  @RequestParam(value = "nowPage", required = false) String nowPage,

					  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,

					  @RequestParam(value = "input", required = false) String input) throws Exception {

					  logger.debug("workGET() 호출");
					  List<WorkOrderDTO> work = new ArrayList<WorkOrderDTO>();
					  model.addAttribute("work", work);
					  logger.debug("DTO : " + dto);

					  // 라인 수주 제품 코드
					  if (dto.getLineCode() != null  || dto.getProdName() != null ) {

					  logger.debug("if문 호출");
					  int total = service.countwork(dto);
					  System.out.println(total + "total개수");
					  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
					  List<WorkOrderDTO> worklist = service.getworklist(dto, pdto);
					  model.addAttribute("worklist", worklist);
					  model.addAttribute("paging", pdto);
					  model.addAttribute("DTO", dto);
					  logger.debug("pdto : " + pdto);
					  logger.debug("DTO : " + dto);

					  logger.debug("검색 리스트 가져감");

					  // input 추가
					  if (input != null && !input.equals("")) {
					  model.addAttribute("input", input);
					  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
					  }
					  else {
						  logger.debug("else문 호출");
					  int total = service.countwork();
					  pdto = new RequirementPageDTO(total);
					  logger.debug("pdto : " + pdto);
					  List<WorkOrderDTO> worklist = service.getworklist(pdto);
					  model.addAttribute("worklist", worklist);
					  model.addAttribute("paging", pdto);
					  logger.debug(" 모든 리스트 가져감"); }
					  return "openlist/openworklist";

					  }

				  

}// RequirementController
