package com.itwillbs.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.CalendarDTO;
import com.itwillbs.domain.CalendarEventDTO;
import com.itwillbs.domain.ChartDTO;
import com.itwillbs.service.CalendarService;

@RestController
public class AjaxCalendarController {

	@Inject
	private CalendarService calendarService;

	
	@RequestMapping(value = "/main/calendarList", method = RequestMethod.POST)
	public ResponseEntity<List<CalendarEventDTO>> getCalendarData(HttpServletRequest request) {
	    // 캘린더 이벤트 목록을 데이터베이스에서 가져옵니다.
	    List<CalendarDTO> calendarList = calendarService.getCalendarList();
	    List<CalendarEventDTO> calendarEvents = new ArrayList<>();

	    if (calendarList != null) {
	        // 각 캘린더 이벤트에 대한 JSON 객체를 생성합니다.
	        for (CalendarDTO calendarDTO : calendarList) {
	            CalendarEventDTO event = new CalendarEventDTO();
 
	            // JSON 객체에 캘린더 이벤트의 속성들을 설정합니다.
	            event.setId(calendarDTO.getCalendar_num()); // ID 설정
	            event.setTitle(calendarDTO.getCalendar_title()); // 제목 설정
	            event.setStart(calendarDTO.getStartDate()); // 시작 날짜 설정

	            // 종료 날짜가 있는 경우, 종료 날짜 설정
	            // 풀캘린더 특정상 26~27일까지의 데이터를 주면 화면에서는 26일만 표현을 해준다
	            // 그렇기 때문에 +1 의 값을 end로 지정
	            if (calendarDTO.getEndDate() != null) {
	                try {
	                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	                    Date endDate = dateFormat.parse(calendarDTO.getEndDate());

	                    // 날짜에 1일을 더합니다.
	                    Calendar calendar = Calendar.getInstance();
	                    calendar.setTime(endDate);
	                    calendar.add(Calendar.DAY_OF_MONTH, 1);

	                    // 포맷을 다시 적용하여 문자열로 변환합니다.
	                    String formattedEndDate = dateFormat.format(calendar.getTime());

	                    event.setEnd(formattedEndDate);
	                } catch (Exception e) {
	                    // 날짜 형식이 올바르지 않을 경우 예외 처리
	                    e.printStackTrace();
	                }
	            }

	            event.setDescription(calendarDTO.getCalendar_memo()); // 설명 설정
	            event.setOtherDate(calendarDTO.getEndDate()); // 실제 종료 날짜 설정

	            // 제목에 따라 이벤트 색상을 지정합니다.
//	            String color = (calendarDTO.getCalendar_title().equals("수주")) ? "blue"
//	                    : ((calendarDTO.getCalendar_title().equals("발주")) ? "red" : "orange");
	            String color;
	            if (calendarDTO.getCalendar_title().contains("수주")) {
	                color = "#4b77a9";
	            } else if (calendarDTO.getCalendar_title().contains("출고")) {
	                color = "#5f255f";
	            } else if (calendarDTO.getCalendar_title().contains("원자재 발주")) {
	                color = "#d21243";
	            } else if (calendarDTO.getCalendar_title().contains("원자재 입고")) {
	                color = "#ff5733";
	            } else {
	                color = "#ffcc29";
	            }
	            
	            event.setBackgroundColor(color);

	            // 생성한 JSON 객체를 목록에 추가합니다.
	            calendarEvents.add(event);
	        }
	    }

	    // 생성된 캘린더 이벤트 목록을 JSON 형태로 반환하고 HTTP 상태 코드를 설정합니다.
	    ResponseEntity<List<CalendarEventDTO>> entity = new ResponseEntity<>(calendarEvents, HttpStatus.OK);
	    return entity;
	}
	@RequestMapping(value = "/main/salesList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> salesList() {
		List<ChartDTO> salesList = calendarService.getSalesList();

		ResponseEntity<List<ChartDTO>> entity = new ResponseEntity<>(salesList, HttpStatus.OK);

	    return entity;
		
	}
	@RequestMapping(value = "/main/stockList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> stockList() {
		List<ChartDTO> stockList = calendarService.getStockList();
		
		ResponseEntity<List<ChartDTO>> entity = new ResponseEntity<>(stockList, HttpStatus.OK);
		
		return entity;
		
	}
	@RequestMapping(value = "/main/perfList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> perfList() {
		List<ChartDTO> perfList = calendarService.getPerfList();
		
		Collections.reverse(perfList);
		
		ResponseEntity<List<ChartDTO>> entity = new ResponseEntity<>(perfList, HttpStatus.OK);
		
		return entity;
		
	}
	@RequestMapping(value = "/main/linePerfList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> linePerfList() {
		List<ChartDTO> perfList = calendarService.getLinePerfList();
		
		ResponseEntity<List<ChartDTO>> entity = new ResponseEntity<>(perfList, HttpStatus.OK);
		
		return entity;
	}
}
