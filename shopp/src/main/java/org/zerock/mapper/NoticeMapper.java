package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;

public interface NoticeMapper {

	public List<NoticeVO> getList();	
	public List<NoticeVO> getListWithPaging(Criteria cri);	
	public void insert(NoticeVO board);	
	public void insertSelectKey(NoticeVO board);
	public NoticeVO read(Long bno);	
	public int delete(Long bno);	
	public int update(NoticeVO board);
	public int getTotalCount(Criteria cri);
	public void updateReplyCnt(
			@Param("bno") Long bno,@Param("amount") int amount);
}
