package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeReplyPageDTO;
import org.zerock.domain.NoticeReplyVO;

public interface NoticeReplyService {
	
	public int register(NoticeReplyVO vo);
	public NoticeReplyVO get(Long rno);
	public int modify(NoticeReplyVO vo);
	public int remove(Long rno);
	public List<NoticeReplyVO> getList(Criteria cri,Long bno);
	public NoticeReplyPageDTO getListPage(Criteria cri,Long bno);
}




