package com.itwillbs.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ClientDAO {
		// 멤버변수 
	
		@Inject // root - context.xml에서 받아옴
		private SqlSession sqlsession;
		
		
		//MemberMapper 전체 이름 변수에 저장
		private static final String namespace="com.itwillbs.mappers.ClientMapper";

		public void insertClient(ClientDTO clientDTO) {
			
			System.out.println("ClientDAO insertClient요청  요청값====" + clientDTO);
			
			sqlsession.insert(namespace+".insertClient", clientDTO);
			
			
			
		}

		

		public String getclientCode(String clientType) {
			        log.debug("ClientDAO getclientCode 요청");
			        System.out.println("ClientDAO getClient요청  요청값====" + clientType);
			        
			        System.out.println(clientType);
			        
			   
			
			return sqlsession.selectOne(namespace+".getclientCode",clientType);
		}
		

		public ClientDTO clientdetail(String clientCompany) {
			System.out.println("ClientDAO clientdetail요청  요청값====" + clientCompany);
			
			return sqlsession.selectOne(namespace+".clientdetail", clientCompany);
			
			
		}

		public RawmaterialsDTO rawmaterialsdetail(String clientCode) {
			
			return sqlsession.selectOne(namespace+".rawmaterialsdetail", clientCode);
		}

		public ProdDTO selldetail(String clientCode) {
			
			System.out.println("ClientDAO clientDTO의 수주처요청  요청값====" + clientCode);
			
			return sqlsession.selectOne(namespace+".selldetail", clientCode);
		}

		public void clientupdate(ClientDTO clientDTO) {
			
			System.out.println("ClientDAO clientUpdate요청  요청값====" + clientDTO);
			
			sqlsession.update(namespace+".clientupdate",clientDTO);
		}

		public void clientdelete(String clientCompany) {
			
			sqlsession.delete(namespace+".clientdelete",clientCompany);
			
		}

		public List<ClientDTO> getSearch(ClientDTO clientDTO, PageDTO pageDTO) {
			HashMap<String, Object> data = new HashMap<String, Object>();
			data.put("startRow", pageDTO.getStartRow());
			data.put("pageSize", pageDTO.getPageSize());
			data.put("clientCompany", clientDTO.getClientCompany());
			data.put("clientType", "전체".equals(clientDTO.getClientType()) ? "" : clientDTO.getClientType());
			
			return sqlsession.selectList(namespace+".getSearch", data);
		}
		
		



		public int getSearchcount(ClientDTO clientDTO) {
			
			String clientType = "전체".equals(clientDTO.getClientType()) ? "" : clientDTO.getClientType();
			clientDTO.setClientType(clientType); // clientDTO 객체의 clientType을 빈 문자열("") 또는 값으로 설정
			
			return sqlsession.selectOne(namespace+".getSearchcount",clientDTO);
     	}



		public int getclientCount(PageDTO pageDTO) {
			
			return sqlsession.selectOne(namespace+".getclientCount",pageDTO);
		}



		public List<ClientDTO> getclientList(PageDTO pageDTO) {
			
			return sqlsession.selectList(namespace+".getclientList", pageDTO);
		}

}
