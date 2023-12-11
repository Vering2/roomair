package com.itwillbs.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PerformanceDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.WorkOrderDTO;
import com.itwillbs.service.PerformanceService;

import java.text.SimpleDateFormat;
import java.util.Date;

@Repository
public class WorkOrderDAO {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderDAO.class);

	private static final String NAMESPACE = "com.itwillbs.mappers.workorderMapper";

	@Autowired
	private SqlSession sqlSession;

	// 작업지시 전체 목록

	public List<WorkOrderDTO> readAllWorkOrder(RequirementPageDTO pdto) throws Exception {
		logger.debug("##### DAO: readAllWorkOrder() 호출");

		return sqlSession.selectList(NAMESPACE + ".allWorkOrder", pdto);
	} // readAllWorkOrder()

	public List<RawmaterialsDTO> checkStock(WorkOrderDTO dto) throws Exception {
		String prodCode = dto.getProdCode();
		List<RequirementDTO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prodCode);
		/* System.out.println(prodCode+"뭔값일까"); */
		List<StockDTO> stockList = new ArrayList<>();

		List<RawmaterialsDTO> shortages = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prodCode);
		System.out.println(stockList);

		for (int i = 0; i < reqList.size(); i++) {
			RequirementDTO reqDTO = reqList.get(i);
			System.out.println(reqDTO + "reqDTO값뭔데");
			StockDTO stockDTO = stockList.get(i);
			System.out.println(stockDTO + "stockDTO값뭔데");
			int workAmount = dto.getWorkAmount();
			System.out.println(dto.getWorkAmount() + "wrokAmount값은");
			System.out.println(reqDTO.getReqAmount() + "reqAmount값은");
			int reqAmount = Integer.parseInt(reqDTO.getReqAmount());

			int requiredAmount = workAmount * reqAmount;
			int availableStock = stockDTO.getStockCount();
			System.out.println(stockDTO.getStockCount() + "getStockCount()값은");
			System.out.println(availableStock + "availableStock값은");
			if (availableStock < requiredAmount) {
				int shortageAmount = requiredAmount - availableStock;
				RawmaterialsDTO shortageDTO = new RawmaterialsDTO();
				shortageDTO.setRawCode(reqDTO.getRawCode());
				shortageDTO.setShortageAmount(shortageAmount);
				shortages.add(shortageDTO);
				System.out.println(shortages + "shortages값은");
			}
		}

		return shortages;
	}

	// 작업지시 등록

	public int insertWorkOrder(WorkOrderDTO dto) throws Exception {
		logger.debug("##### DAO: insertWorkOrder() 호출");

		int rawExist = 0;

		// DB 처리 위해 완제품 코드 저장
		String prodCode = dto.getProdCode();

		// 원자재 소요량 목록
		List<RequirementDTO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prodCode);

		// 해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockDTO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prodCode);
		logger.debug("##### DAO: 완제품에 필요한 원자재 재고 유무 " + stockList.size());

		// 있으면 원자재 재고수와 지시수량*원자재 소요량 비교 (반복문)
		if (stockList.size() > 0) {
			// 지시수량
			int workAmount = dto.getWorkAmount();

			int minus = 0;
			boolean check = true;

			for (int i = 0; i < stockList.size(); i++) {

				String rawCode = stockList.get(i).getRawCode();
				logger.debug("##### DAO 원자재 코드 = " + rawCode);

				// 원자재 재고
				int rawStock = stockList.get(i).getStockCount();
				logger.debug("##### DAO 원자재 재고 = " + rawStock);
				// 원자재 소요량
				int reqAmount = Integer.parseInt(reqList.get(i).getReqAmount());
				// 지시수량*원자재소요량
				minus = workAmount * reqAmount;
				logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);

				if (rawStock - minus < 0) {
					// 원자재 재고 - 지시수량*원자재 소요량 < 0
					// -> 작업지시 등록 불가
					check = false;
					break;
				}
			} // for(stockList)

			if (check) {
				for (int i = 0; i < stockList.size(); i++) {

					String rawCode = stockList.get(i).getRawCode();
					logger.debug("##### DAO 원자재 코드 = " + rawCode);

					// 원자재 재고
					int rawStock = stockList.get(i).getStockCount();
					logger.debug("##### DAO 원자재 재고 = " + rawStock);
					// 원자재 소요량
					int reqAmount = Integer.parseInt(reqList.get(i).getReqAmount());
					// 지시수량*원자재소요량
					minus = workAmount * reqAmount;
					logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);

					if (rawStock - minus >= 0) {
						// 원자재 재고 - 지시수량*원자재 소요량 >= 0
						// -> 원자재 재고 - 지시수량*원자재 소요량
						stockList.get(i).setStockCount(minus);
						sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
						logger.debug("##### DAO: 원자재 재고 차감 완료");

					} // 원자재 재고 차감

				} // for(stockList)

				// 현재 날짜와 시간을 문자열로 변환
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String currentTime = dateFormat.format(new Date());
				System.out.println(dto.getLineCode());

				// 작업 정보와 현재 시간을 연결하여 최종 문자열을 만듭니다.
				String workInfo = "WI" + dto.getLineCode() + currentTime;
				System.out.println(workInfo);
				dto.setWorkInfo(workInfo);
				// 작업지시 등록
				int result = sqlSession.insert(NAMESPACE + ".insertWorkOrder", dto);
				logger.debug("##### DAO: insert 결과 ====> " + result);

				// 라인상태 변경
				String lineCode = getLineCode();
				sqlSession.update(NAMESPACE + ".updateLine", lineCode);

				rawExist = 1;
			} // if(원자재 모두 있을 때만)

		} else {
			// 없으면
			// -> 작업지시 등록 불가
			logger.debug("##### DAO: 원자재 재고 없음");

//			return rawExist;
		} // if(완제품에 필요한 원자재 재고 있없)

		return rawExist;
	} // insertWorkOrder()

	// 작업지시 등록 - 1차공정 사용 가능 라인코드 가져오기

	public String getLineCode() throws Exception {
		logger.debug("##### DAO: getLineCode() 호출");

		String lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine");
		logger.debug("##### DAO: lineCode ===> " + lineCode);

		// dto.getWorkInfo() 메서드에서 작업 정보를 가져오는 로직을 가정

		return lineCode;
	} // getLineCode()

	// 작업지시 삭제

	public void deleteWorkOrder(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteWorkOrder() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;
		while (it.hasNext()) {
			String workCode = it.next();
			System.out.println(workCode + "워크코드값은");
			sqlSession.update(NAMESPACE + ".lineUseDY", workCode);

			result += sqlSession.delete(NAMESPACE + ".deleteWorkOrder", workCode);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);
	} // deleteWorkOrder()

	// 특정 작업지시 조회

	public WorkOrderDTO readWorkOrder(String workCode) throws Exception {
		logger.debug("##### DAO: readWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".readWorkOrder", workCode);
	} // readWorkOrder()

	// 작업지시 수정

	public int updateWorkOrder(WorkOrderDTO udto) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");

		int rawExist = 0;

		// (udto 지시수량 - 기존컬럼 지시수량) 만큼 재고수량에서 차감
		int originQt = readWorkOrder(udto.getWorkCode()).getWorkAmount();
		String prodCode = udto.getProdCode();

		// 원자재 소요량 목록
		List<RequirementDTO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prodCode);

		// 해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockDTO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prodCode);

		// 있으면 원자재 재고수와 (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 비교 (반복문)
		if (stockList.size() > 0) {
			// (udto 지시수량 - 기존컬럼 지시수량)
			int workAmount = udto.getWorkAmount() - originQt;

			int minus = 0;
			boolean check = true;

			for (int i = 0; i < stockList.size(); i++) {

				String rawCode = stockList.get(i).getRawCode();
				logger.debug("##### DAO 원자재 코드 = " + rawCode);

				// 원자재 재고
				int rawStock = stockList.get(i).getStockCount();
				logger.debug("##### DAO 원자재 재고 = " + rawStock);
				// 원자재 소요량
				int rawReq = Integer.parseInt(reqList.get(i).getReqAmount());
				// (udto 지시수량 - 기존컬럼 지시수량)*원자재소요량
				minus = workAmount * rawReq;
				logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);

				if (rawStock - minus < 0) {
					// 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 < 0
					// -> 작업지시 수정 불가
					check = false;
					break;
				}
			} // for(stockList)

			if (check) {
				for (int i = 0; i < stockList.size(); i++) {

					String rawCode = stockList.get(i).getRawCode();
					logger.debug("##### DAO 원자재 코드 = " + rawCode);

					// 원자재 재고
					int rawStock = stockList.get(i).getStockCount();
					logger.debug("##### DAO 원자재 재고 = " + rawStock);
					// 원자재 소요량
					int rawReq = Integer.parseInt(reqList.get(i).getReqAmount());
					// (udto 지시수량 - 기존컬럼 지시수량)*원자재소요량
					minus = workAmount * rawReq;
					logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);

					if (rawStock - minus >= 0) {
						// 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 >= 0
						// -> 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량
						stockList.get(i).setStockCount(minus);
						sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
						logger.debug("##### DAO: 원자재 재고 차감 완료");

						rawExist = 1;
					} // 재고차감

				} // for(stockList)

				// 작업지시 수정
				int result = sqlSession.update(NAMESPACE + ".updateWorkOrder", udto);
				logger.debug("##### DAO: update 결과 ===> " + result);
			} // if(원자재 모두 있을 때만)

		} else {
			// 없으면
			// -> 작업지시 수정 불가
			logger.debug("##### DAO: 원자재 재고 없음");
		} // if(완제품에 필요한 원자재 재고 있없)

		return rawExist;
	} // updateWorkOrder()

	// 작업지시 검색

	public List<WorkOrderDTO> selectWorkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("##### DAO: selectWorkOrder() 호출");

		List<WorkOrderDTO> searchList = sqlSession.selectList(NAMESPACE + ".searchWorkOrder", search);
		logger.debug("##### DAO: search 결과 ===> " + searchList);

		return searchList;
	} // selectWorkOrder()

	// 작업지시 전체 수

	public int getTotalWorkOrder() throws Exception {
		logger.debug("##### DAO: getTotalWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".workOrderAllCnt");
	} // getTotalWorkOrder()

	// 작업지시 검색 수

	public int getSearchWOrkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("#####DAO: getSearchWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".searchWorkOrderCnt", search);
	} // getSearchWorkOrder()

	// 작업지시 현재 작업 공정 변경

	public String updateStatus(WorkOrderDTO dto) throws Exception {
		logger.debug("##### DAO: updateStatus() 호출");

		String lineCode = "";
		String workProcess = dto.getWorkProcess();
		if (workProcess.equals("1차공정")) {
			lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine2");
			if (lineCode != null) {
				sqlSession.update(NAMESPACE + ".updateStatus", dto);

				sqlSession.update(NAMESPACE + ".lineUseY", dto.getLineCode());
				sqlSession.update(NAMESPACE + ".updateLine", lineCode);
				System.out.println(lineCode);
				// dto.getWorkInfo() 메서드에서 작업 정보를 가져오는 로직을 가정
				String workInfo1 = dto.getWorkInfo();
				System.out.println(dto.getWorkInfo());

				// 현재 날짜와 시간을 문자열로 변환
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String currentTime = dateFormat.format(new Date());

				// 작업 정보와 현재 시간을 연결하여 최종 문자열을 만듭니다.
				String workInfo = workInfo1 + lineCode + currentTime;
				System.out.println(workInfo);
				dto.setWorkInfo(workInfo);
				dto.setLineCode(lineCode);
				sqlSession.update(NAMESPACE + ".updateInfo", dto);

			}
		} else if (workProcess.equals("2차공정")) {
			lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine3");
			if (lineCode != null) {
				sqlSession.update(NAMESPACE + ".updateStatus", dto);
				sqlSession.update(NAMESPACE + ".lineUseY", dto.getLineCode());
				sqlSession.update(NAMESPACE + ".updateLine", lineCode);
				// dto.getWorkInfo() 메서드에서 작업 정보를 가져오는 로직을 가정
				System.out.println(lineCode);
				System.out.println(dto.getWorkInfo());
				String workInfo1 = dto.getWorkInfo();

				// 현재 날짜와 시간을 문자열로 변환
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String currentTime = dateFormat.format(new Date());

				// 작업 정보와 현재 시간을 연결하여 최종 문자열을 만듭니다.
				String workInfo = workInfo1 + lineCode + currentTime;
				System.out.println(workInfo);
				dto.setWorkInfo(workInfo);
				dto.setLineCode(lineCode);
				sqlSession.update(NAMESPACE + ".updateInfo", dto);

			}
		} else {

			sqlSession.update(NAMESPACE + ".lineUseY", dto.getLineCode());
			sqlSession.update(NAMESPACE + ".updateStatus", dto);
			// dto.getWorkInfo() 메서드에서 작업 정보를 가져오는 로직을 가정
			System.out.println(lineCode);
			System.out.println(dto.getWorkInfo());
			String workInfo = dto.getWorkInfo();

			// 현재 날짜와 시간을 문자열로 변환
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			String currentTime = dateFormat.format(new Date());

			SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMMddHHmmss");
			String currentTime1 = dateFormat1.format(new Date());

			PerformanceDTO perfDTO = new PerformanceDTO();
			String perfCode = "PF" + currentTime1;

			perfDTO.setPerfCode(perfCode);
			perfDTO.setPerfDate(currentTime);
			perfDTO.setProdCode(dto.getProdCode());
			perfDTO.setWorkCode(dto.getWorkCode());
			System.out.println(perfDTO);

			sqlSession.insert(NAMESPACE + ".perfinsert", perfDTO);

			lineCode = "마감";

		}
		return lineCode;
	} // updateStatus()

	public List<Map<String, Object>> getWorkOrderSearchExcel(HashMap<String, Object> searchParams) {
		return sqlSession.selectList(NAMESPACE + ".getWorkOrderSearchExcel", searchParams);
	}

	public List<Map<String, Object>> getWorkOrderAllExcel() {
		return sqlSession.selectList(NAMESPACE + ".getWorkOrderAllExcel");
	}

} // WorkOrderDAO
