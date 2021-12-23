package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//@AllArgsConstructor
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;	//"TCW"
	private String keyword;
	
	public Criteria() {
//		this(1,10);
		this.pageNum = 1;
		this.amount = 15;
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {	//{"T","C","W"}
		return type==null? new String[] {}:type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", pageNum)
				.queryParam("amount", amount)
				.queryParam("type", type)
				.queryParam("keyword", keyword);
		
		return builder.toUriString();
	}
}
