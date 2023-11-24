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
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.RequirementService;


@Repository
public class ModalDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(ModalDAO.class);;


	private static final String NAMESPACE = "com.itwillbs.mappers.ModalMapper";

	 // 품목 조회
	
	 public ProdDTO modalprod(String prodCode) throws Exception {
	 logger.debug("@@ D : modalprod(String prodName) 호출 @@");
	 return sqlSession.selectOne(NAMESPACE+".modalprod", prodCode); }
	 
	 public RawmaterialsDTO modalraw(String rawCode) throws Exception {
		 logger.debug("@@ D : modalraw(String rawCode) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalraw", rawCode); }
	 
	 public SellDTO modalsell(String sellCode) throws Exception {
		 logger.debug("@@ D :  modalsell(String sellCode) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalsell", sellCode); }
	 
	 public WorkOrderDTO modalworkinfo(String workCode) throws Exception {
		 logger.debug("@@ D :  modalsell(String sellCode) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalwork", workCode); }
	 
	 public ClientDTO modalclient(String clientCode) throws Exception {
		 logger.debug("@@ D :  modalclient(String clientCode) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalclient", clientCode); }
	 
	 public WarehouseDTO modalwhse(String whseCode) throws Exception {
		 logger.debug("@@ D :  modalwhse(String whseCode) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalwhse", whseCode); }
	 
	 public EmployeesDTO modalemp(String empId) throws Exception {
		 logger.debug("@@ D :  modalemp(String empId) 호출 @@");
		 return sqlSession.selectOne(NAMESPACE+".modalemp", empId); }




}
