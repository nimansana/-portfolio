package org.zerock.service;

import java.util.List;

import org.zerock.domain.ProductAttachVO;
import org.zerock.domain.ProductVO;
import org.zerock.domain.Criteria;

public interface ProductService {
	public void register(ProductVO board);
	public ProductVO get(Long bno);
	public List<ProductVO> getFile(Long bno);
	public boolean modify(ProductVO board);
	public boolean remove(Long bno);
//	public List<ProductVO> getList();
	public List<ProductVO> getList(Criteria cri);
	public List<ProductVO> getListNoPaging();
	public int getTotal(Criteria cri);
	public List<ProductAttachVO> getAttachList(Long bno);
	
//////////////////HOME//////////////////////
	public List<ProductVO> getTypeA();
	public List<ProductVO> getTypeB();
	public List<ProductVO> getTypeC();
//////////////////HOME//////////////////////
	
//////////////////CART//////////////////////
	public List<ProductVO> get2(String cartUserID);
//////////////////CART//////////////////////
	
//////////////////ORDER//////////////////////
	public ProductVO getorder(String cartnum);
	
	public void updateQuant(int sales, Long bno);
//////////////////ORDER//////////////////////
	
	
	//////////////////////admin 재고변경//////////
	public void stackmodify(int bno,String stack);
	public List<ProductVO> getListAdmin(Criteria cri);
	
}
