package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterReviewDAO {

	// === 2019.01.28 ==== //
	// *** 리뷰 쓸 병원 리스트 조회 *** //
	int selectTotalCount(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 없는
	int selectTotalCountByPeriod(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 있는
	
	List<HashMap<String, String>> selectHosList(HashMap<String, Integer> paramap); // 병원 리스트 - 기간이 없는
	List<HashMap<String, String>> selectHosListByPeriod(HashMap<String, Integer> paramap);// 병원 리스트 - 기간이 있는
	// === 2019.01.28 ==== //

	// === 2019.01.29 ==== //
	// *** 리뷰 쓰기 *** //
	String selectBizIdxByReservationUID(String reservationUID); // 리뷰를 쓸 기업 번호 알아오기
	int insertReviewByReviewMap(HashMap<String, String> reviewMap); // review 테이블에 insert
	// === 2019.01.29 ==== //
	
}