  package com.itwillbs.domain;
  
  import lombok.Data;
  
  @Data public class RequirementDTO {
	  private String reqCode;
	  private String prodCode;
	  private String reqAmount;
	  private String reqMemo;
	  private String rawCode;
	  private ProdDTO prod;
	  private RawmaterialsDTO raw; 
	  public RequirementDTO() {
		 prod = new ProdDTO();
		 raw = new RawmaterialsDTO();
		 }
		
  
  
  } //Requirements
 