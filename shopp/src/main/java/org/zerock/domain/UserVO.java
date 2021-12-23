package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private String id;
	private String pw;
	private String name;
	private String email;
	private String address;
	private String phone;
	private Date regdate;
	private List<AuthVO> authList;
}
