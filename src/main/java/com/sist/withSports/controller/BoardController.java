package com.sist.withSports.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.FileUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.Response;
import com.sist.withSports.model.SpCoUser;
import com.sist.withSports.model.SpLike;
import com.sist.withSports.model.SpNmUser;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.model.SpPromFile;
import com.sist.withSports.model.SpRev;
import com.sist.withSports.model.SpRevFile;
import com.sist.withSports.model.SpRevReply;
import com.sist.withSports.service.BoardService;
import com.sist.withSports.service.UserService;

@Controller("BoardController")
public class BoardController 
{
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.company']}")
	private String AUTH_COOKIE_COMPANY;
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_DIR;
	
	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value="/board/promList")
	public String promList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		List<SpProm> spPromList = null;
		
		SpProm spProm = new SpProm();
		Paging paging = null;
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) 
		{
			spProm.setSearchType(searchType);
			spProm.setSearchValue(searchValue);
		}
		
		long spPromCount = boardService.SpPromListCount(spProm);
		
		if(spPromCount > 0)
		{
			paging = new Paging("/board/promList", spPromCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			spProm.setStartRow(paging.getStartRow());
			spProm.setEndRow(paging.getEndRow());	
			spPromList = boardService.SpPromList(spProm);
		}
		
		//우측에 띄워줄거
		SpProm spProm1 = new SpProm();
		spProm1.setStartRow(1);
		spProm1.setEndRow(3);
		
		spProm1.setSearchSort("2");
		List<SpProm> spPromListLike = boardService.SpPromList(spProm1);
		spProm1.setSearchSort("3");
		List<SpProm> spPromListRead = boardService.SpPromList(spProm1);
		//
		
		modelMap.addAttribute("spPromList", spPromList);
		modelMap.addAttribute("spPromListLike", spPromListLike);
		modelMap.addAttribute("spPromListRead", spPromListRead);
		
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("coCookie", coCookie);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("paging", paging);
		
		return "/board/promList";
	}
	
	@RequestMapping(value="/board/promView")
	public String promView(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);

		long promSeq = HttpUtil.get(httpServletRequest, "promSeq", 0);
		SpProm spProm = null;
		SpLike spLike = null;
		
		
		if(promSeq > 0)
		{
			spProm = boardService.SpPromSelect(promSeq, "Y");
			
			if(spProm != null)
			{
				modelMap.addAttribute("spProm", spProm);
				spLike = boardService.SpPromViewLikeSelect(promSeq, nmCookie);
				modelMap.addAttribute("spLike", spLike);
			}
			
			//우측에 띄워줄거
			SpProm spProm1 = new SpProm();
			spProm1.setStartRow(1);
			spProm1.setEndRow(3);
			
			spProm1.setSearchSort("2");
			List<SpProm> spPromListLike = boardService.SpPromList(spProm1);
			spProm1.setSearchSort("3");
			List<SpProm> spPromListRead = boardService.SpPromList(spProm1);
			
			//
			
			modelMap.addAttribute("spPromListLike", spPromListLike);
			modelMap.addAttribute("spPromListRead", spPromListRead);
		}
		
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("coCookie", coCookie);
		
		return "/board/promView";
	}
	
	@RequestMapping(value="/board/promWrite")
	public String promWrite(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		SpCoUser spCoUser = null;
		
		if(!StringUtil.isEmpty(coCookie))
		{
			spCoUser = userService.SpCoUserSelect(coCookie);
			if(spCoUser != null)
			{
				modelMap.addAttribute("spCoUser", spCoUser);
				modelMap.addAttribute("coCookie", coCookie);
			}
		}
		return "/board/promWrite";
	}
	
	@ResponseBody
	@RequestMapping(value="/board/promWriteProc", method=RequestMethod.POST)
	public Response<Object> promWriteProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String coCookie = CookieUtil.getHexValue(multipartHttpServletRequest, AUTH_COOKIE_COMPANY);
		
		String promTitle = HttpUtil.get(multipartHttpServletRequest, "promWriteTitle", "");
		String promContent = HttpUtil.get(multipartHttpServletRequest, "promWriteContent", "");
		
		String promMoSdate = HttpUtil.get(multipartHttpServletRequest, "promWriteMoSdate", "");
		String promMoEdate = HttpUtil.get(multipartHttpServletRequest, "promWriteMoEdate", "");
		String promCoSdate = HttpUtil.get(multipartHttpServletRequest, "promWriteCoSdate", "");
		String promCoEdate = HttpUtil.get(multipartHttpServletRequest, "promWriteCoEdate", "");
		
		String promCate = HttpUtil.get(multipartHttpServletRequest, "promWriteCate", "");
		
		int promPrice = HttpUtil.get(multipartHttpServletRequest, "promWritePrice", 0);
		int promLimitCnt = HttpUtil.get(multipartHttpServletRequest, "promWriteLimitCnt", 0);
		
		String promPostCode = HttpUtil.get(multipartHttpServletRequest, "sample6_postcode", "");
		String promRoadAddress = HttpUtil.get(multipartHttpServletRequest, "sample6_address", "");
		String promDetailAddress = HttpUtil.get(multipartHttpServletRequest, "sample6_detailAddress", "");
		String promAddr = promRoadAddress + " " + promDetailAddress;
		
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "promFile", UPLOAD_DIR);
		
		SpProm spProm = null;
		
		if(!StringUtil.isEmpty(promTitle) && !StringUtil.isEmpty(promContent) && !StringUtil.isEmpty(coCookie)
			&& !StringUtil.isEmpty(promMoSdate) && !StringUtil.isEmpty(promMoEdate) && !StringUtil.isEmpty(promCoSdate)
			&& !StringUtil.isEmpty(promCoEdate) && !StringUtil.isEmpty(promCate) && !StringUtil.isEmpty(promPrice)
			&& !StringUtil.isEmpty(promLimitCnt) && !StringUtil.isEmpty(promPostCode) && !StringUtil.isEmpty(promRoadAddress)
			&& !StringUtil.isEmpty(promDetailAddress) && !StringUtil.isEmpty(promAddr))
		{
			spProm = new SpProm();
			
			spProm.setCoId(coCookie);
			spProm.setPromTitle(promTitle);
			spProm.setPromContent(promContent);
			spProm.setPromStatus("Y");
			spProm.setPromMoSdate(promMoSdate);
			spProm.setPromMoEdate(promMoEdate);
			spProm.setPromCoSdate(promCoSdate);
			spProm.setPromCoEdate(promCoEdate);
			spProm.setPromCate(promCate);
			spProm.setPromPrice(promPrice);
			spProm.setPromLimitCnt(promLimitCnt);
			spProm.setPromPostCode(promPostCode);
			spProm.setPromRoadAddress(promRoadAddress);
			spProm.setPromDetailAddress(promDetailAddress);
			spProm.setPromAddr(promAddr);

			if(fileData != null && fileData.getFileSize() > 0)
			{
				
				if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
				{
					ajaxRes.setResponse(410, "Conflict");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
					return ajaxRes;
				}
				else
				{
					SpPromFile spPromFile = new SpPromFile();
					
					spPromFile.setPromFileName(fileData.getFileName());
					spPromFile.setPromFileOrgName(fileData.getFileOrgName());
					spPromFile.setPromFileExt(fileData.getFileExt());
					spPromFile.setPromFileSize(fileData.getFileSize());
					
					spProm.setSpPromFile(spPromFile);	
				}
			}

			try
			{
				if(boardService.SpPromInsert(spProm) > 0)
				{
					ajaxRes.setResponse(200, "Ok");
				}
				else
				{
					ajaxRes.setResponse(500, "Internal Server Error");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spProm.getSpPromFile().getPromFileName());
				}
			} 
			catch (Exception e) 
			{
				logger.error("[BoardController] (promWriteProc) Exception Error" + e);
				ajaxRes.setResponse(500, "Internal Server Error");
				FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spProm.getSpPromFile().getPromFileName());
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
			FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/promWriteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	@RequestMapping(value="/board/promUpdate")
	public String promUpdate(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		SpProm spProm = null;
		long promSeq = HttpUtil.get(httpServletRequest, "promSeq", 0);
		
		if(promSeq > 0)
		{
			spProm = boardService.SpPromSelect(promSeq, "N");
				
			if(spProm != null)
			{
				if(StringUtil.equals(spProm.getCoId(), coCookie))
				{
					modelMap.addAttribute("coCookie", coCookie);
					modelMap.addAttribute("spProm", spProm);
				}
			}
		}
		
		return "/board/promUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value="/board/promUpdateProc", method=RequestMethod.POST)
	public Response<Object> promUpdateProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		String coCookie = CookieUtil.getHexValue(multipartHttpServletRequest, AUTH_COOKIE_COMPANY);
		
		SpProm spProm = null;
		
		long promSeq = HttpUtil.get(multipartHttpServletRequest, "promSeq", 0);
		
		String promTitle = HttpUtil.get(multipartHttpServletRequest, "promUpdateTitle", "");
		String promContent = HttpUtil.get(multipartHttpServletRequest, "promUpdateContent", "");
		String promPostCode = HttpUtil.get(multipartHttpServletRequest, "sample6_postcode", "");
		String promRoadAddress = HttpUtil.get(multipartHttpServletRequest, "sample6_address", "");
		String promDetailAddress = HttpUtil.get(multipartHttpServletRequest, "sample6_detailAddress", "");
		String promAddr = promRoadAddress + " " + promDetailAddress;
		
		String uploadFile = HttpUtil.get(multipartHttpServletRequest, "uploadFile", "N");
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "promFile", UPLOAD_DIR);
		
		if(promSeq > 0 && !StringUtil.isEmpty(promTitle) && !StringUtil.isEmpty(promContent) && !StringUtil.isEmpty(promPostCode) && !StringUtil.isEmpty(promRoadAddress) && !StringUtil.isEmpty(promDetailAddress) && !StringUtil.isEmpty(promAddr))
		{
			spProm = boardService.SpPromSelect(promSeq, "N");
			
			if(spProm != null)
			{
				if(StringUtil.equals(coCookie, spProm.getCoId())) 
				{
					spProm.setPromTitle(promTitle);
					spProm.setPromContent(promContent);
					spProm.setPromPostCode(promPostCode);
					spProm.setPromRoadAddress(promRoadAddress);
					spProm.setPromDetailAddress(promDetailAddress);
					spProm.setPromAddr(promAddr);
					
					if(fileData != null && fileData.getFileSize() > 0)
					{
						
						if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
						{
							ajaxRes.setResponse(410, "Conflict");
							FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
							return ajaxRes;
						}
						else
						{
							SpPromFile spPromFile = new SpPromFile();
							
							spPromFile.setPromFileName(fileData.getFileName());
							spPromFile.setPromFileOrgName(fileData.getFileOrgName());
							spPromFile.setPromFileExt(fileData.getFileExt());
							spPromFile.setPromFileSize(fileData.getFileSize());
							
							spProm.setSpPromFile(spPromFile);	
						}
					}
					else
					{
						if(StringUtil.equals(uploadFile, "N"))
						{
							spProm.setSpPromFile(null);
						}
					}
					
					try 
					{
						if(boardService.SpPromUpdate(spProm) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
							ajaxRes.setResponse(500, "Internal Server Error");
						}
					} 
					catch (Exception e) 
					{
						logger.error("[BoardController] (promUpdateProc) Exception Error" + e);
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
						ajaxRes.setResponse(500, "Internal Server Error");
					}
				}
				else
				{
					ajaxRes.setResponse(403, "Forbidden Error");
				}
			}
			else
			{
				ajaxRes.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/promUpdateProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		return ajaxRes;
	}

//----------------------------------------------------------------------------------------------------	
	
	
	@RequestMapping(value="/board/revList")
	public String revList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		List<SpRev> spRevList = null;
		SpRev spRev = new SpRev();
		Paging paging = null;
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		String searchSort = HttpUtil.get(httpServletRequest, "searchSort", "1");
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) 
		{
			spRev.setSearchType(searchType);
			spRev.setSearchValue(searchValue);
		}
		
		spRev.setSearchSort(searchSort);
		
		long spRevCount = boardService.SpRevListCount(spRev);
		
		if(spRevCount > 0)
		{
			paging = new Paging("/board/RevList", spRevCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			spRev.setStartRow(paging.getStartRow());
			spRev.setEndRow(paging.getEndRow());
			spRevList = boardService.SpRevList(spRev);	
		}
		
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("coCookie", coCookie);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("paging", paging);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("searchSort", searchSort);
		modelMap.addAttribute("spRevList", spRevList);
		
		return "/board/revList";
	}
	
	@RequestMapping(value="/board/revUpdate")
	public String revUpdate(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		long revSeq = HttpUtil.get(httpServletRequest, "revSeq", 0);
		SpRev spRev = null;

		if(revSeq > 0)
		{
			spRev = boardService.SpRevSelect(revSeq, "N");
				
			if(spRev != null)
			{
				if(StringUtil.equals(spRev.getNmId(), nmCookie))
				{
					modelMap.addAttribute("nmCookie", nmCookie);
					modelMap.addAttribute("spRev", spRev);
				}
			}
		}
		return "/board/revUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value="/board/revUpdateProc", method=RequestMethod.POST)
	public Response<Object> revUpdateProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmCookie = CookieUtil.getHexValue(multipartHttpServletRequest, AUTH_COOKIE_USER);
		
		long revSeq = HttpUtil.get(multipartHttpServletRequest, "revSeq", 0);
		String revTitle = HttpUtil.get(multipartHttpServletRequest, "revUpdateTitle", "");
		String revContent = HttpUtil.get(multipartHttpServletRequest, "revUpdateContent", "");

		
		String uploadFile = HttpUtil.get(multipartHttpServletRequest, "uploadFile", "N");
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "revFile", UPLOAD_DIR);
		
		SpRev spRev = null;
		
		if(revSeq > 0 && !StringUtil.isEmpty(revTitle) && !StringUtil.isEmpty(revContent))
		{
			spRev = boardService.SpRevSelect(revSeq, "N");
			
			if(spRev != null)
			{
				if(StringUtil.equals(spRev.getNmId(), nmCookie))
				{
					spRev.setRevTitle(revTitle);
					spRev.setRevContent(revContent);
					
					if(fileData != null && fileData.getFileSize() > 0)
					{
						if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
						{
							ajaxRes.setResponse(410, "Conflict");
							FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
							return ajaxRes;
						}
						else
						{
							SpRevFile spRevFile = new SpRevFile();
							
							spRevFile.setRevFileName(fileData.getFileName());
							spRevFile.setRevFileOrgName(fileData.getFileOrgName());
							spRevFile.setRevFileExt(fileData.getFileExt());
							spRevFile.setRevFileSize(fileData.getFileSize());
							
							spRev.setSpRevFile(spRevFile);
						}
					}
					else
					{
						if(StringUtil.equals(uploadFile, "N"))
						{
							spRev.setSpRevFile(null);
						}
					}

					try
					{
						if(boardService.SpRevUpdate(spRev) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							ajaxRes.setResponse(500, "Internal Server Error");
							FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
						}
					} 
					catch (Exception e) 
					{
						logger.error("[BoardController] (revUpdateProc) Exception Error" + e);
						ajaxRes.setResponse(500, "Internal Server Error");
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
					}
				}
				else
				{
					ajaxRes.setResponse(403, "Forbidden Error");
				}
			}
			else
			{
				ajaxRes.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revUpdateProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	
	@RequestMapping(value="/board/revView")
	public String revView(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		String searchSort = HttpUtil.get(httpServletRequest, "searchSort", "1");
		
		long revSeq = HttpUtil.get(httpServletRequest, "revSeq", 0);
		SpRev spRev = null;
		SpRevReply spRevReply = null;
		
		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
	
		if(revSeq > 0)
		{
			spRev = boardService.SpRevSelect(revSeq, "Y");
			
			spRevReply = new SpRevReply();
			spRevReply.setRevSeq(revSeq);
			
			spRev.setSpRevReplyList(boardService.SpRevReplyList(spRevReply));
		}
		
		modelMap.addAttribute("spRev", spRev);
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("coCookie", coCookie);
		
		modelMap.addAttribute("spNmUser", spNmUser);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("searchSort", searchSort);
		modelMap.addAttribute("curPage", curPage);
		
		return "/board/revView";
	}
	
	@ResponseBody
	@RequestMapping(value="/board/revReplyProc", method=RequestMethod.POST)
	public Response<Object> revReplyProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long revSeq = HttpUtil.get(httpServletRequest, "revSeq", 0);
		String replyContent = HttpUtil.get(httpServletRequest, "replyContent", "");
		SpRevReply spRevReply = null;
		
		if(revSeq > 0 && !StringUtil.isEmpty(replyContent))
		{
			spRevReply = new SpRevReply();
			spRevReply.setNmId(nmCookie);
			spRevReply.setRevSeq(revSeq);
			spRevReply.setReplyContent(replyContent);
			spRevReply.setStatus('Y');
			
			if(boardService.SpRevReplyInsert(spRevReply) > 0)
			{
				ajaxRes.setResponse(200, "Ok");
			}
			else
			{
				ajaxRes.setResponse(500, "Internal Server Error");
			}		
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revReplyProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/board/revDeleteProc", method=RequestMethod.POST)
	public Response<Object> revDeleteProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		long revSeq = HttpUtil.get(httpServletRequest, "revSeq", 0);
		
		SpRev spRev = null;
		SpRevReply spRevReply = null;
	
		if(revSeq > 0)
		{
			spRev = boardService.SpRevSelect(revSeq, "N");
			
			if(spRev != null)
			{
				spRevReply = new SpRevReply();
				spRevReply.setRevSeq(revSeq);
				spRev.setSpRevReplyList(boardService.SpRevReplyList(spRevReply));

				try 
				{
					if(boardService.SpRevDelete(spRev) > 0)
					{
						ajaxRes.setResponse(200, "Ok");
					}
					else
					{
						ajaxRes.setResponse(500, "Internal Server Error");
					}
				}
				catch (Exception e) 
				{
					logger.error("[BoardController] (revDeleteProc) Exception Error" + e);
					ajaxRes.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxRes.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
	
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/board/revReplyCommnetProc", method=RequestMethod.POST)
	public Response<Object> revReplyCommnetProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long revSeq = HttpUtil.get(httpServletRequest, "revSeq", 0);
		long replySeq = HttpUtil.get(httpServletRequest, "replySeq", 0);
		String replyContent = HttpUtil.get(httpServletRequest, "replyContent", "");
	
		SpRev spRev = null;
		
		if(revSeq > 0)
		{
			spRev = boardService.SpRevSelect(revSeq, "N");
			
			if(spRev != null)
			{
				if(replySeq > 0)
				{
					SpRevReply spRevReplyGroupOrder = boardService.SpRevReplyGroupOrderSelect(replySeq);
					
					if(spRevReplyGroupOrder != null)
					{
					
						SpRevReply spRevReply = new SpRevReply();
						
						spRevReply.setRevSeq(revSeq);
						spRevReply.setNmId(nmCookie);
						spRevReply.setReplyGroup(replySeq);
						spRevReply.setReplyOrder(spRevReplyGroupOrder.getReplyOrder() + 1);
						spRevReply.setReplyContent(replyContent);
						spRevReply.setStatus('Y');
						
						if(boardService.SpRevReplyCommentInsert(spRevReply) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							ajaxRes.setResponse(500, "Internal Server Error");
						}
					}
					else
					{
						ajaxRes.setResponse(404, "Not Found");
					}
				}
				else
				{
					ajaxRes.setResponse(404, "Not Found");
				}
			}
			else
			{
				ajaxRes.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revReplyCommnetProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/board/revReplyDeleteProc", method=RequestMethod.POST)
	public Response<Object> revReplyDeleteProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		long replySeq = HttpUtil.get(httpServletRequest, "replySeq", 0);
		
		SpRevReply spRevReply = null;
		
		if(replySeq > 0)
		{
			spRevReply = boardService.SpRevReplySelect(replySeq);
			
			if(spRevReply != null)
			{
				spRevReply.setStatus('C');
				
				if(boardService.SpRevReplyUpdate(spRevReply) > 0)
				{
					ajaxRes.setResponse(200, "Ok");
				}
				else
				{
					ajaxRes.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxRes.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revReplyDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	
	@RequestMapping(value="/board/revWrite")
	public String revWrite(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		if(!StringUtil.isEmpty(nmCookie))
		{
			SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
			if(spNmUser != null)
			{
				modelMap.addAttribute("nmCookie", nmCookie);
				modelMap.addAttribute("spNmUser", spNmUser);
			}
				
		}
		return "/board/revWrite";
	}
	
	@ResponseBody
	@RequestMapping(value="/board/revWriteProc", method=RequestMethod.POST)
	public Response<Object> revWriteProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmCookie = CookieUtil.getHexValue(multipartHttpServletRequest, AUTH_COOKIE_USER);
		String revTitle = HttpUtil.get(multipartHttpServletRequest, "revWriteTitle", "");
		String revContent = HttpUtil.get(multipartHttpServletRequest, "revWriteContent", "");
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "revFile", UPLOAD_DIR);
		
		SpRev spRev = null;
		if(!StringUtil.isEmpty(revTitle) && !StringUtil.isEmpty(revContent))
		{
			spRev = new SpRev();
			
			spRev.setNmId(nmCookie);
			spRev.setRevTitle(revTitle);
			spRev.setRevContent(revContent);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
				{
					ajaxRes.setResponse(410, "Conflict");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
					return ajaxRes;
				}
				else
				{
					SpRevFile spRevFile = new SpRevFile();
					
					spRevFile.setRevFileName(fileData.getFileName());
					spRevFile.setRevFileOrgName(fileData.getFileOrgName());
					spRevFile.setRevFileExt(fileData.getFileExt());
					spRevFile.setRevFileSize(fileData.getFileSize());
					
					spRev.setSpRevFile(spRevFile);
				}
			}

			try
			{
				if(boardService.SpRevInsert(spRev) > 0)
				{
					ajaxRes.setResponse(200, "Ok");
				}
				else
				{
					ajaxRes.setResponse(500, "Internal Server Error");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
				}
			} 
			catch (Exception e) 
			{
				logger.error("[BoardController] (revWriteProc) Exception Error" + e);
				ajaxRes.setResponse(500, "Internal Server Error");
				FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + spRev.getSpRevFile().getRevFileName());
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/revWriteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}


	@ResponseBody
	@RequestMapping(value="/board/promViewLikeProc", method=RequestMethod.POST)
	public Response<Object> promViewLikeProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long promSeq = HttpUtil.get(httpServletRequest, "promSeq", 0);
		SpLike spLike = null;
		
		if(promSeq > 0)
		{
			spLike = boardService.SpPromViewLikeSelect(promSeq, nmCookie);
			
			if(spLike != null)
			{
				try 
				{
					if(boardService.SpPromViewLikeDelete(spLike) > 0)
					{
						ajaxRes.setResponse(200, "Ok");
					}
					else
					{
						ajaxRes.setResponse(500, "Internal Server Error");
					}
				}
				catch (Exception e) 
				{
					logger.error("[BoardController] (promViewLikeProc) Exception Error" + e);
					ajaxRes.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				spLike = new SpLike();
				
				spLike.setPromSeq(promSeq);
				spLike.setNmId(nmCookie);
				try 
				{
					if(boardService.SpPromViewLikeInsert(spLike) > 0)
					{
						ajaxRes.setResponse(200, "Ok");
					}
					else
					{
						ajaxRes.setResponse(500, "Internal Server Error");
					}					
				}
				catch (Exception e) 
				{
					logger.error("[BoardController] (promViewLikeProc) Exception Error" + e);
					ajaxRes.setResponse(500, "Internal Server Error");
				}
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[BoardController] /board/promViewLikeProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
}