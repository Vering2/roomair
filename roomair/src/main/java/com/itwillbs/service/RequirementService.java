package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.itwillbs.dao.RequirementDAO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;


@Service
public class RequirementService {

	@Inject
	private RequirementDAO pdao;
	// 소요량관리 게시물 총 갯수
	
	public int countReq() {
		return pdao.countReq();
	}

	// 소요량관리 리스트 불러오기
	
	public List<RequirementDTO> getReqList(RequirementPageDTO pdto) throws Exception {
		return pdao.readReqList(pdto);
	}

	// 소요량관리 게시물 검색 갯수
	
	public int countReq(RequirementDTO dto) throws Exception {
		return pdao.countReq(dto);
	}

	// 소요량관리 검색리스트 불러오기
	
	public List<RequirementDTO> getReqList(RequirementDTO dto, RequirementPageDTO pdto) throws Exception {
		return pdao.readReqList(dto, pdto);
	}

	// 소요량관리 추가버튼 클릭 시 품번코드 가져가기
	
	public String getReqCode() {
		return pdao.readReqCode();
	}

	// 소요량관리 정보 다중 저장
	
	public void insertReq(List<RequirementDTO> req) throws Exception {
		
		for (RequirementDTO reqs : req) {
			if(reqs.getReqCode() != null) {			
				System.out.println("@@@@@@@@@@@@@@"+reqs.getReqCode());
			pdao.insertReqList(reqs);
			}
		}
	}
	
public int findCode(List<RequirementDTO> req) throws Exception {
		int findCode = 0; 
		for (RequirementDTO reqs : req) {
			if(reqs.getReqCode() != null) {			
				System.out.println("@@@@@@@@@@@@@@"+reqs.getReqCode());
				
			findCode += pdao.findCode(reqs);
			}
		}
		return findCode;
	}

	// 소요량관리 삭제
	
	public void removeReq(List<String> checked) throws Exception {
		pdao.deleteReq(checked);
	}

	// 소요량관리 수정 시 기존 데이터 가져가기
	
	public RequirementDTO getReq(String ReqCode) throws Exception {
		return pdao.getReq(ReqCode);
	}

	// 소요량관리 수정
	
	public void modifyReq(RequirementDTO udto) throws Exception {
		pdao.updateReq(udto);
	}

	public List<Map<String, Object>> getSearchExcelReqList(RequirementDTO dto) {
		return pdao.getSearchExcelReqList(dto);
	}

	public List<Map<String, Object>> getExcelReqList() {
		return pdao.getExcelReqList();
	}

}
