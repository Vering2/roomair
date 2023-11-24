package com.itwillbs.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.WorkOrderDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class PerformanceDAO {
	
	@Inject // root - context.xml에서 받아옴
	private SqlSession sqlsession;
	
	
	//MemberMapper 전체 이름 변수에 저장
	private static final String namespace="com.itwillbs.mappers.PerformanceMapper";




	public List<LineDTO> getlinelist() {

		return sqlsession.selectList(namespace+".getlinelist");
	}




	public List<ProdDTO> getprodlist() {
	
		return sqlsession.selectList(namespace+".getprodlist");
	}




	public List<PerformanceDTO> getperflist(PageDTO pageDTO) {
		
		return  sqlsession.selectList(namespace+".getperflist", pageDTO);
		
	}




	public List<WorkOrderDTO> getworklist() {
		
		return sqlsession.selectList(namespace+".getworklist");
	}




	public void perfinsert(String perfCode) {
		
		sqlsession.insert(namespace+".perfinsert",perfCode);
		
		
	}




	public PerformanceDTO getdetail(String perfCode) {
		
		return sqlsession.selectOne(namespace+".getdetail", perfCode);
	}




	public void perfupdate(PerformanceDTO perfDTO) {
		
		System.out.println("Peroformnace DAO UpdatePro 받은값:-++++++++++++++" + perfDTO);
		sqlsession.update(namespace+".perfupdate",perfDTO);
		
		
	}




	public boolean perfdelete(String perfCode) {
		
		
		
		return sqlsession.delete(namespace+".perfdelete",perfCode) > 0;
	}




	public List<PerformanceDTO> getSearch(PerformanceDTO perfDTO, PageDTO pageDTO) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("startRow", pageDTO.getStartRow());
		data.put("pageSize", pageDTO.getPageSize());
		data.put("lineCode", perfDTO.getLineCode());
		data.put("prodCode", perfDTO.getProdCode());
		
		
		/*
		 * data.put("perfDate1", perfDTO.getPerfDate()); data.put("perfDate2",
		 * perfDTO.getPerfDate());
		 */
		return sqlsession.selectList(namespace+".getSearch", data);
	}




	public int getSearchcount(PerformanceDTO perfDTO) {
		
		return sqlsession.selectOne(namespace+".getSearchcount", perfDTO);
	}




	public int getperfCount(PageDTO pageDTO) {
		
		return sqlsession.selectOne(namespace+".getperfCount",pageDTO);
	}
	
	//차트JS 도넛차트 
	public List<PerformanceDTO> getdonut(List<String> lineCode) {
		System.out.println("PerformanceDAO getDonut Service에서 가져온 값:"+lineCode);
		List<PerformanceDTO>  result =  sqlsession.selectList(namespace+".getdonut", lineCode);
		System.out.println("DB에서 가져온값 ++++++++++++++++++++:"+result);
        return result;
	
}




	public int updateperf(PerformanceDTO perfDTO) {
		
		System.out.println(perfDTO + "DAO에서도 받아지나 ??????????????????????????????????" );
		return sqlsession.update(namespace+".updateperf",perfDTO);
		
	}




	public int updateStock(PerformanceDTO perfDTO) {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".updateStock",perfDTO);
	}




	public int updateperfSub(PerformanceDTO perfDTO) {
		return sqlsession.update(namespace+".updateperfSub",perfDTO);
	}




	public int updateStockSub(PerformanceDTO perfDTO) {
		return sqlsession.update(namespace+".updateStockSub",perfDTO);
	}

}
