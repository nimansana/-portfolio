package org.zerock.service;

import java.util.List;

import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;

public interface NoticeService {
	public void register(NoticeVO board);
	public NoticeVO get(Long bno);
	public boolean modify(NoticeVO board);
	public boolean remove(Long bno);
	public List<NoticeVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
		
}
