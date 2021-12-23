package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.CartVO;
import org.zerock.domain.Criteria;


public interface CartMapper {

//	@Select("select * from tbl_board where bno>0")
	public List<CartVO> getCartList(String userid);	
	public void insert(CartVO board);	
//	public void insertSelectKey(CartVO board);
	public CartVO read(Long bno);	
//	public List<CartVO> readFile(Long bno);
	public int delete(int cartnum);	
	public int update(CartVO board);
	public int getTotalCount(Criteria cri);
	public int Alreadyregister(CartVO board);
//	public void updateReplyCnt(@Param("bno") Long bno,@Param("amount") int amount);

}
