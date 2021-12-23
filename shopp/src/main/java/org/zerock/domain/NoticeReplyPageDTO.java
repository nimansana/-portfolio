package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class NoticeReplyPageDTO {
	private int replyCnt;
	private List<NoticeReplyVO> list;
}
