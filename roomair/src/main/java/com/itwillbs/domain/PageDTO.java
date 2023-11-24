package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	
	private int pageSize; 
	private String pageNum;
	private int currentPage;
	private int startRow;
	private int endRow;
	
	private int count;
	private int pageBlock;
	private int startPage;
	private int endPage;
	private int pageCount;
	
	// 검색어
	private String search;
	private String search1;
	private String search2;
	private String search3;
	private String search4;
	
}