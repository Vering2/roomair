package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.LoginDAO;
import com.itwillbs.domain.LoginDTO;



@Service
public class LoginService {

	@Inject
	private LoginDAO loginDAO;

	//----------------------------------------------------- userCheck --------------------------------------------------------	
	public LoginDTO userCheck(LoginDTO loginDTO) {
		System.out.println("LoginService userCheck()");

		return loginDAO.userCheck(loginDTO);
	}//userCheck
	
	






	

}//class


