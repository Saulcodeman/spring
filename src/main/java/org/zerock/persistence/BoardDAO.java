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
	
	//����¡ ó��
	public List<BoardVO> listPage(int page)throws Exception;
	
	//����Ʈ ���
	public List<BoardVO> listCriteria(Criteria cri)
		throws Exception;
	
	//����¡�� ���� SQL��
	public int countPaging(Criteria cri)throws Exception;
	
	//SearchCriteria�� ����Ǵ� �޼��� (���� SQL���� �����ϱ� ����)
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//Replycnt + ��ۻ����ɶ� �ش� �Խù��� ��ȣ�� �˾Ƴ��� ����� �߰�.
	public void updateReplyCnt(Integer bno, int amount)throws Exception;
	
	//��ȸ�� 1�� ����
	public void updateViewCnt(Integer bno) throws Exception;
	
	//÷������ ������ �����ϴ� ���
	public void addAttach(String fullName) throws Exception;
	
	//Ư���Խù��� ÷�������� �ð� ������� �������� SQL��
	public List<String> getAttach(Integer bno)throws Exception;
	
	//�Խù� ���� (������ ÷�������� �����ϰ� ���Ӱ� �߰�)
	public void deleteAttach(Integer bno)throws Exception;
	
	public void replaceAttach(String fullName, Integer bno)throws Exception;
}
