package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private Long ordernum;
	private String serialnum;
	private Date orderdate;
	private String state;
	private Long totalprice;
	private String userid;
	private String orderPhone;
	private Long bno;
	private String orderName;
	private String orderaddress1;
	private String orderaddress2;
	private String orderaddress3;
	private String orderaddress4;
	private String orderaddress5;
	private int quantity;
}
