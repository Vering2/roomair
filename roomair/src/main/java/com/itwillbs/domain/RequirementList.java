package com.itwillbs.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class RequirementList {
	private List<RequirementDTO> reqs;
	
	public RequirementList() {
		reqs = new ArrayList<RequirementDTO>();
	}
	
}