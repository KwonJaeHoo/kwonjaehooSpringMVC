package com.sist.withSports.kakao;

import java.io.Serializable;

public class KakaoPayOrder implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String cid;
	private String partnerOrderId;
	private String partnerUserId;
	private String itemCode;
	private String itemName;
	
	private int quantity;
	private int totalAmount;
	private int taxFreeAmount;
	private int vatAmount;
	
	private String tId; 	// 결제 고유 번호 20자
	private String pgToken;	//결제 승인 요청을 인증하는 토큰, 사용자 결제 수단 선택 완료시
							//approval_url redirection 해줄 때 pgToken을 query string으로 전달
		
	public KakaoPayOrder()
	{
		cid = "";
		partnerOrderId = "";
		partnerUserId = "";
		itemCode = "";
		itemName = "";
		
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;
		
		tId = "";
		pgToken = "";
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public int getVatAmount() {
		return vatAmount;
	}

	public void setVatAmount(int vatAmount) {
		this.vatAmount = vatAmount;
	}

	public String gettId() {
		return tId;
	}

	public void settId(String tId) {
		this.tId = tId;
	}

	public String getPgToken() {
		return pgToken;
	}

	public void setPgToken(String pgToken) {
		this.pgToken = pgToken;
	}
}