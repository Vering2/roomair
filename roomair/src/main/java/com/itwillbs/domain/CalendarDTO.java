package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CalendarDTO {
	private int calendar_num;
	private String calendar_title;
	private String calendar_memo;
	private String startDate;
	private String endDate;
	private String code;

	
}
