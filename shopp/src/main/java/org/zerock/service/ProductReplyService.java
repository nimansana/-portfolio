package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ProductReplyPageDTO;
import org.zerock.domain.ProductReplyVO;

public interface ProductReplyService {
	
	public int register(ProductReplyVO vo);
	public ProductReplyVO get(Long rno);
	public int modify(ProductReplyVO vo);
	public int remove(Long rno);
	public List<ProductReplyVO> getList(Criteria cri,Long bno);
	public ProductReplyPageDTO getListPage(Criteria cri,Long bno);
}