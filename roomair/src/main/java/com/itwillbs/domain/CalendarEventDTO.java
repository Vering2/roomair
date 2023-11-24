package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CalendarEventDTO {
	private int id;
    private String title;
    private String start;
    private String end;
    private String description;
    private String otherDate;
    private String backgroundColor;
    
}
