package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService{

	@Setter(onMethod_=@Autowired)
	private NoticeMapper mapper;
	
	@Override
	public NoticeVO get(Long bno) {
		log.info("번호로 조회하기(service)..."+bno);
		return mapper.read(bno);
	}
	
	@Override
	public List<NoticeVO> getList(Criteria cri) {
		log.info("테이블가져오기(service): "+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("전체갯수 조회");
		return mapper.getTotalCount(cri);
	}


	@Override
	public void register(NoticeVO notice) {
		log.info("등록처리(service)..."+notice);
		
		mapper.insertSelectKey(notice);
		
	}


	@Override
	public boolean modify(NoticeVO notice) {
		log.info("수정처리(service)..."+notice);
		
		boolean modifyResult=mapper.update(notice)==1;

		return modifyResult;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("삭제 처리(service)..."+bno);
		
		return mapper.delete(bno)==1;
	}

		
}
