package org.zerock.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	
	private NoticeService service;
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list 요청 실행"+cri);
		
		List<NoticeVO> list=service.getList(cri);
		model.addAttribute("list",list);
		
		int total=service.getTotal(cri);
		log.info("전체갯수:"+total);
		
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);
	}
	
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(NoticeVO notice,RedirectAttributes rttr) {
		log.info("====================");
		log.info("등록 요청 실행:"+notice);
		
		service.register(notice);
		rttr.addFlashAttribute("result",notice.getBno());
		
		return "redirect:/notice/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(Long bno,Model model,
			@ModelAttribute("cri") Criteria cri) {
		log.info("/get(글읽기) 또는 /modify(글수정) 요청");
		
		NoticeVO notice=service.get(bno);
		model.addAttribute("notice",notice);
	}
	
	@PreAuthorize("principal.username==#notice.writer")
	@PostMapping("/modify")
	public String modify(NoticeVO notice,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri) {
		log.info("modify:"+notice);
		log.info("cri:"+cri);
				
		if(service.modify(notice)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/notice/list"+cri.getListLink();
	}
	
	@PreAuthorize("principal.username==#writer")
	@PostMapping("/remove")
	public String remove(Long bno,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri,String writer) {		
		log.info("삭제처리요청..."+bno);
				
		return "redirect:/notice/list"+cri.getListLink();
	}
	
}
