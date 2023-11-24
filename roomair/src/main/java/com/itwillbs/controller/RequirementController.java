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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.service.RequirementService;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementList;
import com.itwillbs.domain.RequirementPageDTO;
import com.mysql.cj.Session;

@Controller
@RequestMapping(value = "/requirement/*")
public class RequirementController {

	// 서비스 객체 주입
	@Autowired
	private RequirementService service;

	private static final Logger logger = LoggerFactory.getLogger(RequirementController.class);
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String requirementmain() {
		
		return "redirect:/requirement/reqDetail";
	}

	// ======================================================================================

	/*
	 * @RequestMapping(value = "NewFile") public void name() {
	 * 
	 * }
	 */
	// 소요량관리
	// http://localhost:8088/requirement/reqdetail
	@RequestMapping(value = "/reqDetail", method = RequestMethod.GET)
	public String requirementGET(Model model, RequirementDTO dto, RequirementPageDTO pdto,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) throws Exception {

		logger.debug("requirementGET() 호출");
		List<RequirementDTO> reqs = new ArrayList<RequirementDTO>();
		model.addAttribute("reqs", reqs);
		logger.debug("DTO : " + dto);
		

		if (dto.getReqCode() != null || dto.getProdCode() != null || dto.getRawCode() != null) {

			logger.debug("if문 호출");
			logger.debug("DTO : " + dto);
			logger.debug("DTO : " + pdto);
			System.out.println(dto);
			int total = service.countReq(dto);
			logger.debug("DTO : " + pdto);

			pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
			List<RequirementDTO> list = service.getReqList(dto, pdto);
			model.addAttribute("reqList", list);
			model.addAttribute("paging", pdto);
			model.addAttribute("dto", dto);
			logger.debug("pdto : " + pdto);
			logger.debug("DTO : " + dto);

			logger.debug("검색 리스트 가져감");

		} else {
			logger.debug("else문 호출");
			int total = service.countReq();
			pdto = new RequirementPageDTO(total);
			logger.debug("pdto : " + pdto);
			List<RequirementDTO> list = service.getReqList(pdto);
			model.addAttribute("reqList", list);
			model.addAttribute("paging", pdto);
			logger.debug(" 모든 리스트 가져감");
		}
		return "requirement/requirement";

	}

	// 소요량관리 추가 시 code 값 가져가기
	@ResponseBody
	@RequestMapping(value = "/reqCode", method = RequestMethod.GET)
	public String getReqCode() {
		logger.debug(" getReqCode() 호출 ");

		return service.getReqCode();
	}

	// 소요량관리 정보 추가
	@ResponseBody
	  @RequestMapping(value = "/reqAdd", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String requirementPOST(RequirementList reqs) throws Exception {
		  
		int findCode = 0;
		findCode = service.findCode(reqs.getReqs());
		String result="";

		if (findCode > 0) {
			System.out.println("존재");
			result="존재";
		        return result;
		    }  // 저장 작업 수행
		  logger.debug("requirementPOST() 호출");
		  logger.debug("reqs : " + reqs.getReqs());
		  service.insertReq(reqs.getReqs());
		  System.out.println("성공");
		  result="성공";
		    // 성공 응답 반환
		    return result;	
	  }
	 

	// 소요량관리 정보 삭제
	@RequestMapping(value = "/requirementDelete", method = RequestMethod.POST)
	public String deleteRequirement(@RequestParam(value = "checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteRequirement() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);

		// 서비스 - 소요량관리 삭제
		service.removeReq(checked);

		return "redirect:/requirement/reqDetail";
	} // deleteRequirement()

	// 소요량관리 조회 POST
	@ResponseBody
	@RequestMapping(value = "/reqOne", method = RequestMethod.POST)
	public RequirementDTO getreq(@RequestBody RequirementDTO dto) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getreq() 호출");
		logger.debug("@@@@@ CONTROLLER: req_Code = " + dto.getReqCode());

		// 서비스 - 소요량관리 정보 가져오기
		RequirementDTO preDTO = service.getReq(dto.getReqCode());
		logger.debug("@@@@@ CONTROLLER: preDTO = " + preDTO);

		return preDTO;
	} // getProd()

	// 소요량관리 수정
	@RequestMapping(value = "/reqModify", method = RequestMethod.POST)
	public String modifyreq(RequirementDTO uDTO) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyreq() 호출");
		logger.debug("@@@@@ CONTROLLER: uDTO = " + uDTO);

		// 서비스 - 소요량관리 수정
		service.modifyReq(uDTO);

		return "redirect:/requirement/reDetail";
	}
	
	// 엑셀 다운
	@RequestMapping(value = "/reqExcel", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> getReqExcel(RequirementDTO dto) throws Exception {

		logger.debug("getReqExcel() 호출");
		
		List<Map<String, Object>> list = null; // 리스트 초기화

		if (dto.getReqCode() != null || dto.getProdCode() != null || dto.getRawCode() != null) {

			logger.debug("if문 호출");
			logger.debug("DTO : " + dto);
			System.out.println(dto);

			list = service.getSearchExcelReqList(dto);

			logger.debug("검색 리스트 가져감");

		} else {
			logger.debug("else문 호출");
			list = service.getExcelReqList();
			logger.debug(" 모든 리스트 가져감");
		}
		
		ResponseEntity<List<Map<String, Object>>> entity = new ResponseEntity<>(list, HttpStatus.OK);
		
		return entity;

	}
	
}// RequirementController
