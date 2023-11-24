package com.itwillbs.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.service.EmployeesService;

@Controller
@RequestMapping("/employees/*")
public class EmployeesController {
	
	@Inject
	private EmployeesService employeesService;
	
//	파일 업로드
	@Autowired
	private String uploadPath;

//	인사관리 홈
	@GetMapping("/employees")
	public String employees(HttpServletRequest request,Model model) {
		String search = request.getParameter("search");
		int pageSize = 10;
		String pageNum=request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		PageDTO pageDTO =new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		pageDTO.setSearch(search);
		List<EmployeesDTO> employeesList= employeesService.getEmployeesList(pageDTO);
		int count = employeesService.getEmployeesCount(pageDTO);
		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage + pageBlock -1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("employeesList", employeesList);
		return "employees/employees";	
	}
	
//	인사등록 홈
	@GetMapping("/employees2")
	public String employees2(Model model ) {	
		
//		     String newEmployeeId = employeesService.generateNewEmployeeId();
//		     
//		
//		    
//		    String empPass = newEmployeeId;
//		    
//	        model.addAttribute("empId", newEmployeeId);
//	        model.addAttribute("empPass", empPass);
	        
		return "employees/employees2";	
	}
	
//	인사등록
	@PostMapping("/insertPro")
	public String insertPro(HttpServletRequest request,EmployeesDTO employeesDTO, MultipartFile file) throws Exception{
		// 업로드 파일 있는지 없는지 파악
				if(file.isEmpty()) {
				    // 첨부파일 없는 경우
				    String oldfile = request.getParameter("oldfile");
				    if(oldfile == null || oldfile.isEmpty()) {
				        // oldfile이 비어있는 경우 => EmpFile에 null 저장
				        employeesDTO.setEmpFile(null);
				    } else {
				        // oldfile이 있는 경우 => oldfile 저장
				        employeesDTO.setEmpFile(oldfile);
				    }
				} else {
				    UUID uuid = UUID.randomUUID();
				    String filename = uuid.toString() + "_" + file.getOriginalFilename();
				    FileCopyUtils.copy(file.getBytes(), new File(uploadPath, filename));
				    employeesDTO.setEmpFile(filename);
				}
				// 날짜 형식을 변환합니다.
			    DateTimeFormatter originalFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			    DateTimeFormatter targetFormat = DateTimeFormatter.ofPattern("yyMMdd");
			    String empHiredate = employeesDTO.getEmpHiredate(); 
			    LocalDate date = LocalDate.parse(empHiredate, originalFormat);
			    String reformattedDate = date.format(targetFormat);

			    // 사원 수를 4자리 숫자로 변환합니다.
			    String employeeCountStr = employeesService.getEmployeesCount2();
			    int employeeCount = Integer.parseInt(employeeCountStr);
			    String formattedCount = String.format("%04d", employeeCount);

			    // 새로운 사원번호를 생성합니다.
			    String newEmployeeNumber = reformattedDate + formattedCount;
			    employeesDTO.setEmpId(newEmployeeNumber);
			    employeesDTO.setEmpPass(newEmployeeNumber);
		employeesService.insertEmployees(employeesDTO);
		return "redirect:/employees/employees";
	}
	
	// 게시물 선택삭제
    @RequestMapping(value = "/delete")
    public String ajaxTest(HttpServletRequest request) throws Exception {
        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
        for(int i=0; i<size; i++) {
        	employeesService.delete(ajaxMsg[i]);
        }
        return "redirect:/employees/employees";
    }//delete
    
    // 인사수정 홈
	@GetMapping("/update")
	public String update(HttpServletRequest request,Model model) {
		String empId = request.getParameter("empId");
		EmployeesDTO employeesDTO = employeesService.getMember(empId);
		model.addAttribute("employeesDTO", employeesDTO);
		return "employees/employees3";
	}//update
	
//	인사수정
	@PostMapping("/updatePro")
	public String updatePro(HttpServletRequest request,EmployeesDTO employeesDTO, MultipartFile file, HttpSession session) throws Exception{
	 // 첨부파일이 비어있으면
		if(file.isEmpty()) {
		    String oldfile = request.getParameter("oldfile");
		 // oldfile이 비어있는 경우 => EmpFile에 null 저장
		    if(oldfile == null || oldfile.isEmpty()) {
		        employeesDTO.setEmpFile(null);
		     // oldfile이 있는 경우 => oldfile 저장
		    } else {
		        employeesDTO.setEmpFile(oldfile);
		    }
		} else {
		    UUID uuid = UUID.randomUUID();
		    String filename = uuid.toString() + "_" + file.getOriginalFilename();
		    FileCopyUtils.copy(file.getBytes(), new File(uploadPath, filename));
		    employeesDTO.setEmpFile(filename);
		}
		// 기존 세션에서 empId 값을 확인
	    String empId = (String) session.getAttribute("empId");
	    if (empId != null && empId.equals(employeesDTO.getEmpId())) {
	        // empFile을 다음 세션으로 이동
	        session.setAttribute("empFile", employeesDTO.getEmpFile());
	    }
	    employeesService.updateEmployees(employeesDTO);
	    return "redirect:/employees/employees";
	}
	

	
//	라인등록,수정 드랍다운 메뉴
	@GetMapping("/empdropdown")
    public ResponseEntity<List<EmployeesDTO>> empdropdown() {
		List<EmployeesDTO> employeesList = employeesService.getEmployeesList2();
		ResponseEntity<List<EmployeesDTO>> entity = new 
		ResponseEntity<List<EmployeesDTO>>(employeesList, HttpStatus.OK);
        return entity;
	}
	
}
