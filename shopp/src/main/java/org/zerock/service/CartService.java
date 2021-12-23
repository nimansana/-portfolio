package org.zerock.service;

import java.util.List;

import org.zerock.domain.CartVO;
import org.zerock.domain.Criteria;

public interface CartService {
	public void register(CartVO board);
	public CartVO get(Long bno);
	//public boolean modify(CartVO board);
	public boolean remove(int cartnum);
	public List<CartVO> getList(String userid);
	public int getTotal(Criteria cri);
	public int Alreadyregister(CartVO board);	
}
