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

import com.itwillbs.dao.ModalDAO;
import com.itwillbs.dao.OpenlistDAO;
import com.itwillbs.dao.RequirementDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.EmployeesDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.domain.WorkOrderDTO;


@Service
public class ModalService {

	@Inject
	private ModalDAO modaldao;
  // 품목관리 리스트 불러오기
	    public ProdDTO modalprod(String prodCode) throws Exception {
	 return modaldao.modalprod(prodCode); }
	    
	    public RawmaterialsDTO modalraw(String rawCode) throws Exception {
	   	 return modaldao.modalraw(rawCode); }
	
	    public SellDTO modalsell(String sellCode) throws Exception {
		   	 return modaldao.modalsell(sellCode); }
	    
	    public WorkOrderDTO modalworkinfo(String workCode) throws Exception {
		   	 return modaldao.modalworkinfo(workCode); }
	
	    public ClientDTO modalclient(String clientCode) throws Exception {
		   	 return modaldao.modalclient(clientCode); }
	    
	    public WarehouseDTO modalwhse(String whseCode) throws Exception {
		   	 return modaldao.modalwhse(whseCode); }
	    
	    public EmployeesDTO modalemp(String empId) throws Exception {
		   	 return modaldao.modalemp(empId); }






}
