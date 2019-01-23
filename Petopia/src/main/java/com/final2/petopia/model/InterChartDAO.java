package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface InterChartDAO {

	List<PetVO> selectpetlist(int idx); //펫 uid로 펫정보 가져오기 
	
	int insertmychart(HashMap<String, String> mychartmap);//마이페이지에서 처방전 입력하기 
	
	ChartVO selectchartinfo(int idx); //차트 정보 불러오기
	
	 List<HashMap<String,String>> selectreserveinfo(int idx); //예약정보 가져오기 

	int selecttabuid( HashMap<String,Object> paramap); //탭에 넣을 예약번호 알아오기


}
