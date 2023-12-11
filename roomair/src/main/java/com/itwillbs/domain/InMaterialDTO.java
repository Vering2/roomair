package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InMaterialDTO {
	private String inNum; // 입고코드
	private String inDate; // 입고일
	private int inCount; // 입고개수
	private int inPrice; // 입고 총가격
	private String rawCode; // 원자재코드
	private String rawName; // 원자재명
	private float rawPrice; // 원자재 단가
	private String buyNum; // 발주코드
	private String inEmpId; // 담당자
	private String clientCode; // 거래처코드
	private String clientCompany; // 거래처명
	private int stockCount; // 재고개수
	private String inState; // 입고상태
	private String whseCode; // 창고코드
	private String inMemo; // 비고
	private int buyCount; // 발주개수
	private String inRedate; // 재입고일
	private int remainder;// 입고 부족 개수

//	페이징 처리를 위한 DTO 
	private int pageSize; // 표현할 게시물 수
	private String pageNum; // 현재페이지
	private int currentPage;// 현재페이지
	private int startRow; // 시작하는 게시물
	private int endRow; // 끝나는 게시물

	private int count; // 게시물의 총개수
	private int startPage; // 시작하는 페이지
	private int endPage; // 끝나는 페이지
	private int pageBlock; // 페이지 크기
	private int pageCount; // 한 페이지에 보여주는 페이지 개수
}
