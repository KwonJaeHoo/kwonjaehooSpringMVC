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

import com.sist.common.util.CookieUtil;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.service.BoardService;

@Controller("IndexController")
public class IndexController 
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Value("#{env['auth.cookie.company']}")
	private String AUTH_COOKIE_COMPANY;
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/index")
	public String index(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String coCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_COMPANY);
		
		SpProm spProm = new SpProm();
		
		spProm.setStartRow(1);
		spProm.setEndRow(3);
		
		List<SpProm> spPromListNew = boardService.SpPromList(spProm);
		
		spProm.setSearchSort("3");
		List<SpProm> spPromListRead = boardService.SpPromList(spProm);
		
		modelMap.addAttribute("spPromListNew", spPromListNew);
		modelMap.addAttribute("spPromListRead", spPromListRead);
		modelMap.addAttribute("nmCookie", nmCookie);
		modelMap.addAttribute("coCookie", coCookie);
		
		return "/index";
	}
}