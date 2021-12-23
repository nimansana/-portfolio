package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private String email;
	private String phone;
	private String address1;
	private String address2;
	private String address3;
	private String address4;
	private String address5;
	private boolean enabled;
	private String auth;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
}
