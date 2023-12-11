package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RawmaterialsDTO {

	private String rawCode;
	private String rawName;
	private String rawType;
	private String rawUnit;
	private float rawPrice;
//	private String clientCode;
	private String whseCode;
	private String whseName;
	private String rawMemo;
	private int shortageAmount;

	// 내가 추가한 변수
	private int rawNum;
	private Timestamp date;
	private int stockCount;
	private int whseCount;

}