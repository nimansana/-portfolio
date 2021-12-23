package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
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
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ProductAttachVO;
import org.zerock.domain.ProductVO;
import org.zerock.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
@AllArgsConstructor
public class ProductBoardController {
	
	private ProductService service;
	
	@GetMapping("/home")
	public void readType(Model model) {
		List<ProductVO> typeA = service.getTypeA();
		log.info("삭제전 데이터: "+typeA);
		int i = 0;
		int j = 0;
		while (i < typeA.size()) {
			j = typeA.size() - 1;
			
			while (j > i) {
				if (typeA.get(i).getBno() == typeA.get(j).getBno()) {
					typeA.remove(j);
				} 
				j -= 1;
			}
			i += 1;
		}
		
		int size = typeA.size();
		while(size>=10) {
			typeA.remove(size-1);
			size-=1;
		}
		
		List<ProductVO> typeB = service.getTypeB();
		
		while (i < typeB.size()) {
			j = typeB.size() - 1;
			
			while (j > i) {
				if (typeB.get(i).getBno() == typeB.get(j).getBno()) {
					typeB.remove(j);
				} 
				j -= 1;
			}
			i += 1;
		}
		size = typeB.size();
		while(size>=10) {
			typeB.remove(size-1);
			size-=1;
		}
		
		List<ProductVO> typeC = service.getTypeC();
		
		while (i < typeC.size()) {
			j = typeC.size() - 1;
			
			while (j > i) {
				if (typeC.get(i).getBno() == typeC.get(j).getBno()) {
					typeC.remove(j);
				} 
				j -= 1;
			}
			i += 1;
		}
		size = typeC.size();
		while(size>=10) {
			typeC.remove(size-1);
			size-=1;
		}
		model.addAttribute("typeA",typeA);
		model.addAttribute("typeB",typeB);
		model.addAttribute("typeC",typeC);
	}

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list 요청 실행");
		
		List<ProductVO> list= service.getListNoPaging();
		
		int i = 0;
		int j = 0;
		while (i < list.size()) {
			j = list.size() - 1;
			while (j > i) {
				if (list.get(i).getBno() == list.get(j).getBno()) {
					list.remove(j);
				} 
				j -= 1;
			}
			i += 1;
		}
		
//		ProductVO dummy = new ProductVO();
//		dummy.setBno(0L);

//		for (int i=list.size()-1; i>=0; i--) {
//			ProductVO i_vo = list.get(i);
//			
//			for(int j=i-1; j>=0; j--) {
//				log.info("i: "+list.get(i));
//				log.info("j: "+list.get(j));
//				ProductVO j_vo = list.get(j);
//				if(i_vo.getBno() == j_vo.getBno()) {
//					log.info("remove: "+list.get(i));
//					list.remove(j);
//					list.add(dummy);
//				}
//			}
//		}
//		for(int i=0; i<list.size(); i++) {
//			if(list.get(i).getBno()==0) {
//				list.remove(i);
//			}
//		}
		
		int total=service.getTotal(cri);
		log.info("전체갯수: "+total);
		PageDTO pageDTO=new PageDTO(cri,total);
		model.addAttribute("pageMaker",pageDTO);
		
		int lastProd = 0;
		log.info("11111");
		if(cri.getPageNum()*cri.getAmount()>total) {
			lastProd=total;
		}else {
			lastProd=cri.getPageNum()*cri.getAmount();
		}
		log.info("22222");
		log.info("pageNum: "+cri.getPageNum());
		log.info("Amount: "+cri.getAmount());
		List<ProductVO> afterList = new ArrayList<ProductVO>();
		log.info("333");
		for(int k=(cri.getPageNum()-1)*cri.getAmount(); k<lastProd; k++) {
			log.info("444");
			afterList.add(list.get(k)); 
		}
		
		model.addAttribute("list",afterList);
		log.info("삭제후 list...: "+afterList);
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(ProductVO board,RedirectAttributes rttr) {
		log.info("====================");
		log.info("등록 요청 실행:"+board);
		
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach->log.info(attach));
		}
		log.info("=====================");
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/product/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/get(글읽기) 또는 /modify(글수정) 요청");

		ProductVO board=service.get(bno);
		log.info("get/modify: "+board);
		model.addAttribute("board",board);
		
		List<ProductVO> files = service.getFile(bno);
		log.info("get/modify(file): "+board);
		model.addAttribute("files",files);
	}
	
	@PreAuthorize("principal.username==#board.writer")
	@PostMapping("/modify")
	public String modify(ProductVO board,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri) {
		log.info("modify:"+board);
		log.info("cri:"+cri);
				
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/product/list"+cri.getListLink();
	}
	
	@PreAuthorize("principal.username==#writer")
	@PostMapping("/remove")
	public String remove(Long bno,RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri,String writer) {		
		log.info("삭제처리요청..."+bno);
		
		List<ProductAttachVO> attachList=service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/product/list"+cri.getListLink();
	}
	
	@GetMapping(value="/getAttachList",
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ProductAttachVO>> getAttachList(Long bno){
		log.info("getAttachList:"+bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	private void deleteFiles(List<ProductAttachVO> attachList) {
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
