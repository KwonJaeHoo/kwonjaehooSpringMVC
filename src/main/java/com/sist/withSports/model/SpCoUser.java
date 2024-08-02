package com.sist.withSports.model;

import java.io.Serializable;

public class SpCoUser implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private String coId;
	private String coPwd;
	private String coName;
	private String coCeo;
	private String coNum;
	private String coAddr;
	private String coTel;
	private String coEmail;
	private String coDate;
	private String coStatus;
	
	public SpCoUser()
	{
	    coId = "";
		coPwd = "";
		coName = "";
		coCeo = "";
		coNum = "";
		coAddr = "";
		coTel = "";
		coEmail = "";
		coDate = "";
		coStatus = "";
	}

	public String getCoId() {
		return coId;
	}

	public void setCoId(String coId) {
		this.coId = coId;
	}

	public String getCoPwd() {
		return coPwd;
	}

	public void setCoPwd(String coPwd) {
		this.coPwd = coPwd;
	}

	public String getCoName() {
		return coName;
	}

	public void setCoName(String coName) {
		this.coName = coName;
	}

	public String getCoCeo() {
		return coCeo;
	}

	public void setCoCeo(String coCeo) {
		this.coCeo = coCeo;
	}

	public String getCoNum() {
		return coNum;
	}

	public void setCoNum(String coNum) {
		this.coNum = coNum;
	}

	public String getCoAddr() {
		return coAddr;
	}

	public void setCoAddr(String coAddr) {
		this.coAddr = coAddr;
	}

	public String getCoTel() {
		return coTel;
	}

	public void setCoTel(String coTel) {
		this.coTel = coTel;
	}

	public String getCoEmail() {
		return coEmail;
	}

	public void setCoEmail(String coEmail) {
		this.coEmail = coEmail;
	}

	public String getCoDate() {
		return coDate;
	}

	public void setCoDate(String coDate) {
		this.coDate = coDate;
	}

	public String getCoStatus() {
		return coStatus;
	}

	public void setCoStatus(String coStatus) {
		this.coStatus = coStatus;
	}
	
	
}
