package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProdDTO {
	private String prodCode;
	private String prodName;
	private String prodUnit;
	private String prodSize;
	private String prodPerfume;
	private String clientCode;
	private String clientCompany;
	private String whseCode;
	private String whseName;
	private float prodPrice;
	private String prodMemo;

	
}
