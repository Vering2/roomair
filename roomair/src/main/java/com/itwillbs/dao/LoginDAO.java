package com.itwillbs.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.LoginDTO;

@Repository
public class LoginDAO {
	// 마이바티스 객체생성
	@Inject
	private SqlSession sqlSession;
										
	private static final String namespace = "com.itwillbs.mappers.loginMapper";

//----------------------------------------------------- userCheck --------------------------------------------------------	
	public LoginDTO userCheck(LoginDTO loginDTO) {
		System.out.println("LoginDAO userCheck()");

		return sqlSession.selectOne(namespace+".userCheck", loginDTO);
	}//userCheck

//----------------------------------------------------- userCheck --------------------------------------------------------	


}// class
