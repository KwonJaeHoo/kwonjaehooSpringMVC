package com.sist.withSports.model;

import java.io.Serializable;
import java.util.List;

public class SpRev implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long revSeq;
    private String revTitle;
    private String revContent;
    private String nmId;
    private String nmNickname;
    private long revReadCnt;
    private String revRegDate;
    
	private String searchType;
	private String searchValue;
	private String searchSort;
	
	private long startRow;
	private long endRow;
    
    private SpRevFile spRevFile;
    
    private List<SpRevReply> spRevReplyList = null;
    
    public SpRev()
    {
    	revSeq = 0;
        revTitle = "";
        revContent = "";
        nmId = "";
        nmNickname = "";
        revReadCnt = 0;
        revRegDate = "";
        
		searchType = "";
		searchValue = "";
		searchSort = "1";
		
		startRow = 0;
		endRow = 0;
        
        spRevFile = null;
        
        spRevReplyList = null;
    }

	public long getRevSeq() {
		return revSeq;
	}

	public void setRevSeq(long revSeq) {
		this.revSeq = revSeq;
	}

	public String getRevTitle() {
		return revTitle;
	}

	public void setRevTitle(String revTitle) {
		this.revTitle = revTitle;
	}

	public String getRevContent() {
		return revContent;
	}

	public void setRevContent(String revContent) {
		this.revContent = revContent;
	}

	public String getNmId() {
		return nmId;
	}

	public void setNmId(String nmId) {
		this.nmId = nmId;
	}

	public String getNmNickname() {
		return nmNickname;
	}

	public void setNmNickname(String nmNickname) {
		this.nmNickname = nmNickname;
	}

	public long getRevReadCnt() {
		return revReadCnt;
	}

	public void setRevReadCnt(long revReadCnt) {
		this.revReadCnt = revReadCnt;
	}

	public String getRevRegDate() {
		return revRegDate;
	}

	public void setRevRegDate(String revRegDate) {
		this.revRegDate = revRegDate;
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

	public SpRevFile getSpRevFile() {
		return spRevFile;
	}

	public void setSpRevFile(SpRevFile spRevFile) {
		this.spRevFile = spRevFile;
	}

	public List<SpRevReply> getSpRevReplyList() {
		return spRevReplyList;
	}

	public void setSpRevReplyList(List<SpRevReply> spRevReplyList) {
		this.spRevReplyList = spRevReplyList;
	}
}