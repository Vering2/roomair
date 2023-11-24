package com.itwillbs.service;

public class CodeChange {
	public String codeChange(String code_id, int num){
		return String.format("%s%09d", code_id, ++num);
	}
}
