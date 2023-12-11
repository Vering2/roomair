package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.RawmaterialsDTO;

@Repository
public interface RawmaterialsDAO2 {

	public void delete(String rawCode); // 체크박스로 선택삭제

}