package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeReplyPageDTO;
import org.zerock.domain.NoticeReplyVO;
import org.zerock.service.NoticeReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/notice_replies/")
@RestController
@Log4j
@AllArgsConstructor
public class NoticeReplyController {
	
	private NoticeReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new",consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody NoticeReplyVO vo){
		log.info("NoticeReplyVO:"+vo);
		
		int insertCount=service.register(vo);
		
		log.info("답변 추가 count:"+insertCount);
		
		return insertCount==1?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<NoticeReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno){
		
		log.info("목록보기.....");
		Criteria cri=new Criteria(page,10);
		log.info(cri);
		
		NoticeReplyPageDTO NoticeReplyPageDTO=service.getListPage(cri, bno);
		
		return new ResponseEntity<>(NoticeReplyPageDTO,HttpStatus.OK);
	}
	
	@GetMapping(value="/{rno}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<NoticeReplyVO> get(@PathVariable("rno") Long rno){
		
		log.info("내용읽기.....");
				
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username==#vo.replyer")
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(
			@RequestBody NoticeReplyVO vo,
			@PathVariable("rno") Long rno){
		
		log.info("삭제하기.....");
		
		log.info("remove:"+rno);
		log.info("replyer:"+vo.getReplyer());
				
		return service.remove(rno)==1?
				new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("principal.username==#vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json")
	public ResponseEntity<String> modify(
			@RequestBody NoticeReplyVO vo,
			@PathVariable("rno") Long rno){
		
		log.info("rno:"+rno);
		log.info("수정하기:"+vo);
				
		return service.modify(vo)==1?
				new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
