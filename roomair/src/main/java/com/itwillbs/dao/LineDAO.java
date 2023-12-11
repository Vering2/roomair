package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class LineDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace = "com.itwillbs.Mappers.LineMapper";

	public List<LineDTO> getlineList(PageDTO pageDTO) {
		return sqlSession.selectList(namespace + ".getlineList", pageDTO);
	}

	public int getlineCount(PageDTO pageDTO) {
		return sqlSession.selectOne(namespace + ".getlineCount", pageDTO);
	}

	public void insertLine(LineDTO lineDTO) {
		sqlSession.insert(namespace + ".insertLine", lineDTO);
	}

	public void delete(String lineCode) {
		sqlSession.delete(namespace + ".delete", lineCode);
	}

	public LineDTO getLine(String lineCode) {
		return sqlSession.selectOne(namespace + ".getLine", lineCode);
	}

	public void updateLine(LineDTO lineDTO) {
		sqlSession.update(namespace + ".updateLine", lineDTO);
	}

}
