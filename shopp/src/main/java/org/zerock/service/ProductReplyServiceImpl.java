package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ProductReplyPageDTO;
import org.zerock.domain.ProductReplyVO;
import org.zerock.mapper.ProductMapper;
import org.zerock.mapper.ProductReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ProductReplyServiceImpl implements ProductReplyService{
	
	@Setter(onMethod_=@Autowired)
	private ProductReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ProductMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ProductReplyVO vo) {
		log.info("등록....."+vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ProductReplyVO get(Long rno) {
		log.info("읽기....."+rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ProductReplyVO vo) {
		log.info("수정....."+vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("삭제....."+rno);
		
		ProductReplyVO vo=mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ProductReplyVO> getList(Criteria cri, Long bno) {
		log.info("댓글 목록....."+bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ProductReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ProductReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}

}
