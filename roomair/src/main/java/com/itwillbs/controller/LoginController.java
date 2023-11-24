package com.itwillbs.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.LoginDTO;
import com.itwillbs.service.LoginService;

@Controller
@RequestMapping("/login/*")
public class LoginController{
	
	@Inject
	private LoginService loginService;
	
//------------------------------------------------------- login ----------------------------------------------------
	@GetMapping("/login")
	public String login() {
		
		return "login/login";
	}//login

	@PostMapping("/loginPro")
	public String loginPro(LoginDTO loginDTO, HttpSession session,   HttpServletResponse response) {
		System.out.println("LoginController loginPro()");
		
		System.out.println(loginDTO);
		
		loginDTO = loginService.userCheck(loginDTO);
		
		if(loginDTO != null) {
			session.setAttribute("empId", loginDTO.getEmpId());
			session.setAttribute("empName", loginDTO.getEmpName());			
			session.setAttribute("empDepartment", loginDTO.getEmpDepartment());
			session.setAttribute("empFile", loginDTO.getEmpFile());
			System.out.println("성공");
			
			return "redirect:/main/calendar";
		}else {
			response.setContentType("text/html;charset=UTF-8");
			 PrintWriter out;
			try {
				out = response.getWriter();
				 // JavaScript 코드를 사용하여 ALERT 창을 표시
		        out.println("<script>");
		        out.println("alert('계정정보가 틀렸습니다');");
		        out.println("history.back()");
		        out.println("</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	}//loginPro

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();

		return "redirect:/login/login";
	}//
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
