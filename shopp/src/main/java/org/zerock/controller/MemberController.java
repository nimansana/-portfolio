package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CartVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.ProductVO;
import org.zerock.service.CartService;
import org.zerock.service.MemberService;
import org.zerock.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PasswordEncoder encoder;

	@Autowired
	private CartService cartservice;

	
	/////////////////////// 멤버 /////////////////////////////
	@GetMapping("/joinMember")
	public void join(String userid, String isId, Model model) {
		log.info("회원가입 페이지");
		model.addAttribute("userid",userid);
		model.addAttribute("isId",isId);
	}
	
	@PostMapping("/joinMember")
	public String join(MemberVO member, String isId, RedirectAttributes rttr, Model model) {
		log.info(isId);
		if(isId.equals("1")) {
			log.info("isId실행");
			
			List<MemberVO> ids = service.isId(member.getUserid());
			log.info(ids.size());
			
			if(ids.size()>0) {
				return "redirect:/member/joinMember?isId=1";
			}else {
				return "redirect:/member/joinMember?isId=2&userid="+member.getUserid();
			}
			
		}else if(isId.equals("a")) {
			log.info("가입하기...(controller)" + member);
			log.info("userpw:"+member.getUserpw());
			String userpw = encoder.encode(member.getUserpw());
			
			member.setUserpw(userpw);
					
			log.info("인코딩 후"+member);
			
			service.register(member);
					
			rttr.addFlashAttribute("result", member.getUserid());
			
			return "redirect:/";
		}
		else {
			log.info(isId+"실패");
			return "redirect:/";
		}
	}
	
	@PreAuthorize("principal.username==#userid")
	@GetMapping("/getMember")
	public void get(String userid, Model model) {
		log.info("정보수정 페이지");
		List<MemberVO> info = service.getList(userid);
		log.info("service.getList(userid): "+info);
		model.addAttribute("info",info);
	}
	
	@PreAuthorize("principal.username==#member.userid")
	@PostMapping("/modify")
	public String modify(MemberVO member, RedirectAttributes rttr, Model model) {
		log.info("memberController modify...");
		
		if(member.getUserpw()!="") {
			String userpw = encoder.encode(member.getUserpw());
			
			member.setUserpw(userpw);
					
			log.info("인코딩 후: "+member);
			
			service.modify(member);
		}else {
			
			log.info("비밀번호 제외 수정: "+member);
			
			service.modifyNoPw(member);
		}

		return "redirect:/member/getMember?userid="+member.getUserid();
	}
	
	//////////////////////주문 & 장바구니/////////////////////////////
	@GetMapping("/order")
	public void getorder(Long bno, String userid, Model model) {
		log.info("정보수정 페이지");
		List<MemberVO> info = service.getList(userid);
		log.info("service.getList(userid): "+info);
		model.addAttribute("info",info);

		ProductVO board=productService.get(bno);
		model.addAttribute("board",board);
	}
	
	@PostMapping("/order")
	public String order(Long bno, OrderVO order, RedirectAttributes rttr) {
		log.info("주문 요청 실행******************: "+order);
		log.info("주문 요청 실행******************bno: "+bno);
		
		UUID serialnum=UUID.randomUUID();
		
		order.setSerialnum(serialnum.toString());
		order.setBno(bno);
		
		log.info("service진입 전************: "+order);
		
		service.order(order);
		
		return "redirect:/";
	}
	
	//장바구니 목록보기
	@GetMapping("/Cart")
	public void Cart1(Model model, @ModelAttribute("userid") MemberVO member) {
		//유저 아이디 값을 받아온다
		String cartUserID= member.getUserid();
		log.info("장바구니 리스트 보여주기"+cartUserID);
		List<CartVO> list=cartservice.getList(cartUserID);
		log.info("장바구니 리스트 보여주기"+list);
		//장바구니 중복 제거
		List<ProductVO> c_list=productService.get2(cartUserID);
		for (int i=c_list.size()-1; i>=0; i--) {
			ProductVO i_vo = c_list.get(i);
			
			for(int j=i-1; j>=0; j--) {
				ProductVO j_vo = c_list.get(j);
				if(i_vo.getBno() == j_vo.getBno()) {
					c_list.remove(j);
				}
			}
		}
		int i = 0;
		int j = 0;
		while (i < c_list.size()) {
			j = c_list.size() - 1;
			
			while (j > i) {
				if (c_list.get(i).getBno() == c_list.get(j).getBno()) {
					c_list.remove(j);
				} 
				j -= 1;
			}
			i += 1;
		}
		
		log.info("리스트안의값들"+c_list);
		
		model.addAttribute("info",c_list);
		int sum=0;
		for(int k=0;k<list.size();k++) {
			sum += c_list.get(k).getPrice();
		}
		model.addAttribute("sumprice",sum);
	}
	
	/////////////////장바구니결제창//////////////
	@GetMapping("/cartorder")
	public void cartorder(String cartnum,Model model,String quantity) {
		log.info("카트 결제"+cartnum+"길이"+cartnum.length());
		log.info(quantity);
		String [] carnumarray=cartnum.split(",");
		String [] quanin=quantity.split(",");
		log.info("length: "+carnumarray.length);
		//카트넘 값을 carnumarray 으로 리스트로 만들었으니 값을 넣으면된다 String[]이 아니라 volist 해봐야할듯
		List<ProductVO> cartList = new ArrayList<ProductVO>();
		int totalprice=0;
		
		for(int i=0; i<carnumarray.length; i++) {
			log.info(i);
			log.info(carnumarray[i]);
			ProductVO vo_cart = productService.getorder(carnumarray[i]);
			vo_cart.setQuantity(Integer.parseInt(quanin[i]));
			log.info(vo_cart);
			cartList.add(vo_cart);
			
			log.info(cartList);
			totalprice+=(vo_cart.getPrice()*Integer.parseInt(quanin[i]));
			
		}
		
		log.info("리스트"+cartList);
		log.info("totalprice: "+totalprice);
		
		model.addAttribute("info",cartList);
		model.addAttribute("totalprice",totalprice);
	}
	
	
	@PostMapping("/ordercart")
	public String ordercart(String bno, String quantity, OrderVO order,Model model) {
		log.info("bno값 리스트로 오는지?"+bno);
		log.info(quantity);
		log.info(order);
		String [] carnumarray=bno.split(",");
		String [] quan = quantity.split(",");
		//bno를 String으로 받으면 값이 10,11,12 형식으로 와서 리스트에 split으로 ,마다 자른다
		UUID serialnum=UUID.randomUUID();
			for(int i=0;i<carnumarray.length;i++) {
				order.setSerialnum(serialnum.toString());
				order.setBno(Long.parseLong(carnumarray[i]));
				order.setQuantity(Integer.parseInt(quan[i]));
				service.order(order);
				int sales =  order.getQuantity();
				log.info(order);
				log.info(sales);
				log.info(order.getBno());
				productService.updateQuant(sales, order.getBno());
				
			}
			
			return "redirect:/member/Cart?userid="+order.getUserid();
	}
	
	@GetMapping("/deleteCart")
	public String deleteCart(int cartnum,String userid) {
		log.info("장바구니 삭제 ");
		cartservice.remove(cartnum);
		log.info("장바구니 삭제 완료 ");
		return "redirect:/member/Cart?userid="+userid;
	}

	@GetMapping("/duplication")
	public void duplication(Long bno) {
		log.info("장바구니 중복"+bno);
	}
	
	//장바구니에 등록
	@GetMapping("/cart_info")
	public String cart(String userid,Long bno) {
		CartVO cartvo=new CartVO();
		log.info("bno값 들어가는지"+cartvo);
		cartvo.setBno(bno);
		cartvo.setUserid(userid);
		log.info("bno값 들어가는지"+cartvo);
		//장바구니 등록이 중복되는지 확인
		if(cartservice.Alreadyregister(cartvo)==0) {
			cartservice.register(cartvo);
			log.info("장바구니 등록");
		
			return "redirect:/product/get?pageNum=1&amount=15&type=&keyword=&bno="+bno;
		}else {
			return "redirect:/member/duplication?bno="+bno;
		}
	
	}
	
	
	///////////////////////////////////관리자모드/////////////////////////////////////////////
	@GetMapping("/admin")
	public void admin() {
		
	}
	
}
