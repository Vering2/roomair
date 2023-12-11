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

//AjaxCalendarController: 이 클래스는 웹 애플리케이션에서 캘린더 이벤트 및 다양한 차트 데이터와 관련된 AJAX 요청을 처리하는 Spring MVC 컨트롤러입니다.

@RestController
public class AjaxCalendarController {

	// 비즈니스 로직 처리를 위해 CalendarService를 주입합니다.
	@Inject
	private CalendarService calendarService;

	// 캘린더 이벤트 데이터를 가져오는 엔드포인트입니다.
	@RequestMapping(value = "/main/calendarList", method = RequestMethod.POST)
	public ResponseEntity<List<CalendarEventDTO>> getCalendarData(HttpServletRequest request) {
		// 데이터베이스에서 캘린더 이벤트 목록을 가져옵니다.
		List<CalendarDTO> calendarList = calendarService.getCalendarList();
		List<CalendarEventDTO> calendarEvents = new ArrayList<>();

		if (calendarList != null) {
			// 각 캘린더 이벤트를 JSON 객체로 변환합니다.
			for (CalendarDTO calendarDTO : calendarList) {
				CalendarEventDTO event = new CalendarEventDTO();

				// 캘린더 이벤트의 속성을 설정합니다.
				event.setId(calendarDTO.getCalendar_num()); // ID 설정
				event.setTitle(calendarDTO.getCalendar_title()); // 제목 설정
				event.setStart(calendarDTO.getStartDate()); // 시작 날짜 설정

				// 종료 날짜가 있는 경우, 종료 날짜를 설정합니다.
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
		return new ResponseEntity<>(calendarEvents, HttpStatus.OK);
	}

	// 판매 차트 데이터를 가져오는 엔드포인트입니다.
	@RequestMapping(value = "/main/salesList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> salesList() {
		List<ChartDTO> salesList = calendarService.getSalesList();
		return new ResponseEntity<>(salesList, HttpStatus.OK);
	}

	// 재고 차트 데이터를 가져오는 엔드포인트입니다.
	@RequestMapping(value = "/main/stockList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> stockList() {
		List<ChartDTO> stockList = calendarService.getStockList();
		return new ResponseEntity<>(stockList, HttpStatus.OK);
	}

	// 성과 차트 데이터를 가져오는 엔드포인트입니다.
	@RequestMapping(value = "/main/perfList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> perfList() {
		List<ChartDTO> perfList = calendarService.getPerfList();
		Collections.reverse(perfList); // 리스트를 역순으로 정렬하여 역순으로 표시합니다.
		return new ResponseEntity<>(perfList, HttpStatus.OK);
	}

	// 라인 성과 차트 데이터를 가져오는 엔드포인트입니다.
	@RequestMapping(value = "/main/linePerfList", method = RequestMethod.POST)
	public ResponseEntity<List<ChartDTO>> linePerfList() {
		List<ChartDTO> perfList = calendarService.getLinePerfList();
		return new ResponseEntity<>(perfList, HttpStatus.OK);
	}
}