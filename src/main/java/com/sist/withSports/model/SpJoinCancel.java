package com.sist.withSports.model;

import java.io.Serializable;
import java.util.Date;

public class SpJoinCancel implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String cid;
	private String tid;
	
	private String partnerOrderId;
	private String partnerUserId;
	
	private String itemCode;
	private String itemName;
	
	private int cancelTotalAmount;
	private int cancelTaxFreeAmount;
	
	private Date canceledAt;
	
	private long startRow;
	private long endRow;
	
	public SpJoinCancel()
	{
		cid = "";
		tid = ""; 
		
		partnerOrderId = "";
		partnerUserId = "";
		
		itemCode = "";
		itemName = "";
		
		cancelTotalAmount = 0;
		cancelTaxFreeAmount = 0;
		
		canceledAt = null;
		
		startRow = 0;
		endRow = 0;
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

	public String getPartnerOrderId() {
		return partnerOrderId;
	}

	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}

	public String getPartnerUserId() {
		return partnerUserId;
	}

	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getCancelTotalAmount() {
		return cancelTotalAmount;
	}

	public void setCancelTotalAmount(int cancelTotalAmount) {
		this.cancelTotalAmount = cancelTotalAmount;
	}

	public int getCancelTaxFreeAmount() {
		return cancelTaxFreeAmount;
	}

	public void setCancelTaxFreeAmount(int cancelTaxFreeAmount) {
		this.cancelTaxFreeAmount = cancelTaxFreeAmount;
	}

	public Date getCanceledAt() {
		return canceledAt;
	}

	public void setCanceledAt(Date canceledAt) {
		this.canceledAt = canceledAt;
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
