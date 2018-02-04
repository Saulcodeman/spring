package org.zerock.persistence;

import org.zerock.domain.MessageVO;

public interface MessageDAO {  //메시지에 대한 등록 수정 업데이트만 처리 -> messageMapper

	public void create(MessageVO vo) throws Exception;
	
	public MessageVO readMessage(Integer mid) throws Exception;
	
	public void updateState(Integer mid) throws Exception;
}
