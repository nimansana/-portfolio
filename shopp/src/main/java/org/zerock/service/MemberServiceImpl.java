package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;

	@Override
	@Transactional
	public void register(MemberVO member) {
		log.info("register...service"+member);
		
		mapper.insert(member);
		mapper.insertAuth(member.getUserid());
	}
	@Override
	public List<MemberVO> isId(String userid){
		return mapper.readId(userid);
	}

	@Override
	public void modify(MemberVO member) {
		log.info("modify...service"+member);
		
		mapper.modify(member);
		
	}
	@Override
	public void modifyNoPw(MemberVO member) {
		log.info("modifyNoPw...service"+member);
		
		mapper.modifyNoPw(member);
		
	}

	@Override
	public MemberVO read(String userid) {
		log.info("read...service"+userid);
		
		return mapper.read(userid);
		
	}

	@Override
	public List<MemberVO> getList(String userid) {
		
		return mapper.getList(userid);
	}

	@Override
	public void order(OrderVO order) {
		log.info("Order....service: "+order);
		
		mapper.order(order);
		
	}
}