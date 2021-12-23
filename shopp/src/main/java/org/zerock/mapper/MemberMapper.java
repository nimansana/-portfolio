package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	public List<MemberVO> readId(String userid);
	
	public void insert(MemberVO member);
	
	public void insertAuth(String userid);
	
	public void modify(MemberVO member);
	public void modifyNoPw(MemberVO member);
	
	public List<MemberVO> getList(String userid);
	
	public void order(OrderVO order);

	
}
