package com.sist.withSports.model;

import java.io.Serializable;

public class SpJoin implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long promSeq;
    private String nmId;
    private String payDate;
    
    public SpJoin()
    {
        promSeq = 0;
        nmId = "";
        payDate = "";
    }
    
	public long getPromSeq() {
		return promSeq;
	}
	public void setPromSeq(long promSeq) {
		this.promSeq = promSeq;
	}
	public String getNmId() {
		return nmId;
	}
	public void setNmId(String nmId) {
		this.nmId = nmId;
	}
	public String getPayDate() {
		return payDate;
	}
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
    
    
    
    
    
    
}
