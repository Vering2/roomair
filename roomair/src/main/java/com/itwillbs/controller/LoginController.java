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

/*
 * LoginController: 로그인과 로그아웃을 처리하는 Spring MVC Controller입니다.
 */

@Controller
@RequestMapping("/login/*")
public class LoginController {

    @Inject
    private LoginService loginService;

    /*
     * 로그인 화면을 보여주는 메서드입니다.
     * 
     * @return String 로그인 화면의 뷰 이름
     */
    @GetMapping("/login")
    public String login() {
        return "login/login";
    }

    /*
     * 로그인을 처리하는 메서드입니다. 입력받은 로그인 정보를 확인하여 성공 시 세션에 사용자 정보를 저장하고
     * 메인 화면으로 이동하며, 실패 시 ALERT 창을 표시하고 이전 페이지로 이동합니다.
     * 
     * @param loginDTO   입력받은 로그인 정보를 담은 객체
     * @param session    HttpSession 객체
     * @param response   HttpServletResponse 객체
     * @return String    성공 시 메인 화면으로 리다이렉트, 실패 시 null
     */
    @PostMapping("/loginPro")
    public String loginPro(LoginDTO loginDTO, HttpSession session, HttpServletResponse response) {
        System.out.println("LoginController loginPro()");
        System.out.println(loginDTO);

        loginDTO = loginService.userCheck(loginDTO);

        if (loginDTO != null) {
            session.setAttribute("empId", loginDTO.getEmpId());
            session.setAttribute("empName", loginDTO.getEmpName());
            session.setAttribute("empDepartment", loginDTO.getEmpDepartment());
            session.setAttribute("empFile", loginDTO.getEmpFile());
            System.out.println("로그인 성공");
            return "redirect:/main/calendar";
        } else {
            // 로그인 실패 시 ALERT 창을 표시하고 이전 페이지로 이동
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out;
            try {
                out = response.getWriter();
                out.println("<script>");
                out.println("alert('계정정보가 틀렸습니다');");
                out.println("history.back()");
                out.println("</script>");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
    }

    /*
     * 로그아웃을 처리하는 메서드입니다. 세션을 무효화하고 로그인 화면으로 리다이렉트합니다.
     * 
     * @param session HttpSession 객체
     * @return String  로그인 화면으로 리다이렉트
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login/login";
    }

}
