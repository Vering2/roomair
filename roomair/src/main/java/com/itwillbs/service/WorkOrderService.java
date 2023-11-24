package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.dao.WorkOrderDAO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.WorkOrderDTO;



@Service
public class WorkOrderService {
	
	@Autowired
	private WorkOrderDAO wdao;
	
	public List<WorkOrderDTO> getAllWorkOrder(RequirementPageDTO pdto) throws Exception {
		// DAO에서 가져오기
		
		return wdao.readAllWorkOrder(pdto);
	} //getAllWorkOrder()

	public int regWorkOrder(WorkOrderDTO dto) throws Exception {
		// DAO - 작업지시 등록
		return wdao.insertWorkOrder(dto);
	} //regWorkOrder()


	public void removeWorkOrder(List<String> checked) throws Exception {
		// DAO - 작업지시 삭제
		wdao.deleteWorkOrder(checked);
	} //removeWorkOrder()

	
	public WorkOrderDTO getWorkOrder(String workCode) throws Exception {
		// DAO - 작업지시 조회
		return wdao.readWorkOrder(workCode);
	} //getWorkOrder()
	
	
	public int modifyWorkOrder(WorkOrderDTO udto) throws Exception {
		// DAO - 작업지시 수정
		return wdao.updateWorkOrder(udto);
	} //modifyWorkOrder()

	
	public List<WorkOrderDTO> searchWorkOrder(HashMap<String, Object> search) throws Exception {
		// DAO - 작업지시 검색
		return wdao.selectWorkOrder(search);
	} //searchWorkOrder()

	
	public int getTotalWorkOrder() throws Exception {
		// DAO - 작업지시 전체 개수
		return wdao.getTotalWorkOrder();
	} //getTotalWorkOrder()

	
	public int getSearchWorkOrder(HashMap<String, Object> search) throws Exception {
		// DAO - 작업지시 검색 개수
		return wdao.getSearchWOrkOrder(search);
	} //getSearchWorkOrder()

	
	public String modifyStatus(WorkOrderDTO dto) throws Exception {
		// DAO - 작업지시 현재 작업 공정 변경
		return wdao.updateStatus(dto);
	} //modifyStatus()

	
	public String getLineCode() throws Exception {
		// DAO - 작업지시 등록 시 1차공정 라인 가져오기
		return wdao.getLineCode();
	}
	
	
	public List<RawmaterialsDTO> checkStock(WorkOrderDTO dto) throws Exception {
		// DAO - 작업지시 등록
		return wdao.checkStock(dto);
	}

	public List<Map<String, Object>> getWorkOrderSearchExcel(HashMap<String, Object> searchParams) {
		return wdao.getWorkOrderSearchExcel(searchParams);
	}

	public List<Map<String, Object>> getWorkOrderAllExcel() {
		return wdao.getWorkOrderAllExcel();
	}

} //WorkOrderServiceImpl
