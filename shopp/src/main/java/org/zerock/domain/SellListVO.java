package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SellListVO {
	private Long productnum;
	private String name;
	private String kind;
	private int price;
	private String content;
	private String image;
	private Date regdate;
	private int quantity;
	private String username;
	
	private List<SellListAttachVO> attachList;
	
}
