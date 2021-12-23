package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ProductVO;
import org.zerock.service.AdminService;
import org.zerock.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	@Autowired
	private AdminService service;
	private ProductService productservice;
	
	@Autowired
	private PasswordEncoder encoder;
		
	///////////////////////////////////관리자모드/////////////////////////////////////////////
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/admin")
	public void admin() {
		
	}
	
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/stackupdate")
	public void stackupdate( Criteria cri,Model model) {
		log.info("재고변경");
		log.info("재고변경검색어"+cri);
		List<ProductVO> list=productservice.getListAdmin(cri);
		log.info("재고변경"+list);
		model.addAttribute("list", list);
		
		
		int total = service.getTotal(cri);
		log.info("전체 개수: "+total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
	}
	

	
	
	@GetMapping("/stackup")
	public String stackmodify(int bno,String update_stack,Model model) {
		log.info("재고변경시도"+bno);
		log.info("재고변경시도"+update_stack);
		service.updatestack(bno, update_stack);
		log.info("재고변경시도완료");
		return "redirect:/admin/stackupdate";
	}
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/memberList")
	public void memberList(Model model, Criteria cri) {
		log.info("admin..memberList*****************");
		List<MemberVO> member = service.memberList(cri);
		model.addAttribute("member", member);
		
		int total = service.getTotal(cri);
		log.info("전체 개수: "+total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
	}
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/getMember")
	public void get(String userid, Model model) {
		log.info("정보수정 페이지");
		List<MemberVO> info = service.getMember(userid);
		log.info("service.getList(userid): "+info);
		model.addAttribute("info",info);
	}
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/shoplist")
	public void shoplist(Criteria cri,Model model) {
		log.info("=======================================asdfsadfsadf==================");
		List<OrderVO> list=service.getorder(cri);
		log.info("order list"+list);
		model.addAttribute("list",list);
		
		int total=service.getTotalCountCart(cri);
		log.info("전체갯수:"+total);
		
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);

	}
	
	@PreAuthorize("principal.username=='admin'")
	@PostMapping("/modify")
	@Transactional
	public String update(MemberVO member, RedirectAttributes rttr) {
		log.info("정보수정 요청");
		String userpw = encoder.encode(member.getUserpw());
		
		member.setUserpw(userpw);
				
		log.info("인코딩 후"+member);
		
		service.modify(member);
				
		return "redirect:/admin/getMember?userid="+member.getUserid();
	}
	
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/delivery")
	public String delivery(int ordernum,Criteria cri,Model model) {
		log.info("배송상태 변경"+ordernum);
		service.delivery(ordernum);
		log.info("배송상태 변경완료");
		
		int total=service.getTotalCountCart(cri);
		log.info("전체갯수:"+total);
		
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);
		return "redirect:/admin/shoplist?"+cri.getListLink();
	}
	
	
	@PreAuthorize("principal.username=='admin'")
	@GetMapping("/cansel")
	public String cansel(int ordernum,Criteria cri,Model model) {
		log.info("배송 취소"+ordernum);
		service.cansel(ordernum);
		log.info("배송상태 변경완료");
		
		int total=service.getTotalCountCart(cri);
		log.info("전체갯수:"+total);
		
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);
		return "redirect:/admin/shoplist?"+cri.getListLink();
	}
}
