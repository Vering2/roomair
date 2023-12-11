package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.RawmaterialsDAO;
import com.itwillbs.domain.RawmaterialsDTO;

@Service
public interface RawmaterialsService2 {

	public void delete(String rawCode); // 체크박스로 선택삭제

}