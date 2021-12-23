package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeReplyVO;

public interface NoticeReplyMapper {
	
	public int insert(NoticeReplyVO vo);
	public NoticeReplyVO read(Long rno);
	public int delete(Long rno);
	public int update(NoticeReplyVO reply);
	public List<NoticeReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	public int getCountByBno(Long bno);
}
