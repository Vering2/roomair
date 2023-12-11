package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/*
 * CalendarController: 이 클래스는 캘린더 관련 페이지를 처리하는 Spring MVC 컨트롤러입니다.
 */

@Controller
public class CalendarController {

  
    /*
     * 캘린더 페이지를 반환하는 엔드포인트입니다.
     * 
     * @return String 캘린더 페이지의 뷰 이름을 반환합니다.
     */
    @RequestMapping(value = "/main/calendar", method = RequestMethod.GET)
    public String getCalendar() {
        return "main/calendar";
    }
}
