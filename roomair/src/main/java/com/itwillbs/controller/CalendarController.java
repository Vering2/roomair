package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.service.CalendarService;

@Controller
public class CalendarController {

	@Inject
	private CalendarService calendarService;

	@RequestMapping(value = "/main/calendar", method = RequestMethod.GET)
	public String getCalendar() {

		return "main/calendar";
	}

}
