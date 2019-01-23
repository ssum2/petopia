package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.InterChartDAO;
import com.final2.petopia.model.PetVO;


@Service
public class ChartService implements InterChartService {
   
	@Autowired
    private InterChartDAO dao;

	//펫uid로 펫정보 가져오기 
	@Override
	public List<PetVO> selectpetlist(int pet_uid) {
		List<PetVO> petlist =dao.selectpetlist(pet_uid);
		return petlist;
	}
	
	//마이페이지에서 처방전 입력하기 
	@Override
	public int insertmychart(HashMap<String, String> mychartmap) {
	  int n= dao.insertmychart(mychartmap);
	  return n;
	}
	//차트 정보 불러오기 
	@Override
	public ChartVO selectchartinfo(int idx) {
		ChartVO chartinfo = dao.selectchartinfo(idx);
		return chartinfo;
	}
	//예약 정보 가져오기 
	@Override
	public   List<HashMap<String,String>> selectreserveinfo(int idx) {
		 List<HashMap<String,String>> maplist= dao.selectreserveinfo(idx);
		return maplist;
	}
    //탭에 넣을 예약번호 알아오기
	@Override
	public int selecttabuid( HashMap<String,Object> paramap) {
		int ruid = dao.selecttabuid(paramap);
		return ruid;
	}

	







}
