package com.sist.withSports.controller;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.Response;
import com.sist.withSports.model.SpCoUser;
import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpJoinCancel;
import com.sist.withSports.model.SpLike;
import com.sist.withSports.model.SpNmUser;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.model.SpRev;
import com.sist.withSports.model.SpRevReply;
import com.sist.withSports.service.BoardService;
import com.sist.withSports.service.KakaoService;
import com.sist.withSports.service.UserService;

@Controller("UserController")
public class UserController 
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("#{env['auth.cookie.company']}")
	private String AUTH_COOKIE_COMPANY;
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;

	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;

	@RequestMapping(value="/user/logout")
	public String logout(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_USER) != null || CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_COMPANY) != null)
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_COMPANY);
		}
		return "redirect:/";
	}	
	
//------------------------------------------------------------------------------------------------login
	
	@RequestMapping(value="/user/login")
	public String login(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_USER) == null && CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_COMPANY) == null)
		{
			return "/user/login";
		}
		else
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_COMPANY);
			return "redirect:/"; //재접속 하라는 명령
		}
	}
		
	@ResponseBody
	@RequestMapping(value="/user/nmLoginProc", method=RequestMethod.POST)
	public Response<Object> nmLoginProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		String nmPwd = HttpUtil.get(httpServletRequest, "nmPwd", "");
	
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser != null)
			{
				if(StringUtil.equals(spNmUser.getNmPwd(), nmPwd))
				{
					if(StringUtil.equals(spNmUser.getNmStatus(), "Y"))
					{
						CookieUtil.addCookie(httpServletResponse, "/",  -1, AUTH_COOKIE_USER, CookieUtil.stringToHex(nmId));
						ajaxRes.setResponse(200, "Ok");
					}
					else if(StringUtil.equals(spNmUser.getNmStatus(), "S"))
					{
						ajaxRes.setResponse(410, "Gone");	
					}
					else
					{
						ajaxRes.setResponse(403, "Forbidden");
					}
				}
				else
				{
					ajaxRes.setResponse(401, "Unauthorized");
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
			logger.debug("[UserController] /user/nmLoginProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/coLoginProc", method=RequestMethod.POST)
	public Response<Object> coLoginProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String coId = HttpUtil.get(httpServletRequest, "coId", "");
		String coPwd = HttpUtil.get(httpServletRequest, "coPwd", "");
		
		SpCoUser spCoUser = null;
		
		if(!StringUtil.isEmpty(coId) && !StringUtil.isEmpty(coPwd))
		{
			spCoUser = userService.SpCoUserSelect(coId);
			
			if(spCoUser != null)
			{
				if(StringUtil.equals(spCoUser.getCoPwd(), coPwd))
				{
					if(StringUtil.equals(spCoUser.getCoStatus(), "Y"))
					{
						CookieUtil.addCookie(httpServletResponse, "/",  -1, AUTH_COOKIE_COMPANY, CookieUtil.stringToHex(coId));
						ajaxRes.setResponse(200, "Ok");
					}
					else
					{
						ajaxRes.setResponse(403, "Forbidden");
					}
				}
				else
				{
					ajaxRes.setResponse(401, "Unauthorized");
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
			logger.debug("[UserController] /user/coLoginProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
//------------------------------------------------------------------------------------------------login

//------------------------------------------------------------------------------------------------signUp	
	
	@RequestMapping(value="/user/signUp")
	public String signUp(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_USER) == null && CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_COMPANY) == null)
		{
			return "/user/signUp";
		}
		else
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_COMPANY);
			return "redirect:/"; //재접속 하라는 명령
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmIdCheck", method=RequestMethod.POST)
	public Response<Object> nmIdCheck(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser == null)
			{
				ajaxRes.setResponse(200, "Ok");
			}
			else
			{
				ajaxRes.setResponse(409, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/nmIdCheck response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/coIdCheck", method=RequestMethod.POST)
	public Response<Object> coIdCheck(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String coId = HttpUtil.get(httpServletRequest, "coId", "");
		SpCoUser spCoUser = null;
		
		if(!StringUtil.isEmpty(coId))
		{
			spCoUser = userService.SpCoUserSelect(coId);
			
			if(spCoUser == null)
			{
				ajaxRes.setResponse(200, "Ok");
			}
			else
			{
				ajaxRes.setResponse(409, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/coIdCheck response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmSignUpProc", method=RequestMethod.POST)
	public Response<Object> nmSignUpProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		String nmPwd = HttpUtil.get(httpServletRequest, "nmPwd", "");
		String nmName = HttpUtil.get(httpServletRequest, "nmName", "");
		String nmNickname = HttpUtil.get(httpServletRequest, "nmNickname", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmail", "");
		String nmTel = HttpUtil.get(httpServletRequest, "nmTel", "");
		
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd) && !StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmNickname) && !StringUtil.isEmpty(nmEmail) && !StringUtil.isEmpty(nmTel))
		{
			if(userService.SpNmUserSelect(nmId) == null)
			{
				int cnt = userService.SpNmCheckSelect(nmNickname, nmEmail, nmTel);
				
				switch(cnt)
				{
					case 0:
						spNmUser = new SpNmUser();
						
						spNmUser.setNmId(nmId);
						spNmUser.setNmPwd(nmPwd);
						spNmUser.setNmName(nmName);
						spNmUser.setNmNickname(nmNickname);
						spNmUser.setNmEmail(nmEmail);
						spNmUser.setNmTel(nmTel);
						spNmUser.setNmStatus("Y");
						
						if(userService.SpNmUserInsert(spNmUser) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							ajaxRes.setResponse(500, "Internal Server Error");
						}
						break;
					
					case 1:
						ajaxRes.setResponse(407, "Conflict-Nickname");
						break;
					case 2:
						ajaxRes.setResponse(408, "Conflict-Email");
						break;
					case 3:
						ajaxRes.setResponse(409, "Conflict-TelePhone");
						break;
				}
			}
			else
			{
				ajaxRes.setResponse(410, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/nmSignUpProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/coSignUpProc", method=RequestMethod.POST)
	public Response<Object> coSignUpProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String coId = HttpUtil.get(httpServletRequest, "coId", "");
		String coPwd = HttpUtil.get(httpServletRequest, "coPwd", "");
		String coName = HttpUtil.get(httpServletRequest, "coName", "");
		String coCeo = HttpUtil.get(httpServletRequest, "coCeo", "");
		String coNum = HttpUtil.get(httpServletRequest, "coNum", "");
		String coAddr = HttpUtil.get(httpServletRequest, "coAddr", "");
		String coTel = HttpUtil.get(httpServletRequest, "coTel", "");
		String coEmail = HttpUtil.get(httpServletRequest, "coEmail", "");
		
		SpCoUser spCoUser = null;
		
		if(!StringUtil.isEmpty(coId) && !StringUtil.isEmpty(coPwd) && !StringUtil.isEmpty(coName) && !StringUtil.isEmpty(coCeo) && !StringUtil.isEmpty(coNum) && !StringUtil.isEmpty(coAddr) && !StringUtil.isEmpty(coTel) && !StringUtil.isEmpty(coEmail))
		{
			if(userService.SpCoUserSelect(coId) == null)
			{
				int cnt = userService.SpCoCheckSelect(coNum, coAddr, coTel, coEmail);
				
				switch(cnt)
				{
					case 0:
						spCoUser = new SpCoUser();
						
						spCoUser.setCoId(coId);
						spCoUser.setCoPwd(coPwd);
						spCoUser.setCoName(coName);
						spCoUser.setCoCeo(coCeo);
						spCoUser.setCoNum(coNum);
						spCoUser.setCoAddr(coAddr);
						spCoUser.setCoTel(coTel);
						spCoUser.setCoEmail(coEmail);
						spCoUser.setCoStatus("N");
						
						if(userService.SpCoUserInsert(spCoUser) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							ajaxRes.setResponse(500, "Internal Server Error");
						}
						break;
					case 1:
						ajaxRes.setResponse(407, "Conflict-Number");
						break;
					case 2:
						ajaxRes.setResponse(408, "Conflict-Address");
						break;
					case 3:
						ajaxRes.setResponse(409, "Conflict-TelePhone");
						break;
					case 4:
						ajaxRes.setResponse(410, "Conflict-Email");
						break;
				}
			}
			else
			{
				ajaxRes.setResponse(411, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/coSignUpProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
//------------------------------------------------------------------------------------------------signUp		
	
//------------------------------------------------------------------------------------------------find	
	
	@RequestMapping(value="/user/nmFind")
	public String nmFind(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_USER) == null && CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_COMPANY) == null)
		{
			return "/user/nmFind";
		}
		else
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_COMPANY);
			return "redirect:/"; //재접속 하라는 명령
		}
	}

//------------------------------------------------------------------------------------------------findId	
	
	@ResponseBody
	@RequestMapping(value="/user/nmIdFindProc", method=RequestMethod.POST)	
	public Response<Object> nmIdFindProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmName = HttpUtil.get(httpServletRequest, "nmNameIdFind", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmailIdFind", "");
		
		SpNmUser spNmUser = null;
		if(!StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmEmail))
		{
			spNmUser = new SpNmUser();
			
			spNmUser.setNmName(nmName);
			spNmUser.setNmEmail(nmEmail);
			
			if(userService.SpNmIdPwdFind(spNmUser) != null)
			{
				ajaxRes.setResponse(200, "Ok");
			}
			else
			{
				ajaxRes.setResponse(409, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/nmIdFindProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@RequestMapping(value="/user/nmIdFind")
	public String nmIdFind(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmName = HttpUtil.get(httpServletRequest, "nmNameIdFind", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmailIdFind", "");
		String nmId = null;
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmEmail))
		{
			spNmUser = new SpNmUser();
			
			spNmUser.setNmName(nmName);
			spNmUser.setNmEmail(nmEmail);
			
			nmId = userService.SpNmIdPwdFind(spNmUser);
			
			if(nmId != null)
			{
				modelMap.addAttribute("nmId", nmId);
			}
		}
		return "/user/nmIdFind";
	}
	
//------------------------------------------------------------------------------------------------findId
	
//------------------------------------------------------------------------------------------------findPwd	

	@ResponseBody
	@RequestMapping(value="/user/nmPwdFindProc", method=RequestMethod.POST)	
	public Response<Object> nmPwdFindProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmIdPwdFind", "");
		String nmName = HttpUtil.get(httpServletRequest, "nmNamePwdFind", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmailPwdFind", "");
		
		SpNmUser spNmUser = null;
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmName) && !StringUtil.isEmpty(nmEmail))
		{
			spNmUser = new SpNmUser();
			
			spNmUser.setNmId(nmId);
			spNmUser.setNmName(nmName);
			spNmUser.setNmEmail(nmEmail);
			
			if(userService.SpNmIdPwdFind(spNmUser) != null)
			{
				ajaxRes.setResponse(200, "Ok");
			}
			else
			{
				ajaxRes.setResponse(409, "Conflict");
			}
		}
		else
		{
			ajaxRes.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/nmPwdFindProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@RequestMapping(value="/user/nmPwdFindEmail")
	public String nmPwdFindEmail(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{	
		String nmId = HttpUtil.get(httpServletRequest, "nmIdPwdFind", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmailPwdFind", "");
	
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmEmail))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser != null)
			{
				if(StringUtil.equals(spNmUser.getNmEmail(), nmEmail))
				{
					modelMap.addAttribute("nmId", nmId);
					modelMap.addAttribute("nmEmail", nmEmail);	
				}
			}
		}
		return "/user/nmPwdFindEmail";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmPwdFindEmailProc", method=RequestMethod.GET)
	public String nmPwdFindEmailProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception
	{		
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmail", "");
			
		//인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.debug("인증번호 : "+ checkNum);
		
		//이메일 전송 내용
		String setFrom = "wogn2918@gmail.com"; //발신 이메일
		String toMail = nmEmail;         //받는 이메일
		String title = "withSports 비밀번호 찾기 인증 이메일 입니다.";
		String content = "인증 번호는 " + checkNum + "입니다. " + 
						 "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		//이메일 전송 코드
		try 
		{
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "utf-8");
			
			mimeMessageHelper.setFrom(setFrom);
			mimeMessageHelper.setTo(toMail);
			mimeMessageHelper.setSubject(title);
			mimeMessageHelper.setText(content,true);
			
			mailSender.send(mimeMessage);
			
		}
		catch(Exception e) 
		{
			logger.error("[UserController] (nmPwdFindEmailProc) Exception Error \n" + e);
		}
		String num = Integer.toString(checkNum); // ajax를 뷰로 반환시 데이터 타입은 String 타입만 가능
		
		return num; // String 타입으로 변환 후 반환
	}

	@RequestMapping(value="/user/nmPwdFind")
	public String nmPwdFind (ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		
		if(!StringUtil.isEmpty(nmId))
		{
			if(userService.SpNmUserSelect(nmId) != null)
			{
				modelMap.addAttribute("nmId", nmId);
			}
		}
		return "/user/nmPwdFind";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmPwdFindChange", method=RequestMethod.POST)
	public Response<Object> nmPwdFindChange (HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		String nmPwd = HttpUtil.get(httpServletRequest, "nmPwd");
		
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser != null)
			{
				spNmUser.setNmPwd(nmPwd);
				
				if(userService.SpNmPwdFindChange(spNmUser) > 0)
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
			logger.debug("[UserController] /user/nmPwdFindChange response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}

//------------------------------------------------------------------------------------------------findPwd		
	
//------------------------------------------------------------------------------------------------nmPage		

	
	@RequestMapping(value="/user/nmMyPage")
	public String usernmMyPage(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
		
		if(spNmUser != null)
		{
			modelMap.addAttribute("spNmUser", spNmUser);
			modelMap.addAttribute("nmCookie", nmCookie);
		}

		return "/user/nmMyPage";
	}
	
	@RequestMapping(value="/user/nmUpdate")
	public String usernmUpdate(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
		
		if(spNmUser != null)
		{
			modelMap.addAttribute("spNmUser", spNmUser);
			modelMap.addAttribute("nmCookie", nmCookie);
		}
		return "/user/nmUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmUpdateProc")
	public Response<Object> nmUpdateProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		String nmPwd = HttpUtil.get(httpServletRequest, "nmPwd", "");
		String nmNickname = HttpUtil.get(httpServletRequest, "nmNickname", "");
		String nmEmail = HttpUtil.get(httpServletRequest, "nmEmail", "");
		String nmTel = HttpUtil.get(httpServletRequest, "nmTel", "");
		
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId) && !StringUtil.isEmpty(nmPwd) && !StringUtil.isEmpty(nmNickname) && !StringUtil.isEmpty(nmEmail) && !StringUtil.isEmpty(nmTel))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser != null)
			{
				if(StringUtil.equals(spNmUser.getNmNickname(), nmNickname))
				{
					nmNickname = "";
				}
				if(StringUtil.equals(spNmUser.getNmEmail(), nmEmail))
				{
					nmEmail = "";
				}
				if(StringUtil.equals(spNmUser.getNmTel(), nmTel))
				{
					nmTel = "";
				}
				
				int cnt = userService.SpNmCheckSelect(nmNickname, nmEmail, nmTel);
				
				switch(cnt)
				{
					case 0:
						spNmUser.setNmPwd(nmPwd);
						spNmUser.setNmNickname(nmNickname);
						spNmUser.setNmEmail(nmEmail);
						spNmUser.setNmTel(nmTel);
						
						if(userService.SpNmUserUpdate(spNmUser) > 0)
						{
							ajaxRes.setResponse(200, "Ok");
						}
						else
						{
							ajaxRes.setResponse(500, "Internal Server Error");
						}
						break;
					case 1:
						ajaxRes.setResponse(407, "Conflict-Nickname");
						break;
					case 2:
						ajaxRes.setResponse(408, "Conflict-Email");
						break;
					case 3:
						ajaxRes.setResponse(409, "Conflict-TelePhone");
						break;
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
			logger.debug("[UserController] /user/nmUpdateProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmSignOutProc")
	public Response<Object> nmSignOutProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmId = HttpUtil.get(httpServletRequest, "nmId", "");
		SpNmUser spNmUser = null;
		
		if(!StringUtil.isEmpty(nmId))
		{
			spNmUser = userService.SpNmUserSelect(nmId);
			
			if(spNmUser != null)
			{
				if(userService.SpNmUserSignOut(spNmUser) > 0)
				{
					CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
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
			logger.debug("[UserController] /user/nmSignOutProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	@RequestMapping(value="/user/nmJoinList")
	public String usernmJoinList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long approveCurPage = HttpUtil.get(httpServletRequest, "approveCurPage", 1);
		long cancelCurPage = HttpUtil.get(httpServletRequest, "cancelCurPage", 1);
	
		Paging joinApprovePaging = null;
		List<SpJoinApprove> joinApproveList = null;
		
		Paging joinCancelPaging = null;
		List<SpJoinCancel> joinCancelList = null;
		
		SpJoinApprove spJoinApprove = new SpJoinApprove();
		SpJoinCancel spJoinCancel = new SpJoinCancel();
		
		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
		
		if(spNmUser != null)
		{
			spJoinApprove.setPartnerUserId(spNmUser.getNmId());
			spJoinCancel.setPartnerUserId(spNmUser.getNmId());
			long approveCount = kakaoService.KakaoApproveCount(spJoinApprove);
			long cancelCount = kakaoService.KakaoCancelCount(spJoinCancel);
			
			if(approveCount > 0) 
			{
				joinApprovePaging = new Paging("/user/nmJoinList", approveCount, LIST_COUNT, PAGE_COUNT, approveCurPage, "approveCurPage");
				
				spJoinApprove.setStartRow(joinApprovePaging.getStartRow());
				spJoinApprove.setEndRow(joinApprovePaging.getEndRow());
				
				joinApproveList = kakaoService.KakaoApproveList(spJoinApprove);
			}
			
			if(cancelCount > 0)
			{
				joinCancelPaging = new Paging("/user/nmJoinList", cancelCount, LIST_COUNT, PAGE_COUNT, cancelCurPage, "cancelCurPage");
				
				spJoinCancel.setStartRow(joinCancelPaging.getStartRow());
				spJoinCancel.setEndRow(joinCancelPaging.getEndRow());
				
				joinCancelList = kakaoService.KakaoCancelList(spJoinCancel);
			}
		}
		
		modelMap.addAttribute("joinApproveList", joinApproveList);
		modelMap.addAttribute("joinCancelList", joinCancelList);
		modelMap.addAttribute("joinApprovePaging", joinApprovePaging);
		modelMap.addAttribute("joinCancelPaging", joinCancelPaging);
		modelMap.addAttribute("approveCurPage", approveCurPage);
		modelMap.addAttribute("cancelCurPage", cancelCurPage);
		
		modelMap.addAttribute("nmCookie", nmCookie);
		return "/user/nmJoinList";
	}
	

	@RequestMapping(value="/user/nmRevList")
	public String usernmRevList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long spRevCurPage = HttpUtil.get(httpServletRequest, "spRevCurPage", 1);
		long spRevReplyCurPage = HttpUtil.get(httpServletRequest, "spRevReplyCurPage", 1);
		
		List<SpRev> spRevList = null;
		Paging spRevPaging = null;
		SpRev spRev = new SpRev();
		
		List<SpRevReply> spRevReplyList = null;
		Paging spRevReplyPaging = null;
		SpRevReply spRevReply = new SpRevReply();

		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);

		if(spNmUser != null)
		{
			spRev.setNmId(spNmUser.getNmId());
			spRevReply.setNmId(spNmUser.getNmId());
			
			long spRevCount = boardService.SpRevListCount(spRev);
			long spRevReplyCount = boardService.SpRevReplyListCount(spRevReply);
			
			if(spRevCount > 0)
			{
				spRevPaging = new Paging("/user/nmRevList", spRevCount, LIST_COUNT, PAGE_COUNT, spRevCurPage, "spRevCurPage");

				spRev.setStartRow(spRevPaging.getStartRow());
				spRev.setEndRow(spRevPaging.getEndRow());
				spRevList = boardService.SpRevList(spRev);	
			}
			
			if(spRevReplyCount > 0)
			{
				spRevReplyPaging = new Paging("/user/nmRevList", spRevReplyCount, LIST_COUNT, PAGE_COUNT, spRevReplyCurPage, "spRevReplyCurPage");
				
				spRevReply.setStartRow(spRevReplyPaging.getStartRow());
				spRevReply.setEndRow(spRevReplyPaging.getEndRow());
				
				spRevReplyList = boardService.SpRevReplyList(spRevReply);
			}
		}
		modelMap.addAttribute("spRevList", spRevList);
		modelMap.addAttribute("spRevReplyList", spRevReplyList);
		
		modelMap.addAttribute("spRevCurPage", spRevCurPage);
		modelMap.addAttribute("spRevReplyCurPage", spRevReplyCurPage);
		
		modelMap.addAttribute("spRevPaging", spRevPaging);
		modelMap.addAttribute("spRevReplyPaging", spRevReplyPaging);
		
		modelMap.addAttribute("nmCookie", nmCookie);
		return "/user/nmRevList";
	}
	
	@RequestMapping(value="/user/nmRevDeleteProc")
	@ResponseBody
	public Response<Object> userNmRevDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
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
					logger.error("[UserController] (userNmRevDelete) Exception Error" + e);
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
			logger.debug("[UserController] /user/nmRevDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
	
		
		return ajaxRes;
	}
	
	@RequestMapping(value="/user/nmRevReplyDeleteProc")
	@ResponseBody
	public Response<Object> userNmRevReplyDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
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
			logger.debug("[UserController] /user/nmRevReplyDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	@RequestMapping(value="/user/nmLikeList")
	public String usernmLikeList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		List<SpLike> spLikeList = null;
		Paging paging = null;
		SpLike spLike = new SpLike();
		
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		SpNmUser spNmUser = userService.SpNmUserSelect(nmCookie);
		
		if(spNmUser != null)
		{
			spLike.setNmId(nmCookie);
			long spLikeCount = boardService.SpLikeCount(spLike);
			
			if(spLikeCount > 0)
			{
				paging = new Paging("/user/nmLikeList", spLikeCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				spLike.setNmId(spNmUser.getNmId());
				spLike.setStartRow(paging.getStartRow());
				spLike.setEndRow(paging.getEndRow());
				spLikeList = boardService.SpLikeList(spLike);
			}
		}
		
		modelMap.addAttribute("spLikeList", spLikeList);
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("paging", paging);
		return "/user/nmLikeList";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/nmLikeListDeleteProc", method=RequestMethod.POST)
	public Response<Object> nmLikeListDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
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
					logger.error("[UserController] (nmLikeListDelete) Exception Error" + e);
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
			logger.debug("[UserController] /user/nmLikeListDelete response \n" + JsonUtil.toJsonPretty(ajaxRes));
		}
		
		return ajaxRes;
	}
	
	
	
	@RequestMapping(value="/user/coMyPage")
	public String usercoMyPage(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		Paging paging = null;
		
		List<SpProm> spPromList = null;
		SpProm spProm = new SpProm();
		SpCoUser spCoUser = userService.SpCoUserSelect(coCookie);

		if(spCoUser != null)
		{
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				spProm.setSearchType(searchType);
				spProm.setSearchValue(searchValue);
			}
			
			spProm.setCoId(spCoUser.getCoId());
			long spPromCount = boardService.SpPromListCount(spProm);
			
			if(spPromCount > 0)
			{
				paging = new Paging("/user/coMyPage", spPromCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				spProm.setStartRow(paging.getStartRow());
				spProm.setEndRow(paging.getEndRow());	
				spProm.setCoId(spCoUser.getCoId());
				spPromList = boardService.SpPromList(spProm);
			}
		}
		
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("paging", paging);
		modelMap.addAttribute("spPromList", spPromList);
		modelMap.addAttribute("coCookie", coCookie);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		
		return "/user/coMyPage";
	}
	
	@RequestMapping(value="/user/coMyPagePlayList")
	public String coMyPagePlayList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		long promSeq = HttpUtil.get(httpServletRequest, "promSeq", 0);
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		long playListCurPage = HttpUtil.get(httpServletRequest, "playListCurPage", 1);
		Paging playListPaging = null;
		
		long spJoinApproveListCnt = 0;
		List<SpJoinApprove> spJoinApproveList = null;
		SpJoinApprove spJoinApprove = null;
		
		if(promSeq > 0)
		{
			SpCoUser spCoUser = userService.SpCoUserSelect(coCookie);
			
			if(spCoUser != null)
			{
				spJoinApprove = new SpJoinApprove();
				spJoinApprove.setItemCode(Long.toString(promSeq));
				
				spJoinApproveListCnt = boardService.coMyPagePlayListCount(spJoinApprove);
						
				if(spJoinApproveListCnt > 0)
				{
					playListPaging = new Paging("/user/coMyPagePlayList", spJoinApproveListCnt, 10, 10, curPage, "curPage");
					
					spJoinApprove.setStartRow(playListPaging.getStartRow());
					spJoinApprove.setEndRow(playListPaging.getEndRow());
					spJoinApproveList = boardService.coMyPagePlayListSelect(spJoinApprove);
				}
				
				modelMap.addAttribute("promSeq", promSeq);
				modelMap.addAttribute("spJoinApproveList", spJoinApproveList);
				modelMap.addAttribute("playListCurPage", playListCurPage);
				modelMap.addAttribute("playListPaging", playListPaging);
				
				
			}
		}
		else
		{
			modelMap.addAttribute("promSeq", null);
		}
		
		modelMap.addAttribute("coCookie", coCookie);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		
		return "/user/coMyPagePlayList";
	}
}
