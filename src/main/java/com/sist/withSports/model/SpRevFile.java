package com.sist.withSports.model;

import java.io.Serializable;

public class SpRevFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long revSeq;
    private short revFileSeq;
    private String revFileOrgName;
    private String revFileName;
    private String revFileExt;
    private long revFileSize;
    private String revRegDate;
    
    public SpRevFile()
    {
    	revSeq = 0;
    	revFileSeq = 0; 
    	revFileOrgName = "";
	    revFileName = "";
	    revFileExt = "";
	    revFileSize = 0;
	    revRegDate = "";
    }

	public long getRevSeq() {
		return revSeq;
	}

	public void setRevSeq(long revSeq) {
		this.revSeq = revSeq;
	}

	public short getRevFileSeq() {
		return revFileSeq;
	}

	public void setRevFileSeq(short revFileSeq) {
		this.revFileSeq = revFileSeq;
	}

	public String getRevFileOrgName() {
		return revFileOrgName;
	}

	public void setRevFileOrgName(String revFileOrgName) {
		this.revFileOrgName = revFileOrgName;
	}

	public String getRevFileName() {
		return revFileName;
	}

	public void setRevFileName(String revFileName) {
		this.revFileName = revFileName;
	}

	public String getRevFileExt() {
		return revFileExt;
	}

	public void setRevFileExt(String revFileExt) {
		this.revFileExt = revFileExt;
	}

	public long getRevFileSize() {
		return revFileSize;
	}

	public void setRevFileSize(long revFileSize) {
		this.revFileSize = revFileSize;
	}

	public String getRevRegDate() {
		return revRegDate;
	}

	public void setRevRegDate(String revRegDate) {
		this.revRegDate = revRegDate;
	}
    
    
}
