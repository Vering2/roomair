package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WarehouseDTO {

	private String whseCode;
	private String whseName;
	private String whseType;
	private String whseState;
	private String whseAddr;
	private String whseTel; 
	private String whseMemo;
	private String prodCode;
	private String rawCode;
	private String whseEmpId;
	private int whseCount;
	
}