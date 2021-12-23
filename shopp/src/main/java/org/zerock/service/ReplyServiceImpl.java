package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeReplyPageDTO;
import org.zerock.domain.NoticeReplyVO;
import org.zerock.mapper.NoticeMapper;
import org.zerock.mapper.NoticeReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements NoticeReplyService{
	
	@Setter(onMethod_=@Autowired)
	private NoticeReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private NoticeMapper noticeMapper;
	
	@Transactional
	@Override
	public int register(NoticeReplyVO vo) {
		log.info("등록....."+vo);
		
		noticeMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public NoticeReplyVO get(Long rno) {
		log.info("읽기....."+rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(NoticeReplyVO vo) {
		log.info("수정....."+vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("삭제....."+rno);
		
		NoticeReplyVO vo=mapper.read(rno);
		noticeMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<NoticeReplyVO> getList(Criteria cri, Long bno) {
		log.info("댓글 목록....."+bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public NoticeReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new NoticeReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}

}
