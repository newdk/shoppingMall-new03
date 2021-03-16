package com.shoppingMall.board.vo;

import java.util.Date;

public class QnaVO {

	private int bno;		//문의글 번호
	private String title;	//문의글 제목
	private String content;	//문의글 내용
	private String writer;	//문의글 작성자
	private Date regdate;	//문의글 등록일
	private int hit;		//문의글 조회수
	//추가
	
	
	
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
}