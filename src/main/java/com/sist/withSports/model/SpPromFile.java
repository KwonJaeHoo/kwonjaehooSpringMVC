package com.sist.withSports.model;

import java.io.Serializable;

public class SpPromFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long promSeq;
    private short promFileSeq;
    private String promFileOrgName;
    private String promFileName;
    private String promFileExt;
    private long promFileSize;
    private String promRegDate;
    
    public SpPromFile()
    {
        promSeq = 0;
        promFileSeq = 0;
        promFileOrgName = "";
        promFileName = "";
        promFileExt = "";
        promFileSize = 0;
        promRegDate = "";
    }

	public long getPromSeq() {
		return promSeq;
	}

	public void setPromSeq(long promSeq) {
		this.promSeq = promSeq;
	}

	public short getPromFileSeq() {
		return promFileSeq;
	}

	public void setPromFileSeq(short promFileSeq) {
		this.promFileSeq = promFileSeq;
	}

	public String getPromFileOrgName() {
		return promFileOrgName;
	}

	public void setPromFileOrgName(String promFileOrgName) {
		this.promFileOrgName = promFileOrgName;
	}

	public String getPromFileName() {
		return promFileName;
	}

	public void setPromFileName(String promFileName) {
		this.promFileName = promFileName;
	}

	public String getPromFileExt() {
		return promFileExt;
	}

	public void setPromFileExt(String promFileExt) {
		this.promFileExt = promFileExt;
	}

	public long getPromFileSize() {
		return promFileSize;
	}

	public void setPromFileSize(long promFileSize) {
		this.promFileSize = promFileSize;
	}

	public String getPromRegDate() {
		return promRegDate;
	}

	public void setPromRegDate(String promRegDate) {
		this.promRegDate = promRegDate;
	}
}
