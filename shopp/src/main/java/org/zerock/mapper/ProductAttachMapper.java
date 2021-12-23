package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ProductAttachVO;

public interface ProductAttachMapper {
	
	public void insert(ProductAttachVO vo);
	public void delete(String uuid);
	public List<ProductAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);
	
	public List<ProductAttachVO> getOldFiles();
}
