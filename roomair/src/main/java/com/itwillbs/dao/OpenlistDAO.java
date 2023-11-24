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
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.RequirementService;


@Repository
public class OpenlistDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(OpenlistDAO.class);;


	private static final String NAMESPACE = "com.itwillbs.mappers.OpenlistMapper";

	// 품목관리 리스트 총 갯수
	 
	public int countProd() {
		logger.debug(" 품목관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countProd");
	}

	
	  // 품목 리스트 불러오기
	  
	    public List<ProdDTO> readProdList(RequirementPageDTO pdto) throws
	  Exception { logger.debug(" 품목관리 전체리스트 DAO "); return
	  sqlSession.selectList(NAMESPACE + ".readProd", pdto); }
	  
	  // 품목관리 검색 리스트 총 갯수
	  
	    public int countProd(ProdDTO dto) { return
	  sqlSession.selectOne(NAMESPACE + ".countSearchProd", dto); }
	  
	
	  // 품목 검색리스트 불러오기
	  
	  public List<ProdDTO> readProdList(ProdDTO dto, RequirementPageDTO pdto)
	  throws Exception {
	  HashMap<String,Object> data = new HashMap<String, Object>();
	  data.put("start", pdto.getStart()); data.put("cntPerPage",
	  pdto.getCntPerPage()); data.put("prodCode", dto.getProdCode());
	  data.put("prodName", dto.getProdName()); 
	  
	  return sqlSession.selectList(NAMESPACE + ".readSearchProd", data); }
	
	// ==========================================================================
	
	// 원자재관리 리스트 총 갯수
	 
	public int countRaw() {
		logger.debug(" 원자재관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countRaw");
	}
	
	// 원자재 관리 전체 리스트
	
	    public List<RawmaterialsDTO> readRawList(RequirementPageDTO pdto) throws
	  Exception { logger.debug(" 원자재관리 전체리스트 DAO "); return
	  sqlSession.selectList(NAMESPACE + ".readRaw", pdto); }
	  
	  // 원자재관리 검색 갯수
	  
	    public int countRaw(RawmaterialsDTO dto) { HashMap<String, Object>
	  data = new HashMap<String, Object>();
	  
	  data.put("rawCode", dto.getRawCode()); data.put("rawName",
	  dto.getRawName()); 
	  
	  return sqlSession.selectOne(NAMESPACE + ".countSearchRaw", data); }
	  
	  // 원자재관리 검색리스트
	  
	    public List<RawmaterialsDTO> readRawList(RawmaterialsDTO dto,
	  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
	  HashMap<String, Object>();
	  
	  data.put("start", pdto.getStart()); data.put("cntPerPage",
	  pdto.getCntPerPage()); data.put("rawCode", dto.getRawCode());
	  data.put("rawName", dto.getRawName());
	  
	  return sqlSession.selectList(NAMESPACE + ".readSearchRaw", data); }
	    
	 // ==========================================================================
		
		// 거래처목록 리스트 총 갯수
		 
		public int countClient() {
			logger.debug(" 거래처목록 리스트 갯수 확인 ");
			return sqlSession.selectOne(NAMESPACE + ".countClient");
		}
		public int buycountClient() {
			logger.debug(" 거래처목록 리스트 갯수 확인 ");
			return sqlSession.selectOne(NAMESPACE + ".buycountClient");
		}
		public int sellcountClient() {
			logger.debug(" 거래처목록 리스트 갯수 확인 ");
			return sqlSession.selectOne(NAMESPACE + ".sellcountClient");
		}
		
		// 거래처목록 전체 리스트
		
		    public List<ClientDTO> readClientList(RequirementPageDTO pdto) throws
		  Exception { logger.debug(" 거래처목록 전체리스트 DAO "); return
		  sqlSession.selectList(NAMESPACE + ".readClient", pdto); }
		    
		    public List<ClientDTO> buyreadClientList(RequirementPageDTO pdto) throws
			  Exception { logger.debug(" 거래처목록 전체리스트 DAO "); return
			  sqlSession.selectList(NAMESPACE + ".buyreadClient", pdto); }
		    
		    public List<ClientDTO> sellreadClientList(RequirementPageDTO pdto) throws
			  Exception { logger.debug(" 거래처목록 전체리스트 DAO "); return
			  sqlSession.selectList(NAMESPACE + ".sellreadClient", pdto); }
		  
		  // 거래처목록 검색 갯수
		  
		    public int countClient(ClientDTO dto) { HashMap<String, Object>
		  data = new HashMap<String, Object>();
		  
		  data.put("clientCode", dto.getClientCode()); data.put("clientCompany",
		  dto.getClientCompany()); 
		  
		  return sqlSession.selectOne(NAMESPACE + ".countSearchClient", data); }
		    
		    public int buycountClient(ClientDTO dto) { HashMap<String, Object>
			  data = new HashMap<String, Object>();
			  
			  data.put("clientCode", dto.getClientCode()); data.put("clientCompany",
			  dto.getClientCompany()); 
			  
			  return sqlSession.selectOne(NAMESPACE + ".buycountSearchClient", data); }
		    
		    public int sellcountClient(ClientDTO dto) { HashMap<String, Object>
			  data = new HashMap<String, Object>();
			  
			  data.put("clientCode", dto.getClientCode()); data.put("clientCompany",
			  dto.getClientCompany()); 
			  
			  return sqlSession.selectOne(NAMESPACE + ".sellcountSearchClient", data); }
		  
		  // 거래처목록 검색리스트
		  
		    public List<ClientDTO> readClientList(ClientDTO dto,
		  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
		  HashMap<String, Object>();
		  
		  data.put("start", pdto.getStart()); data.put("cntPerPage",
		  pdto.getCntPerPage()); data.put("clientCode", dto.getClientCode());
		  data.put("clientCompany", dto.getClientCompany());
		  
		  return sqlSession.selectList(NAMESPACE + ".readSearchClient", data); }
		    
		    public List<ClientDTO> buyreadClientList(ClientDTO dto,
		  		  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
		  		  HashMap<String, Object>();
		  		  
		  		  data.put("start", pdto.getStart()); data.put("cntPerPage",
		  		  pdto.getCntPerPage()); data.put("clientCode", dto.getClientCode());
		  		  data.put("clientCompany", dto.getClientCompany());
		  		  
		  		  return sqlSession.selectList(NAMESPACE + ".buyreadSearchClient", data); }
		    
		    public List<ClientDTO> sellreadClientList(ClientDTO dto,
		  		  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
		  		  HashMap<String, Object>();
		  		  
		  		  data.put("start", pdto.getStart()); data.put("cntPerPage",
		  		  pdto.getCntPerPage()); data.put("clientCode", dto.getClientCode());
		  		  data.put("clientCompany", dto.getClientCompany());
		  		  
		  		  return sqlSession.selectList(NAMESPACE + ".sellreadSearchClient", data); }

		    
		    // ==========================================================================
			
			// 수주목록 리스트 총 갯수
			 
			public int countSell() {
				logger.debug(" 수주목록 리스트 갯수 확인 ");
				return sqlSession.selectOne(NAMESPACE + ".countSell");
			}
			
			// 수주목록 전체 리스트
			
			    public List<SellDTO> readSellList(RequirementPageDTO pdto) throws
			  Exception { logger.debug(" 수주목록 전체리스트 DAO "); return
			  sqlSession.selectList(NAMESPACE + ".readSell", pdto); }
			  
			  // 수주목록 검색 갯수
			  
			    public int countSell(SellDTO dto) { HashMap<String, Object>
			  data = new HashMap<String, Object>();
			    
			  data.put("sellCode", dto.getSellCode()); data.put("clientCompany",
			  dto.getClientCompany()); 
			  
			  return sqlSession.selectOne(NAMESPACE + ".countSearchSell", data); }
			  
			  // 수주목록 검색리스트
			  
			    public List<SellDTO> readSellList(SellDTO dto,
			  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
			  HashMap<String, Object>();
			  
			  data.put("start", pdto.getStart()); data.put("cntPerPage",
			  pdto.getCntPerPage()); data.put("sellCode", dto.getSellCode());
			  data.put("clientCompany", dto.getClientCompany());
			  
			  return sqlSession.selectList(NAMESPACE + ".readSearchSell", data); }
			    
			    
			    // ==========================================================================
				
				//  1 창고목록 리스트 총 갯수
				 
				public int countWhse() {
					logger.debug(" 창고목록 리스트 갯수 확인 ");
					return sqlSession.selectOne(NAMESPACE + ".countWhse");
				}
				
				//  2 창고목록 전체 리스트
				
				    public List<WarehouseDTO> readWhseList(RequirementPageDTO pdto) throws
				  Exception { logger.debug(" 창고목록 전체리스트 DAO "); return
				  sqlSession.selectList(NAMESPACE + ".readWhse", pdto); }
				  
				  // 3 창고목록 검색 갯수
				  
				    public int countWhse(WarehouseDTO dto) { HashMap<String, Object>
				  data = new HashMap<String, Object>();
				  
				  data.put("whseCode", dto.getWhseCode()); data.put("whseName",
				  dto.getWhseName()); 
				  
				  return sqlSession.selectOne(NAMESPACE + ".countSearchWhse", data); }
				  
				  //  4 창고목록 검색리스트
				  
				    public List<WarehouseDTO> readWhseList(WarehouseDTO dto,
				  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
				  HashMap<String, Object>();
				  
				  data.put("start", pdto.getStart()); data.put("cntPerPage",
				  pdto.getCntPerPage()); data.put("whseCode", dto.getWhseCode());
				  data.put("whseName", dto.getWhseName());
				  
				  return sqlSession.selectList(NAMESPACE + ".readSearchWhse", data); }


				    
				    /////////// 라인리스트 추가 
				    
				//  1 창고목록 리스트 총 갯수
					 
					public int countline(LineDTO dto) {
						logger.debug(" 창고목록 리스트 갯수 확인 ");
						
						return sqlSession.selectOne(NAMESPACE + ".countline");
					}
					
					//  2 창고목록 전체 리스트


						public List<LineDTO> readlinelist( RequirementPageDTO pdto) {
                     logger.debug(" 창고목록 전체리스트 DAO ");
					    	
					    	return sqlSession.selectList(NAMESPACE + ".readline", pdto); 

						}


					  
					
					//////////////////////////////////////////////////////////////////////////////////
					
	
						// 직원관리 리스트 총 갯수
						 
						public int countEmp() {
							logger.debug(" 직원관리 리스트 갯수 확인 ");
							return sqlSession.selectOne(NAMESPACE + ".countEmp");
						}

						
						  // 직원 리스트 불러오기
						  
						    public List<EmployeesDTO> readEmpList(RequirementPageDTO pdto) throws
						  Exception { logger.debug(" 직원관리 전체리스트 DAO "); return
						  sqlSession.selectList(NAMESPACE + ".readEmp", pdto); }
						  
						  // 직원관리 검색 리스트 총 갯수
						  
						    public int countEmp(EmployeesDTO dto) { return
						  sqlSession.selectOne(NAMESPACE + ".countSearchEmp", dto); }
						  
						
						  // 직원 검색리스트 불러오기
						  
						  public List<EmployeesDTO> readEmpList(EmployeesDTO dto, RequirementPageDTO pdto)
						  throws Exception {
						  HashMap<String,Object> data = new HashMap<String, Object>();
						  data.put("start", pdto.getStart()); data.put("cntPerPage",
						  pdto.getCntPerPage());
						  data.put("empId", dto.getEmpId());
						  data.put("empName", dto.getEmpName()); 
						  data.put("empDepartment", dto.getEmpDepartment());
						  return sqlSession.selectList(NAMESPACE + ".readSearchEmp", data); }
						
						

				    
				


	// ==========================================================================
	

							///////////////////////////////////////////////

							// 총작업지시카운트
							public int countwork() {

								return sqlSession.selectOne(NAMESPACE+ ".countwork");
							}

							//작업지시 총 리스트
							public List<WorkOrderDTO> getworklist(RequirementPageDTO pdto) {

								return sqlSession.selectList(NAMESPACE + ".getworklist", pdto);

							}

							//  작업지시 검색 갯수 
							public int countwork(WorkOrderDTO dto) {

								HashMap<String, Object> data = new HashMap<String, Object>();

								  data.put("lineCode", dto.getLineCode());
								  data.put("prodName", dto.getProdCode()); 					
								return sqlSession.selectOne(NAMESPACE + ".searchworkcount",dto);
							}	

							//작업지시 검색
							public List<WorkOrderDTO> getwroklist(WorkOrderDTO dto, RequirementPageDTO pdto) {
								HashMap<String, Object> data = new HashMap<String, Object>();
							 	  data.put("start", pdto.getStart());
							   	  data.put("cntPerPage",pdto.getCntPerPage()); 

								  data.put("lineCode", dto.getLineCode());
								  data.put("prodName", dto.getProdCode());


								return sqlSession.selectList(NAMESPACE+ ".getsearchworklist" , data );
							}







}
