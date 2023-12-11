package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OutProductDTO {
	private String outCode; // 출고코드
	private String prodCode; // 상품코드
	private String outDate; // 출고일
	private String outEmpId; // 담당자
	private String outMemo; // 출고비고
	private String outRedate; // 재출고일
	private int outCount; // 출고개수
	private int outPrice; // 출고가격
	private String sellCode; // 수주코드
	private int sellCount; // 출고해야할 총 개수
	private String sellDuedate; // 출고예정일
	private String sellState; // 출고상태
	private String clientCode; // 거래처코드
	private String clientCompany; // 거래처명
	private String prodName; // 상품이름
	private float prodPrice; // 상품 EA 가격
	private int stockCount; // 재고개수
	private int clientSale; // 수정될 매출액
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
