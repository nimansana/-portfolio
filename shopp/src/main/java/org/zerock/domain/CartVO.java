package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	private Long cartnum;
	private String userid;
	private Long bno;
	private int quantity;
	private String state;
	private String uuid;
	private String filename;

////////////////////////추가하는게 좋아보입니다////////////////////////////
	private Date regdate;
//////////////////////////////////////////////////	
}
