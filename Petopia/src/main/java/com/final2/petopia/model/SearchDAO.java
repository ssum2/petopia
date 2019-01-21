package com.final2.petopia.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SearchDAO implements InterSearchDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;	

	
	// 단어를 기준으로 지역명 - 몇건, 병원이름 - 몇건, 약국이름 - 몇건 이런식으로 보여주기
	@Override
	public HashMap<String, Integer> searchCountMap(String searchWord) {
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		
		int addrCnt = sqlsession.selectOne("search.addrCount",searchWord);
		int hsptalCnt = sqlsession.selectOne("search.hsptalCount",searchWord);
		int pharmCnt = sqlsession.selectOne("search.pharmCount",searchWord);
		
		map.put("ADDRCOUNT", addrCnt);
		map.put("HSPTALCOUNT", hsptalCnt);
		map.put("PHARMCOUNT", pharmCnt);
		
		return map;
		
	}

	
	// 검색결과가 1개인 경우(사용자가 병원 또는 약국 이름을 알고 검색 한 경우) 병원 풀네임을 받아 보여주고, 바로 병원 정보로 갈 수 있도록 링크 생성하기
	@Override
	public Biz_MemberVO getFullnameAndIdx(String searchWord) {
		
		Biz_MemberVO bizvo = sqlsession.selectOne("search.getFullnameAndIdx", searchWord);
		
		return bizvo;
	}


	@Override
	public int searchCount(String searchWord) {
		int cnt = sqlsession.selectOne("search.addrCount", searchWord);
		return cnt;
	}

}
