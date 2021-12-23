package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;
import org.zerock.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminMapper mapper;
	
	@Override
	public List<MemberVO> memberList(Criteria cri) {
		log.info("service memberList() 실행");
		return mapper.memberList(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("전체 갯수 세기");
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<MemberVO> getMember(String userid) {
		
		return mapper.getMember(userid);
	}

	@Override
	public void modify(MemberVO member) {
		
		mapper.modify(member);
		mapper.modifyAuth(member);
		
	}
	
	@Override
	public List<MemberVO> getAuth(String userid) {
		
		return mapper.getAuth(userid);
	}

	@Override
	public List<OrderVO> getorder(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getorder(cri);
	}

	@Override
	public int getTotalCountCart(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCountCart(cri);
	}

	@Override
	public void delivery(int ordernum) {
		// TODO Auto-generated method stub
		mapper.delivery(ordernum);
	}

	@Override
	public void cansel(int ordernum) {
		// TODO Auto-generated method stub
		mapper.cansel(ordernum);
	}

	@Override
	public void updatestack(@Param("bno")int bno, @Param("update_stack")String update_stack) {
		// TODO Auto-generated method stub
		mapper.updatestack(bno, update_stack);
	}

	

}
