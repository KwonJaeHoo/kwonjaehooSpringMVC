package com.sist.withSports.kakao;

import java.io.Serializable;

public class KakaoCanOrder implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String cid;
	private String tid;
	
	private int cancelAmount;
	private int cancelTaxFreeAmount;
	
	public KakaoCanOrder()
	{
		cid = "";
		tid = "";
		cancelAmount = 0;
		cancelTaxFreeAmount = 0;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public int getCancelAmount() {
		return cancelAmount;
	}

	public void setCancelAmount(int cancelAmount) {
		this.cancelAmount = cancelAmount;
	}

	public int getCancelTaxFreeAmount() {
		return cancelTaxFreeAmount;
	}

	public void setCancelTaxFreeAmount(int cancelTaxFreeAmount) {
		this.cancelTaxFreeAmount = cancelTaxFreeAmount;
	}
}
