package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.EmployeesDAO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.PageDTO;
@Service
public class EmployeesService {
	
	@Inject
	private EmployeesDAO employeesDAO;

	public void insertEmployees(EmployeesDTO employeesDTO) {
		employeesDAO.insertEmployees(employeesDTO);
	}

	public List<EmployeesDTO> getEmployeesList(PageDTO pageDTO) {
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return employeesDAO.getEmployeesList(pageDTO);
	}
	
	//게시물 삭제
    public void delete(String empId){
    	employeesDAO.delete(empId);
    }

	public EmployeesDTO getMember(String empId) {
		return employeesDAO.getMember(empId);
	}

	public void updateEmployees(EmployeesDTO employeesDTO) {
		employeesDAO.updateEmployees(employeesDTO);	
	}

	public int getEmployeesCount(PageDTO pageDTO) {
		return employeesDAO.getEmployeesCount(pageDTO);
	}

	public boolean existsById(String empId) {
		return employeesDAO.existsById(empId);
	}

	public List<EmployeesDTO> getEmployeesList2() {
		return employeesDAO.getEmployeesList2();
	}

	public String generateNewEmployeeId() {
		
		    String lastEmployeeId = employeesDAO.getLastEmployeeIdFromDB();
		    
		    int lastNumber = Integer.parseInt(lastEmployeeId.substring(lastEmployeeId.length() - 4)) + 1;
        
	        // 새로운 사원번호 생성 (예: 1907010002 -> 1907010003)
	        String newEmployeeId = lastEmployeeId.substring(0, lastEmployeeId.length() - 4) + String.format("%04d", lastNumber);
	        
		
		return newEmployeeId;
	}

	public String getEmployeesCount2() {
		return employeesDAO.getEmployeesCount2();
	}



}
