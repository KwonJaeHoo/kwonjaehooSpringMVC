package com.sist.withSports.model;

import java.io.Serializable;

public class SpProm implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long promSeq;
    private String promTitle;
    private String promContent;
    private String promRegDate;
    private String promStatus;
    private String coId;
    private String coName;
    private String coEmail;
    private String coTel;
    
    private String promMoSdate;
    private String promMoEdate;
    private String promCoSdate;
    private String promCoEdate;
    private String promCate;
    private String promAddr;
    private int promPrice;
    private int promJoinCnt;
    private int promLimitCnt;
    private int promReadCnt;
    private int promLikeCnt;
    
    private String promDetailAddress;
    private String promRoadAddress;
    private String promPostCode;
    
	private String searchType;
	private String searchValue;
	private String searchSort;
	
	private long startRow;
	private long endRow;
	
	private SpPromFile spPromFile;
    
    public SpProm()
    {
        promSeq = 0;
        promTitle = "";
        promContent = "";
        promRegDate = "";
        promStatus = "";
        coId = "";
        coName = "";
        coEmail = "";
        coTel = "";
        promMoSdate = "";
        promMoEdate = "";
        promCoSdate = "";
        promCoEdate = "";
        promCate = "";
        promAddr = "";
        promPrice = 0;
        promJoinCnt = 0;
        promLimitCnt = 0;
        promReadCnt = 0;
        promLikeCnt = 0;
        
        promDetailAddress = "";
        promRoadAddress = "";
        promPostCode = "";
        
		searchType = "";
		searchValue = "";
		searchSort = "1";
		
		startRow = 0;
		endRow = 0;
		
		spPromFile = null;	
    }

	public long getPromSeq() {
		return promSeq;
	}

	public void setPromSeq(long promSeq) {
		this.promSeq = promSeq;
	}

	public String getPromTitle() {
		return promTitle;
	}

	public void setPromTitle(String promTitle) {
		this.promTitle = promTitle;
	}

	public String getPromContent() {
		return promContent;
	}

	public void setPromContent(String promContent) {
		this.promContent = promContent;
	}

	public String getPromRegDate() {
		return promRegDate;
	}

	public void setPromRegDate(String promRegDate) {
		this.promRegDate = promRegDate;
	}

	public String getPromStatus() {
		return promStatus;
	}

	public void setPromStatus(String promStatus) {
		this.promStatus = promStatus;
	}

	public String getCoId() {
		return coId;
	}

	public void setCoId(String coId) {
		this.coId = coId;
	}

	public String getCoName() {
		return coName;
	}

	public void setCoName(String coName) {
		this.coName = coName;
	}

	public String getCoEmail() {
		return coEmail;
	}

	public void setCoEmail(String coEmail) {
		this.coEmail = coEmail;
	}

	public String getCoTel() {
		return coTel;
	}

	public void setCoTel(String coTel) {
		this.coTel = coTel;
	}

	public String getPromMoSdate() {
		return promMoSdate;
	}

	public void setPromMoSdate(String promMoSdate) {
		this.promMoSdate = promMoSdate;
	}

	public String getPromMoEdate() {
		return promMoEdate;
	}

	public void setPromMoEdate(String promMoEdate) {
		this.promMoEdate = promMoEdate;
	}

	public String getPromCoSdate() {
		return promCoSdate;
	}

	public void setPromCoSdate(String promCoSdate) {
		this.promCoSdate = promCoSdate;
	}

	public String getPromCoEdate() {
		return promCoEdate;
	}

	public void setPromCoEdate(String promCoEdate) {
		this.promCoEdate = promCoEdate;
	}

	public String getPromCate() {
		return promCate;
	}

	public void setPromCate(String promCate) {
		this.promCate = promCate;
	}

	public String getPromAddr() {
		return promAddr;
	}

	public void setPromAddr(String promAddr) {
		this.promAddr = promAddr;
	}

	public int getPromPrice() {
		return promPrice;
	}

	public void setPromPrice(int promPrice) {
		this.promPrice = promPrice;
	}

	public int getPromJoinCnt() {
		return promJoinCnt;
	}

	public void setPromJoinCnt(int promJoinCnt) {
		this.promJoinCnt = promJoinCnt;
	}

	public int getPromLimitCnt() {
		return promLimitCnt;
	}

	public void setPromLimitCnt(int promLimitCnt) {
		this.promLimitCnt = promLimitCnt;
	}

	public int getPromReadCnt() {
		return promReadCnt;
	}

	public void setPromReadCnt(int promReadCnt) {
		this.promReadCnt = promReadCnt;
	}

	public int getPromLikeCnt() {
		return promLikeCnt;
	}

	public void setPromLikeCnt(int promLikeCnt) {
		this.promLikeCnt = promLikeCnt;
	}

	public String getPromDetailAddress() {
		return promDetailAddress;
	}

	public void setPromDetailAddress(String promDetailAddress) {
		this.promDetailAddress = promDetailAddress;
	}

	public String getPromRoadAddress() {
		return promRoadAddress;
	}

	public void setPromRoadAddress(String promRoadAddress) {
		this.promRoadAddress = promRoadAddress;
	}

	public String getPromPostCode() {
		return promPostCode;
	}

	public void setPromPostCode(String promPostCode) {
		this.promPostCode = promPostCode;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public String getSearchSort() {
		return searchSort;
	}

	public void setSearchSort(String searchSort) {
		this.searchSort = searchSort;
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

	public SpPromFile getSpPromFile() {
		return spPromFile;
	}

	public void setSpPromFile(SpPromFile spPromFile) {
		this.spPromFile = spPromFile;
	}
	
}
