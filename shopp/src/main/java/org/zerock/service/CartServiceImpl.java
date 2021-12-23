package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.CartVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.CartMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CartServiceImpl implements CartService{

	

	@Setter(onMethod_=@Autowired)
	private CartMapper mapper;

	@Override
	public int Alreadyregister(CartVO board) {
		// TODO Auto-generated method stub
		return mapper.Alreadyregister(board);
	}
	
	@Override
	public void register(CartVO board) {
		// TODO Auto-generated method stub
		log.info("register...장바구니 등록");
		mapper.insert(board);
	}

	@Override
	public CartVO get(Long bno) {
		// TODO Auto-generated method stub
		log.info("get...장바구니  한개 가져오기");
		return mapper.read(bno);
	}

	@Override
	public boolean remove(int cartnum) {
		// TODO Auto-generated method stub
		log.info("remove......장바구니 삭제"+cartnum);
		return mapper.delete(cartnum)==1;
	}

	@Override
	public List<CartVO> getList(String userid) {
		// TODO Auto-generated method stub
		log.info("getList...장바구니  userid로 가져오기");
		return mapper.getCartList(userid);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("장바구니 개수");
		return mapper.getTotalCount(cri);
	}
	
	

		
}
