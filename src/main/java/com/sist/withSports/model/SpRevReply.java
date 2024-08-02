package com.sist.withSports.model;

import java.io.Serializable;

public class SpRevReply implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long replySeq;
    private long revSeq;
    private String revTitle;
    private String nmId;
    private String nmNickname;
    private String replyContent;
    private long replyGroup;
    private long replyOrder;
    private String replyRegDate;
    private char status;
    
	private long startRow;
	private long endRow;
    
    public SpRevReply()
    {
        replySeq = 0;
        revSeq = 0;
        revTitle = "";
        nmId = "";
        nmNickname = "";
        replyContent = "";
        replyGroup = 0;
        replyOrder = 0;
        replyRegDate = "";
        status = ' ';
        
		startRow = 0;
		endRow = 0;
    }
    
	public long getReplySeq() 
	{
		return replySeq;
	}
	
	public void setReplySeq(long replySeq) 
	{
		this.replySeq = replySeq;
	}
	public long getRevSeq() 
	{
		return revSeq;
	}
	
	public void setRevSeq(long revSeq) 
	{
		this.revSeq = revSeq;
	}
	
	public String getRevTitle()
	{
		return revTitle;
	}

	public void setRevTitle(String revTitle) {
		this.revTitle = revTitle;
	}

	public String getNmId() 
	{
		return nmId;
	}
	
	public void setNmId(String nmId) 
	{
		this.nmId = nmId;
	}
	
	public String getNmNickname() 
	{
		return nmNickname;
	}

	public void setNmNickname(String nmNickname) 
	{
		this.nmNickname = nmNickname;
	}

	public String getReplyContent() 
	{
		return replyContent;
	}
	
	public void setReplyContent(String replyContent)
	{
		this.replyContent = replyContent;
	}
	
	public long getReplyGroup()
	{
		return replyGroup;
	}
	
	public void setReplyGroup(long replyGroup) 
	{
		this.replyGroup = replyGroup;
	}
	
	public long getReplyOrder() 
	{
		return replyOrder;
	}
	public void setReplyOrder(long replyOrder)
	{
		this.replyOrder = replyOrder;
	}
	
	public String getReplyRegDate() 
	{
		return replyRegDate;
	}
	public void setReplyRegDate(String replyRegDate) 
	{
		this.replyRegDate = replyRegDate;
	}
	
	public char getStatus() {
		return status;
	}

	public void setStatus(char status) {
		this.status = status;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
}