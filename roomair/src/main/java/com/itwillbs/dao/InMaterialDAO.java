package com.itwillbs.dao;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.InMaterialDTO;
import com.mysql.cj.Session;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class InMaterialDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String namespace = "com.itwillbs.mappers.inMaterialMapper";

//------------------------------------------------------------------------------------------

	public List<InMaterialDTO> getInMaterialList(InMaterialDTO inMaterialDTO) {

		if ("전체".equals(inMaterialDTO.getInState())) {
			log.debug("전체용");
			return sqlSession.selectList(namespace + ".getInMaterialList", inMaterialDTO);
		} else if ("총검색".equals(inMaterialDTO.getInState())) {
			log.debug("총검색");
			return sqlSession.selectList(namespace + ".getInMaterialListAllSearch", inMaterialDTO);
		} else {
			log.debug("나머지용");
			return sqlSession.selectList(namespace + ".getInMaterialListSearch", inMaterialDTO);
		}
	}

	public int getInMaterialListCount(InMaterialDTO inMaterialDTO) {
		System.out.println("outProductDTO.getSellState(): " + inMaterialDTO.getInState());
		if (inMaterialDTO.getInState() == null) {
			inMaterialDTO.setInState("null");
		}
		if ("전체".equals(inMaterialDTO.getInState())) {
			System.out.println("전체용 카운트");
			return sqlSession.selectOne(namespace + ".getInMaterialListCount", inMaterialDTO);
		}
		if ("총검색".equals(inMaterialDTO.getInState())) {
			System.out.println("총검색 카운트");
			return sqlSession.selectOne(namespace + ".getInMaterialListAllSearchCount", inMaterialDTO);
		} else {
			System.out.println("나머지용 카운트");
			return sqlSession.selectOne(namespace + ".getInMaterialListSearchCount", inMaterialDTO);
		}
	}

	public Integer getMaxNum(String code) {
		return sqlSession.selectOne(namespace + ".getMaxNum", code);
	}

	public void insertList(InMaterialDTO inMaterialDTO) {
		System.out.println(inMaterialDTO);
		sqlSession.selectOne(namespace + ".insertList", inMaterialDTO);
	}

//	public List<InMaterialDTO> inMaterialContent(InMaterialDTO inMaterialDTO) {
//	public List<InMaterialDTO> inMaterialContent(String inNum) {
	public InMaterialDTO inMaterialContent(String inNum) {
//		return sqlSession.selectOne(namespace + ".inMaterialContent", inNum);
//		return sqlSession.selectList(namespace + ".inMaterialContent", inNum);
		return sqlSession.selectOne(namespace + ".inMaterialContent", inNum);
	}

	public void updateWhseCount(InMaterialDTO inMaterialDTO) {
		System.out.println(inMaterialDTO.getInCount());
		sqlSession.update(namespace + ".updateWhseCount", inMaterialDTO);

	}

	public void updateInState(InMaterialDTO inMaterialDTO) {
		sqlSession.update(namespace + ".updateInState", inMaterialDTO);
	}

	public void updateInDate(InMaterialDTO inMaterialDTO) {
		sqlSession.update(namespace+".updateInDate",inMaterialDTO);
	}

	public List<InMaterialDTO> getExcelList(InMaterialDTO inMaterialDTO) {
		if ("전체".equals(inMaterialDTO.getInState())) {
			log.debug("전체용");
			return sqlSession.selectList(namespace + ".getExcelList", inMaterialDTO);
		} else if ("총검색".equals(inMaterialDTO.getInState())) {
			log.debug("총검색");
			return sqlSession.selectList(namespace + ".getExcelListAllSearch", inMaterialDTO);
		} else {
			log.debug("나머지용");
			return sqlSession.selectList(namespace + ".getExcelListSearch", inMaterialDTO);
		}
	}

//	public void updateInEmpId(InMaterialDTO inMaterialDTO) {
//		System.out.println("InMaterialDAO updateInEmpId");
//		sqlSession.update(namespace+".updateInEmpId",inMaterialDTO);
//	}

//	public void updateInMaterial(InMaterialDTO inMaterialDTO) {
//		System.out.println("InMaterialDAO updateInMaterial");
//		sqlSession.update(namespace+".updateInMaterial",inMaterialDTO);
//	}

	public void updateList(InMaterialDTO inMaterialDTO) {
		sqlSession.update(namespace + ".updateList", inMaterialDTO);
	}

	public void deleteSell(String checked) {
			sqlSession.delete(namespace + ".deleteSell", checked);
		
	}

	public void updateInRedate(InMaterialDTO inMaterialDTO) {
		sqlSession.update(namespace + ".updateInRedate", inMaterialDTO);
		
	}

	public void updateInMaterialContent(InMaterialDTO inMaterialDTO) {
		sqlSession.update(namespace + ".updateInMaterialContent", inMaterialDTO);
		
	}
}
