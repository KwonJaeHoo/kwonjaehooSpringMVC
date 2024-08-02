package com.sist.withSports.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpJoinCancel;

@Repository("KakaoDao")
public interface KakaoDao 
{
	
	public List<SpJoinApprove> KakaoApproveList(SpJoinApprove spJoinApprove);
	public long KakaoApproveCount(SpJoinApprove spJoinApprove);
	
	public List<SpJoinCancel> KakaoCancelList(SpJoinCancel spJoinCancel);
	public long KakaoCancelCount(SpJoinCancel spJoinCancel);
	
	public SpJoinApprove KakaoapproveSelect(String partnerOrderId, String partnerUserId);
	
	public int KakaoApproveInsert(SpJoinApprove spJoinApprove);
	public int KakaoApproveDelete(SpJoinApprove spJoinApprove);
	
	public int KakaoCancelInsert(SpJoinCancel spJoinCancel);
}