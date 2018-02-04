package org.zerock.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.zerock.mapper.boardMapper";
	
	@Override
	public void create(BoardVO vo) throws Exception{
		session.insert(namespace+".create", vo);
	}
	
	@Override
	public BoardVO read(Integer bno) throws Exception{
		return session.selectOne(namespace+".read", bno);
	}
	
	@Override
	public void update(BoardVO vo) throws Exception{
		session.update(namespace+".update", vo);
	}
	
	@Override
	public List<BoardVO> listAll() throws Exception{
		return session.selectList(namespace+".listAll");
	}

	@Override
	public void delete(Integer bno) throws Exception {
		session.delete(namespace+".update", bno);
	}
	
	@Override
	public List<BoardVO> listPage(int page) throws Exception{
		if(page <= 0){
			page = 1;
		}
		page = (page-1)*10;
		
		return session.selectList(namespace + ".listPage", page);
	}
	
	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception{
		return session.selectList(namespace+".listCriteria", cri);
	}
	
//	MyBatis를 이용해서 
	@Override
	public int countPaging(Criteria cri)throws Exception{
		return session.selectOne(namespace+".countPaging", cri);
	}
	
	//동적SQL SearchCriteria가 적용되는 메서드구현
	@Override
	public List<BoardVO> listSearch(SearchCriteria cri)throws Exception{
		
		return session.selectList(namespace+ ".listSearch", cri);
	}
	@Override
	public int listSearchCount(SearchCriteria cri)throws Exception{
		
		return session.selectOne(namespace+ ".listSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		session.update(namespace + ".updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {

		session.update(namespace+".updateViewCnt", bno);
	}
	
	//첨부파일 저장 기능
	@Override
	public void addAttach(String fullName) throws Exception{
		
		session.insert(namespace+".addAttach", fullName);
	}
	
	//첨부파일 시간 순서대로 가져오기
	@Override
	public List<String> getAttach(Integer bno) throws Exception{
		
		return session.selectList(namespace+".getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) throws Exception {

		session.delete(namespace+".deleteAttach", bno);
		
	}

	@Override
	public void replaceAttach(String fullName, Integer bno) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		
		session.insert(namespace+".replaceAttach", paramMap);
		
	}

	
}
