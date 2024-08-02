package com.sist.withSports.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.SpRev;
import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpLike;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.model.SpRevFile;
import com.sist.withSports.model.SpRevReply;
import com.sist.withSports.model.SpPromFile;

@Repository("BoardDao")
public interface BoardDao 
{

	public List<SpRev> SpRevList(SpRev spRev);
	public long SpRevListCount(SpRev spRev);
	public int SpRevReadCount(long revSeq);
	
	public SpRev SpRevSelect(long revSeq);
	public int SpRevInsert(SpRev spRev);
	public int SpRevUpdate(SpRev spRev);
	public int SpRevDelete(long revSeq);
	
	public SpRevFile SpRevFileSelect(long revSeq);
	public int SpRevFileInsert(SpRevFile spRevFile);
	public int SpRevFileDelete(long revSeq);
	
	public List<SpLike> SpLikeList(SpLike spLike);
	public long SpLikeCount(SpLike spLike);
	
	public List<SpRevReply> SpRevReplyList(SpRevReply spRevReply);
	public long SpRevReplyListCount(SpRevReply spRevReply);
	
	public SpRevReply SpRevReplySelect(long replySeq);
	public SpRevReply SpRevReplyGroupOrderSelect(long replySeq);
	
	public int SpRevReplyInsert(SpRevReply spRevReply);
	public int SpRevReplyCommentInsert(SpRevReply spRevReply);
	public int SpRevReplyUpdate(SpRevReply spRevReply);
	public int SpRevReplyDelete(long revSeq);

//-----------------------------------------------------------	
	
	public List<SpProm> SpPromList(SpProm spProm);	
	public long SpPromListCount(SpProm spProm);
	public int SpPromReadCount(long promSeq);
	
	public SpProm SpPromSelect(long promSeq);
	public int SpPromInsert(SpProm spProm);
	public int SpPromUpdate(SpProm spProm);
	
	public SpPromFile SpPromFileSelect(long promSeq);
	public int SpPromFileInsert(SpPromFile SpPromFile);
	public int SpPromFileDelete(long promSeq);

	public SpLike SpPromViewLikeSelect(long promSeq, String nmId);
	public int SpPromViewLikeInsert(SpLike spLike);
	public int SpPromViewLikeDelete(SpLike spLike);
	public int SpPromViewLikeCntInsertUpdate(SpLike spLike);
	public int SpPromViewLikeCntDeleteUpdate(SpLike spLike);
	
	public int SpPromViewJoinInsertCntUpdate(SpProm spProm);
	public int SpPromViewJoinDeleteCntUpdate(SpProm spProm);
	
	public List<SpJoinApprove> coMyPagePlayListSelect(SpJoinApprove spJoinApprove);
	public long coMyPagePlayListCount(SpJoinApprove spJoinApprove);
}
