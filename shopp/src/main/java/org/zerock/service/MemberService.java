package org.zerock.service;

import java.util.List;

import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;

public interface MemberService {
	public void register(MemberVO member);
	public List<MemberVO> isId(String userid);
	
	public void modify(MemberVO member);
	public void modifyNoPw(MemberVO member);
	
	public MemberVO read(String userid);
	
	public List<MemberVO> getList(String userid);
	
	public void order(OrderVO order);
	
	
}