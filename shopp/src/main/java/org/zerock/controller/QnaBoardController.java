package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/qna_board/*")
@AllArgsConstructor
public class QnaBoardController {
	
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list 요청 실행"+cri);
		
		List<BoardVO> list=service.getList(cri);
		model.addAttribute("list",list);
		
		int total=service.getTotal(cri);
		log.info("전체갯수:"+total);
		
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board,RedirectAttributes rttr) {
		log.info("====================");
		log.info("등록 요청 실행:"+board);
		
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach->log.info(attach));
		}
		log.info("=====================");
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(Long bno,Model model,
			@ModelAttribute("cri") Criteria cri) {
		log.info("/get(글읽기) 또는 /modify(글수정) 요청");
		
		BoardVO board=service.get(bno);
		model.addAttribute("board",board);
	}
	
	@PreAuthorize("principal.username==#board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri) {
		log.info("modify:"+board);
		log.info("cri:"+cri);
				
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/qna_board/list"+cri.getListLink();
	}
	
	@PreAuthorize("principal.username==#writer")
	@PostMapping("/remove")
	public String remove(Long bno,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri,String writer) {		
		log.info("삭제처리요청..."+bno);
		
		List<BoardAttachVO> attachList=service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/qna_board/list"+cri.getListLink();
	}
	
	@GetMapping(value="/getAttachList",
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList:"+bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList==null || attachList.size()==0) {
			return;
		}
		log.info("delete attach files....................");
		log.info(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file=Paths.get(
						"C:\\upload\\"+attach.getUploadPath()+"\\"+
						attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail=Paths.get(
						"C:\\upload\\"+attach.getUploadPath()+"\\s_"+
						attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error:"+e.getMessage());
			}
		});
	}
}
