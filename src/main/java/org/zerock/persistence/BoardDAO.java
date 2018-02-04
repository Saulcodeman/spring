package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

public interface BoardDAO {

	public void create(BoardVO vo)throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void update(BoardVO vo)throws Exception;
	
	public void delete(Integer bno)throws Exception;
	
	public List<BoardVO> listAll()throws Exception;
	
	//페이징 처리
	public List<BoardVO> listPage(int page)throws Exception;
	
	//리스트 출력
	public List<BoardVO> listCriteria(Criteria cri)
		throws Exception;
	
	//페이징을 위한 SQL문
	public int countPaging(Criteria cri)throws Exception;
	
	//SearchCriteria가 적용되는 메서드 (동적 SQL문을 적용하기 위한)
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//Replycnt + 댓글삭제될때 해당 게시물의 번호를 알아내는 기능을 추가.
	public void updateReplyCnt(Integer bno, int amount)throws Exception;
	
	//조회수 1씩 증가
	public void updateViewCnt(Integer bno) throws Exception;
	
	//첨부파일 정보를 저장하는 기능
	public void addAttach(String fullName) throws Exception;
	
	//특정게시물의 첨부파일을 시간 순서대로 가져오는 SQL문
	public List<String> getAttach(Integer bno)throws Exception;
	
	//게시물 수정 (기존의 첨부파일을 삭제하고 새롭게 추가)
	public void deleteAttach(Integer bno)throws Exception;
	
	public void replaceAttach(String fullName, Integer bno)throws Exception;
}
