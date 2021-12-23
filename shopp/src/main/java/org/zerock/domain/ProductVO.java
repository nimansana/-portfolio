package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	private int replyCnt;
	private int price;
	private String types;
	private String category;
	private String uuid;
	private String filename;
	private int stack;

	private String userid;
	private int cartnum;
	
	private int quantity;

	
	private List<ProductAttachVO> attachList;
}
