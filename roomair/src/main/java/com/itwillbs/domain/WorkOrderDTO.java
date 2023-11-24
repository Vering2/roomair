package com.itwillbs.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class WorkOrderDTO {
	private String workCode;
	private String prodCode;
	private String sellCode;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date workDate;
	private String lineCode;
	private int workAmount;
	private String workEmpId;
	private String changeId;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date workDatechange;
	private String workState;
	private String workProcess;
	private String prodName;
	private String workInfo;
	
//	private ProductVO product;
	
} //WorkOrder
