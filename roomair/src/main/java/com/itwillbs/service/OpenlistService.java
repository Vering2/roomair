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


import com.itwillbs.dao.OpenlistDAO;
import com.itwillbs.dao.RequirementDAO;
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


@Service
public class OpenlistService {

	@Inject
	private OpenlistDAO pdao;

	// 품목관리 총 갯수
	
	public int countProd() {
		return pdao.countProd();
	}

	
	  // 품목관리 리스트 불러오기
	  
	  public List<ProdDTO> getProdList(RequirementPageDTO pdto) throws Exception {
	  return pdao.readProdList(pdto); }
	 

	
	  // 품목관리 검색리스트 갯수 불러오기
	  
	   public int countProd(ProdDTO dto) { return pdao.countProd(dto);
	  }
	 

	
	  // 품목관리 검색리스트 불러오기
	  
	   public List<ProdDTO> getProdList(ProdDTO dto, RequirementPageDTO pdto)
	  throws Exception {
	  
	  return pdao.readProdList(dto, pdto); }
	 


	// ==========================================================================

	// 원자재관리 총 갯수
	
	public int countRaw() {
		return pdao.countRaw();
	}

	
	  // 원자재관리 전체 리스트
	  
	   public List<RawmaterialsDTO> getRawList(RequirementPageDTO pdto) throws Exception
	   { return pdao.readRawList(pdto);
	  }
	 

	
	  // 원자재관리 검색 갯수
	  
	   public int countRaw(RawmaterialsDTO dto) { return
	  pdao.countRaw(dto); }
	 
	
	  // 원자재관리 검색 리스트
	  
	   public List<RawmaterialsDTO> getRawList(RawmaterialsDTO dto,
	  RequirementPageDTO pdto) throws Exception { return pdao.readRawList(dto, pdto); }
	   
	// ==========================================================================

		// 거래처목록 총 갯수
		
		public int countClient() {
			return pdao.countClient();
		}
		public int buycountClient() {
			return pdao.buycountClient();
		}
		public int sellcountClient() {
			return pdao.sellcountClient();
		}

		
		  // 거래처목록 전체 리스트
		  
		   public List<ClientDTO> getClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.readClientList(pdto);
		  }
		   public List<ClientDTO> buygetClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.buyreadClientList(pdto);
		  }
		   public List<ClientDTO> sellgetClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.sellreadClientList(pdto);
		  }
		 

		
		  // 거래처목록 검색 갯수
		  
		   public int countClient(ClientDTO dto) { return
		  pdao.countClient(dto); }
		   
		   public int buycountClient(ClientDTO dto) { return
					  pdao.buycountClient(dto); }
		   
		   public int sellcountClient(ClientDTO dto) { return
					  pdao.sellcountClient(dto); }
		 
		
		  // 거래처목록 검색 리스트
		  
		   public List<ClientDTO> getClientList(ClientDTO dto,
		  RequirementPageDTO pdto) throws Exception { return pdao.readClientList(dto, pdto); }
		   
		   public List<ClientDTO> buygetClientList(ClientDTO dto,
					  RequirementPageDTO pdto) throws Exception { return pdao.buyreadClientList(dto, pdto); }
		   
		   public List<ClientDTO> sellgetClientList(ClientDTO dto,
					  RequirementPageDTO pdto) throws Exception { return pdao.sellreadClientList(dto, pdto); }
	 

		// ==========================================================================

			// 수주목록 총 갯수
			
			public int countSell() {
				return pdao.countSell();
			}

			
			  // 수주목록 전체 리스트
			  
			   public List<SellDTO> getSellList(RequirementPageDTO pdto) throws Exception
			   { return pdao.readSellList(pdto);
			  }
			 

			
			  // 수주목록 검색 갯수
			  
			   public int countSell(SellDTO dto) { return
			  pdao.countSell(dto); }
			 
			
			  // 수주목록 검색 리스트
			  
			   public List<SellDTO> getSellList(SellDTO dto,
			  RequirementPageDTO pdto) throws Exception { return pdao.readSellList(dto, pdto); }
			   
			   
			// ==========================================================================

				// 거래처목록 총 갯수
				
				public int countWhse() {
					return pdao.countWhse();
				}

				
				  // 거래처목록 전체 리스트
				  
				   public List<WarehouseDTO> getWhseList(RequirementPageDTO pdto) throws Exception
				   { return pdao.readWhseList(pdto);
				  }
				 

				
				  // 거래처목록 검색 갯수
				  
				   public int countWhse(WarehouseDTO dto) { return
				  pdao.countWhse(dto); }
				 
				
				  // 거래처목록 검색 리스트
				  
				   public List<WarehouseDTO> getWhseList(WarehouseDTO dto,
				  RequirementPageDTO pdto) throws Exception { return pdao.readWhseList(dto, pdto); }

				   
				   ////////////////////////////////////////////////
				   
				   //라인 목록 갯수 검사
				public int countline(LineDTO dto) {
					
					return pdao.countline(dto);
				}


				public List<LineDTO> getlineList(RequirementPageDTO pdto) throws Exception {
					
					return pdao.readlinelist(pdto);
					
				}

				
		 
	// ==========================================================================
				// ==========================================================================

				// 직원목록 총 갯수
				
				public int countEmp() {
					return pdao.countEmp();
				}

				
				  // 직원목록 전체 리스트
				  
				   public List<EmployeesDTO> getEmpList(RequirementPageDTO pdto) throws Exception
				   { return pdao.readEmpList(pdto);
				  }

				
				  // 직원목록 검색 갯수
				  
				   public int countEmp(EmployeesDTO dto) { return
				  pdao.countEmp(dto); }
				 
				
				  // 직원목록 검색 리스트
				  
				   public List<EmployeesDTO> getEmpList(EmployeesDTO dto,
				  RequirementPageDTO pdto) throws Exception { return pdao.readEmpList(dto, pdto); }

					//////////////////////////////////// 작업지시 받아오기

					// 검색 총갯수 
					public int countwork(WorkOrderDTO dto) {

						return pdao.countwork(dto);
					}


					// 검색 리스트

					public List<WorkOrderDTO> getworklist(WorkOrderDTO dto, RequirementPageDTO pdto) {

						return pdao.getwroklist(dto,pdto);
					}


					// 작업지시 총개수 
					public int countwork() {

						return pdao.countwork();
					}

					//총 작업리스트
					public List<WorkOrderDTO> getworklist(RequirementPageDTO pdto) {

						return pdao.getworklist(pdto);
					}






}
