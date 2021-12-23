package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;

public interface AdminService {
	public List<MemberVO> memberList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<MemberVO> getMember(String userid);
	
	public void modify(MemberVO member);
	
	public List<MemberVO> getAuth(String userid);
	////////////////추가
	public List<OrderVO> getorder(Criteria cri);
	
	public int getTotalCountCart(Criteria cri);
	
	public void delivery(int ordernum);
	
	public void cansel(int ordernum);
	
	public void updatestack(@Param("bno") int bno,@Param("update_stack") String update_stack);
	
}