package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ProductReplyVO;

public interface ProductReplyMapper {
	
	public int insert(ProductReplyVO vo);
	public ProductReplyVO read(Long rno);
	public int delete(Long rno);
	public int update(ProductReplyVO reply);
	public List<ProductReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	public int getCountByBno(Long bno);
}
