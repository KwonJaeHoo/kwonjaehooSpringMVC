package com.sist.withSports.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.dao.BoardDao;
import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpLike;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.model.SpPromFile;
import com.sist.withSports.model.SpRev;
import com.sist.withSports.model.SpRevFile;
import com.sist.withSports.model.SpRevReply;

@Service("BoardService")
public class BoardService 
{
	private static Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Autowired
	private BoardDao boardDao;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_DIR;
	
	public List<SpRev> SpRevList(SpRev spRev)
	{
		List<SpRev> spRevList = null;
		
		try 
		{
			spRevList = boardDao.SpRevList(spRev);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] (SpRevList) Exception Error" + e);
		}
		
		return spRevList;
	}
	
	
	public long SpRevListCount(SpRev spRev)
	{
		long cnt = 0 ;
		
		try 
		{
			cnt = boardDao.SpRevListCount(spRev);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] (SpRevListCount) Exception Error" + e);
		}
		
		return cnt;
	}
	

	
	//select
	public SpRev SpRevSelect(long revSeq, String ReadCount)
	{
		SpRev spRev = null;
		
		try 
		{		
			if(!StringUtil.equals(ReadCount, "N"))
			{
				boardDao.SpRevReadCount(revSeq);	
			}
			spRev = boardDao.SpRevSelect(revSeq);
			
			if(spRev != null)
			{
				spRev.setSpRevFile(boardDao.SpRevFileSelect(revSeq));		
			}
		} 
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevSelect Exception", e);
		}
		
		return spRev;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpRevInsert(SpRev spRev) throws Exception
	{
		int cnt = 0;

		cnt = boardDao.SpRevInsert(spRev);
		
		if(cnt > 0 && spRev.getSpRevFile() != null)
		{
			spRev.getSpRevFile().setRevSeq(spRev.getRevSeq());
			spRev.getSpRevFile().setRevFileSeq((short)1);
			boardDao.SpRevFileInsert(spRev.getSpRevFile());
		}
		
		return cnt;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpRevUpdate(SpRev spRev) throws Exception
	{
		int cnt = 0;
		
		cnt = boardDao.SpRevUpdate(spRev);
		
		if(cnt > 0)
		{
			SpRevFile spRevFile = boardDao.SpRevFileSelect(spRev.getRevSeq());
			
			if(spRevFile != null)
			{
				if(spRev.getSpRevFile() != null)
				{
					if(StringUtil.equals(spRevFile.getRevFileName(), spRev.getSpRevFile().getRevFileName()))
					{
						return cnt;
					}
					else
					{
						boardDao.SpRevFileDelete(spRevFile.getRevSeq());
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRevFile.getRevFileName());
						
						spRev.getSpRevFile().setRevSeq(spRev.getRevSeq());
						spRev.getSpRevFile().setRevFileSeq((short) 1);
						boardDao.SpRevFileInsert(spRev.getSpRevFile());
					}
				}
				else 
				{
					boardDao.SpRevFileDelete(spRevFile.getRevSeq());
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRevFile.getRevFileName());	
				}
			}
			else if(spRev.getSpRevFile() != null)
			{
				spRev.getSpRevFile().setRevSeq(spRev.getRevSeq());
				spRev.getSpRevFile().setRevFileSeq((short) 1);
				boardDao.SpRevFileInsert(spRev.getSpRevFile());
			}
		}
		
		return cnt;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpRevDelete(SpRev spRev) throws Exception
	{
		int cnt = 0;
		
		if(!spRev.getSpRevReplyList().isEmpty())
		{
			if(boardDao.SpRevReplyDelete(spRev.getRevSeq()) > 0)
			{
				if(spRev.getSpRevFile() != null)
				{
					if(boardDao.SpRevFileDelete(spRev.getRevSeq()) > 0)
					{
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
						
						cnt = boardDao.SpRevDelete(spRev.getRevSeq());	
					}
					else
					{
						throw new Exception();
					}
				}
				else
				{
					cnt = boardDao.SpRevDelete(spRev.getRevSeq());	
				}
			}
		}
		else if(spRev.getSpRevFile() != null)
		{
			if(boardDao.SpRevFileDelete(spRev.getRevSeq()) > 0)
			{
				FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
				
				cnt = boardDao.SpRevDelete(spRev.getRevSeq());	
			}
			else
			{
				throw new Exception();
			}
		}
		else
		{
			cnt = boardDao.SpRevDelete(spRev.getRevSeq());	
		}
		
		return cnt;
	}
	
//-------------------------------------------------------------------------------------
	
	
	
	public List<SpProm> SpPromList(SpProm spProm)
	{
		List<SpProm> spPromList = null;
		
		try 
		{
			spPromList = boardDao.SpPromList(spProm);
			
			if(spPromList != null)
			{
				for(int i = 0; i < spPromList.size(); i++)
				{
					spPromList.get(i).setSpPromFile(boardDao.SpPromFileSelect(spPromList.get(i).getPromSeq()));
				}
			}
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] (SpPromList) Exception Error" + e);
		}
		
		return spPromList;
	}
	
	
	public long SpPromListCount(SpProm spProm)
	{
		long cnt = 0 ;
		
		try 
		{
			cnt = boardDao.SpPromListCount(spProm);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] (SpPromListCount) Exception Error" + e);
		}
		
		return cnt;
	}
	
	
	//select
	public SpProm SpPromSelect(long promSeq, String ReadCount)
	{
		SpProm spProm = null;
		
		try 
		{	
			if(!StringUtil.equals(ReadCount, "N"))
			{
				boardDao.SpPromReadCount(promSeq);	
			}
			
			spProm = boardDao.SpPromSelect(promSeq);
			
			if(spProm != null)
			{
				spProm.setSpPromFile(boardDao.SpPromFileSelect(promSeq));		
			}
		} 
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpPromSelect Exception", e);
		}
		
		return spProm;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpPromInsert(SpProm spProm) throws Exception
	{
		int cnt = 0;

		cnt = boardDao.SpPromInsert(spProm);
		
		if(cnt > 0 && spProm.getSpPromFile() != null)
		{
			spProm.getSpPromFile().setPromSeq(spProm.getPromSeq());
			spProm.getSpPromFile().setPromFileSeq((short)1);
			boardDao.SpPromFileInsert(spProm.getSpPromFile());
		}
		
		return cnt;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpPromUpdate(SpProm spProm) throws Exception
	{
		int cnt = 0;
		
		cnt = boardDao.SpPromUpdate(spProm);
		
		if(cnt > 0)
		{
			SpPromFile spPromFile = boardDao.SpPromFileSelect(spProm.getPromSeq());
			
			if(spPromFile != null)
			{
				if(spProm.getSpPromFile() != null)
				{
					if(StringUtil.equals(spPromFile.getPromFileName(), spProm.getSpPromFile().getPromFileName()))
					{
						return cnt;
					}
					else
					{
						boardDao.SpPromFileDelete(spPromFile.getPromSeq());
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spPromFile.getPromFileName());
						
						spProm.getSpPromFile().setPromSeq(spProm.getPromSeq());
						spProm.getSpPromFile().setPromFileSeq((short) 1);
						boardDao.SpPromFileInsert(spProm.getSpPromFile());
					}
				}
				else 
				{
					boardDao.SpPromFileDelete(spPromFile.getPromSeq());
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spPromFile.getPromFileName());	
				}
			}
			else if(spProm.getSpPromFile() != null)
			{
				spProm.getSpPromFile().setPromSeq(spProm.getPromSeq());
				spProm.getSpPromFile().setPromFileSeq((short) 1);
				boardDao.SpPromFileInsert(spProm.getSpPromFile());
			}
		}
		
		return cnt;
	}
	
	public List<SpLike> SpLikeList(SpLike spLike)
	{
		List<SpLike> spLikeList = null;
		
		try 
		{
			spLikeList = boardDao.SpLikeList(spLike);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - nmListLikeSelect Exception", e);
		}
		
		return spLikeList;
	}
	
	public long SpLikeCount(SpLike spLike)
	{
		long cnt = 0;
		
		try 
		{
			cnt = boardDao.SpLikeCount(spLike);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - nmListLikeCountSelect Exception", e);
		}
		
		return cnt;
	}
	
	
	
	
	public SpLike SpPromViewLikeSelect(long promSeq, String nmId)
	{
		SpLike spLike = null;
		
		try 
		{	
			spLike = boardDao.SpPromViewLikeSelect(promSeq, nmId);
		} 
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpPromViewLikeSelect Exception", e);
		}
		
		return spLike;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpPromViewLikeInsert(SpLike spLike) throws Exception
	{
		int cnt = 0;
		
		cnt = boardDao.SpPromViewLikeInsert(spLike);
		
		if(cnt > 0)
		{
			boardDao.SpPromViewLikeCntInsertUpdate(spLike);
		}
		
		return cnt;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int SpPromViewLikeDelete(SpLike spLike) throws Exception
	{
		int cnt = 0;
		
		cnt = boardDao.SpPromViewLikeDelete(spLike);
		
		if(cnt > 0)
		{
			boardDao.SpPromViewLikeCntDeleteUpdate(spLike);
		}
		return cnt;
	}
	
	
	public int SpPromViewJoinInsertCntUpdate(SpProm spProm)
	{
		int cnt = 0;
		
		try 
		{
			cnt = boardDao.SpPromViewJoinInsertCntUpdate(spProm);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpPromViewJoinCntUpdate Exception", e);
		}
		return cnt;
	}
	
	public int SpPromViewJoinDeleteCntUpdate(SpProm spProm)
	{
		int cnt = 0;
		
		try 
		{
			cnt = boardDao.SpPromViewJoinDeleteCntUpdate(spProm);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpPromViewJoinCntUpdate Exception", e);
		}
		return cnt;
	}
	
	public List<SpRevReply> SpRevReplyList(SpRevReply spRevReply)
	{
		List<SpRevReply> spRevReplyList = null;
		
		try 
		{
			spRevReplyList = boardDao.SpRevReplyList(spRevReply);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplyList Exception", e);
		}
		
		return spRevReplyList;
	}
	
	public long SpRevReplyListCount(SpRevReply spRevReply)
	{
		long cnt = 0;
		
		try 
		{
			cnt = boardDao.SpRevReplyListCount(spRevReply);
		} 
		catch (Exception e)
		{
			logger.error("[BoardService] - SpRevReplyCount Exception", e);
		}
		
		return cnt;
	}
	
	public SpRevReply SpRevReplySelect(long replySeq)
	{
		SpRevReply spRevReply = null;
		
		try
		{
			spRevReply = boardDao.SpRevReplySelect(replySeq);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplySelect Exception", e);
		}
		
		return spRevReply;
	}
	
	public SpRevReply SpRevReplyGroupOrderSelect(long replySeq)
	{
		SpRevReply spRevReply = null;
		
		try 
		{
			spRevReply = boardDao.SpRevReplyGroupOrderSelect(replySeq);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplyGroupOrderSelect Exception", e);
		}
		
		return spRevReply;
	}
	
	public int SpRevReplyInsert(SpRevReply spRevReply)
	{
		int cnt = 0;
		
		try 
		{
			cnt = boardDao.SpRevReplyInsert(spRevReply);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplyInsert Exception", e);
		}
		
		return cnt;
	}
	
	public int SpRevReplyCommentInsert(SpRevReply spRevReply)
	{
		int cnt = 0;
		
		try 
		{
			cnt = boardDao.SpRevReplyCommentInsert(spRevReply);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplyCommentInsert Exception", e);
		}
		
		return cnt; 
	}
	
	public int SpRevReplyUpdate(SpRevReply spRevReply)
	{
		int cnt = 0;
		
		try 
		{
			cnt = boardDao.SpRevReplyUpdate(spRevReply);
		} 
		catch (Exception e) 
		{
			logger.error("[BoardService] - SpRevReplyUpdate Exception", e);
		}
		
		return cnt;
	}
	
	public List<SpJoinApprove> coMyPagePlayListSelect(SpJoinApprove spJoinApprove)
	{
		List<SpJoinApprove> spJoinApproveList = null;
		
		try 
		{
			spJoinApproveList = boardDao.coMyPagePlayListSelect(spJoinApprove);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - coMyPagePlayListSelect Exception", e);
		}
		
		return spJoinApproveList;
	}
	
	public long coMyPagePlayListCount(SpJoinApprove spJoinApprove)
	{
		long cnt = 0 ;
		
		try 
		{
			cnt = boardDao.coMyPagePlayListCount(spJoinApprove);
		}
		catch (Exception e) 
		{
			logger.error("[BoardService] - coMyPagePlayListCount Exception Error" + e);
		}
		
		return cnt;
	}
}