package com.itwillbs.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.WorkOrderService;


@Controller
@RequestMapping(value = "/workorder/*")
public class WorkOrderController {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);
	
	//작업지시 service
	@Autowired
	private WorkOrderService wService;
	
	//작업지시 목록
	//http://localhost:8088/workorder/workOrderList
	@RequestMapping(value = "/workOrderList", method = RequestMethod.GET)
	public void workOrderListGET(RequirementPageDTO pdto,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
								@RequestParam HashMap<String, Object> search, 
								@RequestParam(value = "input", required = false) Object input, 
								Model model,HttpServletRequest request) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderListGET() 호출");
		System.out.println("@@@@@ CONTROLLER: search정보!!!!!!!!!!!!!!!" + search);
		System.out.println(pdto+"pdto 뭔데~~");
		
		List<WorkOrderDTO> workList = new ArrayList<>();
		
		//검색 있을 때
		if((search.get("search_line")!=null && !search.get("search_line").equals("")) || (search.get("search_fromDate")!=null && !search.get("search_fromDate").equals("")) || (search.get("search_toDate")!=null && !search.get("search_toDate").equals("")) 
				|| (search.get("search_place")!=null && !search.get("search_place").equals("")) || (search.get("search_prod")!=null && !search.get("search_prod").equals(""))) {
			
			logger.debug("@@@@@ CONTROLLER: 검색 service 호출");
			
			
			logger.debug("@@@@@ CONTROLLER: 검색 결과 수 = " + wService.getSearchWorkOrder(search));
			int total = wService.getSearchWorkOrder(search);
			pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
			search.put("start", pdto.getStart());
			search.put("cntPerPage", pdto.getCntPerPage());
			//서비스 - 작업지시 검색
			workList = wService.searchWorkOrder(search);
			logger.debug("@@@@@ CONTROLLER: 검색결과list = " + workList);
			
			model.addAttribute("search", search);
			model.addAttribute("workList", workList);
			model.addAttribute("paging", pdto);
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@ CONTROLLER: input 정보 전달");
			}
			
		} //if(검색)
		//검색 없을 때
		else {
			
			logger.debug("@@@@@ CONTROLLER: 전체 작업지시 수 = " + wService.getTotalWorkOrder());
			
			int total = wService.getSearchWorkOrder(search);
			pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
			
			workList = wService.getAllWorkOrder(pdto);
			
			model.addAttribute("workList", workList);
			model.addAttribute("paging",pdto);
			model.addAttribute("search",search);
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@ CONTROLLER: input 정보 전달");
			}
		} //else(모든)
		
	} //workOrderListGET()
	
	
	//라인코드 - 처음 등록할 때 1차공정 라인 중 사용가능한 라인 하나
	@ResponseBody
	@RequestMapping(value = "/getLine", method = RequestMethod.POST)
	public String getLine(Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getLine() 호출");
		
		return wService.getLineCode();
	} //getLine()
	
	
	//라인, 품목, 수주 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String popUpGET(Model model, @RequestParam("type") String type, 
			@RequestParam("input") String input) throws Exception {
		logger.debug("@@@@@ CONTROLLER: popUpGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);
		
		
		if(type.equals("line")) {
			return "redirect:/performance/line?input="+input;
		}
		
		else if(type.equals("prod")) {
			return "redirect:/performance/product?input="+input;
		}
		
		else if(type.equals("client")) {
			return "redirect:/person/Clients?input="+input;
		}
		
		else if(type.equals("client_p")) {
			String state = URLEncoder.encode("수주처", "UTF-8");
			return "redirect:/person/Clients?input="+input+"&search_client_type="+state;
		}
		else if(type.equals("client_r")) {
			String state = URLEncoder.encode("발주처", "UTF-8");
			return "redirect:/person/Clients?input="+input+"&search_client_type="+state;
		}
		
		else if(type.equals("wh")) {
			return "redirect:/performance/warehouse?input="+input;
		}
		
		else if(type.equals("wh_p")) {
			String state = URLEncoder.encode("완제품", "UTF-8");
			return "redirect:/performance/warehouse?input="+input+"&wh_dv="+state;
		}
		else if(type.equals("wh_r")) {
			String state = URLEncoder.encode("원자재", "UTF-8");
			return "redirect:/performance/warehouse?input="+input+"&wh_dv="+state;
		}
		
		else if(type.equals("emp")) {
			return "redirect:/person/empinfo?input="+input;
		}
		
		else /* if(type.equals("order"))*/ {
			return "redirect:/person/orderStatus?input="+input;
		}
		
		
	} //popUpGET()
		
	//작업지시 추가
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addWorkOrder(WorkOrderDTO dto, Model model,HttpServletRequest request) throws Exception {
		logger.debug("@@@@@ CONTROLLER: addWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: dto = " + dto);
HttpSession session = request.getSession();
        
/*
 * // 세션에서 아이디 값을 가져옵니다. (예시: "userId"는 세션에 저장된 사용자 아이디 키) String empId =
 * (String) session.getAttribute("empId");
 * 
 * dto.setWorkEmpId(empId);
 */
		//서비스 - 작업지시 등록
		wService.regWorkOrder(dto);
		
		return "redirect:/workorder/workOrderList";
	} //addWorkOrder()
	
	//작업지시 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteWorkOrder(@RequestParam(value="checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);
		
		//서비스 - 작업지시 삭제 
		wService.removeWorkOrder(checked);
		
		return "redirect:/workorder/workOrderList";
	} //deleteWorkOrder()
	
	//작업지시 조회 POST
	@ResponseBody
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public WorkOrderDTO getWorkOrder(@RequestBody WorkOrderDTO dto) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrder/detail() 호출");
		logger.debug("@@@@@ CONTROLLER: workCode = " + dto.getWorkCode());
		
		//서비스 - 작업지시 정보 가져오기
		WorkOrderDTO preDTO = wService.getWorkOrder(dto.getWorkCode());
		logger.debug("@@@@@ CONTROLLER: preDTO = " + preDTO);
		
		return preDTO;
	} //getWorkOrder()
	
	//작업지시 수정 
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyWorkOrder(WorkOrderDTO udto, Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyWorkOrder() 호출");
		
		//서비스 - 작업지시 수정
		model.addAttribute("woModify", wService.modifyWorkOrder(udto));
		
		return "redirect:/workorder/workOrderList";
	} //modifyWorkOrder()
	
	//작업지시 현재 작업 공정 변경
//	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	public String updateStatus(WorkOrderDTO dto) throws Exception {
		logger.debug("@@@@@ CONTROLLER: updateStatus() 호출");
		logger.debug("@@@@@ CONTROLLER: dto  = = = = = = > > > " + dto);
		String lineCode = wService.modifyStatus(dto);
		System.out.println("lineCode는"+lineCode);
		return lineCode;
	} //updateStatus()
	
	
	//작업지시 추가
		@RequestMapping(value = "/checkStock", method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> checkStock(WorkOrderDTO dto, Model model) throws Exception {
			logger.debug("@@@@@ CONTROLLER: checkStock() 호출");
			logger.debug("@@@@@ CONTROLLER: dto = " + dto);
			Map<String, Object> response = new HashMap<>();
			try {
	            List<RawmaterialsDTO> shortages = wService.checkStock(dto);
	            System.out.println(shortages+"shortages뭔값일까");
	            response.put("status", "success");
	            response.put("data", shortages);
	            System.out.println(response);
	            
	        } catch (Exception e) {
	            response.put("status", "error");
	            response.put("message", "부족한 원자재 정보를 가져오는데 실패했습니다.");
	        }
		
			return ResponseEntity.ok(response);
		} //addWorkOrder()
		
	@PostMapping("/workOrderExcel")
	public ResponseEntity<List<Map<String,Object>>> getWorkOrderExcel(@RequestBody HashMap<String, Object> searchParams) {
		System.out.println(searchParams);
		System.out.println(searchParams);
		System.out.println(searchParams);
		List<Map<String,Object>> list = null;
		System.out.println("엑셀 다운 ");
		System.out.println("엑셀 다운 ");
	   //검색 있을 때
		if((searchParams.get("searchLine")!=null && !searchParams.get("searchLine").equals("")) || (searchParams.get("fromDate")!=null && !searchParams.get("fromDate").equals("")) || (searchParams.get("toDate")!=null && !searchParams.get("toDate").equals("")) 
				|| (searchParams.get("place")!=null && !searchParams.get("place").equals("")) || (searchParams.get("prod")!=null && !searchParams.get("prod").equals(""))) {
			
			System.out.println("엑셀 다운 1");
			
			list = wService.getWorkOrderSearchExcel(searchParams);
			//서비스 - 작업지시 검색
			
		} //if(검색)
		//검색 없을 때
		else {
			System.out.println("엑셀 다운 2");
			list = wService.getWorkOrderAllExcel();
			
		} //else(모든)
		ResponseEntity<List<Map<String,Object>>> entity = new ResponseEntity<>(list,HttpStatus.OK);
			
		return entity;
	}
} //WorkOrderController
