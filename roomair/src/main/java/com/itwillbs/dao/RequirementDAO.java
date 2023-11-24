package com.itwillbs.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.controller.RequirementController;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.service.RequirementService;


@Repository
public class RequirementDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(RequirementDAO.class);;


	private static final String NAMESPACE = "com.itwillbs.mappers.RequirementMapper";
	// 소요량관리 전체 갯수
	 
	public int countReq() {
		logger.debug(" 소요량관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countReq");
	}
	
	// 소요량관리 전체리스트
	 
	public List<RequirementDTO> readReqList(RequirementPageDTO pdto) throws Exception {
		logger.debug(" 소요량관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readReq", pdto);
	}
	
	// 소요량 검색 갯수
	 
	public int countReq(RequirementDTO dto) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("reqCode", dto.getReqCode());
		data.put("prodCode", dto.getProdCode());
		data.put("rawCode", dto.getRawCode());
		
		return sqlSession.selectOne(NAMESPACE + ".countSearchReq", data);
	}
	
	// 소요량 검색 리스트
	 
	public List<RequirementDTO> readReqList(RequirementDTO dto, RequirementPageDTO pdto) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", pdto.getStart());
		data.put("cntPerPage", pdto.getCntPerPage());
		data.put("reqCode", dto.getReqCode());
		data.put("prodCode", dto.getProdCode());
		data.put("rawCode", dto.getRawCode());

		return sqlSession.selectList(NAMESPACE + ".readSearchReq", data);
	}
	
	// 소요량 추가버튼 클릭 시 품번코드 가져가기
	 
	public String readReqCode() {
		
		String code = "RQ000";
		
		if (sqlSession.selectOne(NAMESPACE + ".readReqCode") == null) {
			return code;
		} else {
			return sqlSession.selectOne(NAMESPACE + ".readReqCode");
		}
		
	}
	
	// 소요량 데이터 추가
	 
	public void insertReqList(RequirementDTO req) {
		sqlSession.insert(NAMESPACE + ".reqIn", req);

	}
	
	public int findCode(RequirementDTO req) {
		return sqlSession.selectOne(NAMESPACE + ".findCode", req);
	}
	
	// 소요량 데이터 삭제
	 
	public void deleteReq(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteRaw() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String reqCode = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteReq", reqCode);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);

	}
	
	// 소요량관리 수정 시 기존데이터 가져가기
	 
	public RequirementDTO getReq(String reqCode) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".readReqOne", reqCode);
	}

	// 소요량관리 수정
	 
	public void updateReq(RequirementDTO udto) throws Exception {
		sqlSession.update(NAMESPACE + ".updateReq", udto);
	}

	public List<Map<String, Object>> getSearchExcelReqList(RequirementDTO dto) {
		return sqlSession.selectList(NAMESPACE + ".getSearchExcelReqList", dto);
	}

	public List<Map<String, Object>> getExcelReqList() {
		return sqlSession.selectList(NAMESPACE + ".getExcelReqList");
	}

}
