package com.sist.withSports.controller;

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

import com.google.gson.JsonObject;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.kakao.KakaoPayApprove;
import com.sist.withSports.kakao.KakaoPayCancel;
import com.sist.withSports.kakao.KakaoPayOrder;
import com.sist.withSports.kakao.KakaoPayReady;
import com.sist.withSports.model.Response;
import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpJoinCancel;
import com.sist.withSports.model.SpProm;
import com.sist.withSports.service.BoardService;
import com.sist.withSports.service.KakaoService;


@Controller("KakaoController")
public class KakaoController
{
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private BoardService boardService;
	
	private static Logger logger = LoggerFactory.getLogger(KakaoController.class);
	
	@RequestMapping(value="/kakao/paymentReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> kakaoPayReady(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxResponse = new Response<Object>();

		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		
		String itemCode = HttpUtil.get(httpServletRequest, "itemCode", "");
		String itemName = HttpUtil.get(httpServletRequest, "itemName", "");
		int quantity = HttpUtil.get(httpServletRequest, "quantity", 0);
		int totalAmount = HttpUtil.get(httpServletRequest, "totalAmount", 0);
		
		int taxFreeAmount = HttpUtil.get(httpServletRequest, "taxFreeAmount", 0);
		int vatAmount = HttpUtil.get(httpServletRequest, "vatAmount", 0);
		
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
//		//주문번호 - 유일값
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = kakaoService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayReady != null)
		{
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			
			ajaxResponse.setResponse(200, "Success", json);
			
		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String pcUrl = HttpUtil.get(httpServletRequest, "pcUrl", "");
		String orderId = HttpUtil.get(httpServletRequest, "orderId", "");
		String tId = HttpUtil.get(httpServletRequest, "tId", "");
		
		String userId = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);

		modelMap.addAttribute("pcUrl", pcUrl);
		modelMap.addAttribute("orderId", orderId);
		modelMap.addAttribute("tId", tId);
		modelMap.addAttribute("userId", userId);
		
		return "/kakao/payPopUp";
	}
	
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String pgToken = HttpUtil.get(httpServletRequest,"pg_token", "");
		String userId = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);

		modelMap.addAttribute("pgToken", pgToken);
		modelMap.addAttribute("userId", userId);
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String tId = HttpUtil.get(httpServletRequest, "tId", "");
		String orderId = HttpUtil.get(httpServletRequest, "orderId", "");
		String userId = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String pgToken = HttpUtil.get(httpServletRequest, "pgToken", "");
	
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoService.kakaoPayApprove(kakaoPayOrder);
		
		if(kakaoPayApprove != null)
		{
			SpJoinApprove spJoinApprove = new SpJoinApprove();
		
			spJoinApprove.setCid(kakaoPayApprove.getCid());
			spJoinApprove.setTid(kakaoPayApprove.getTid());
			spJoinApprove.setPartnerOrderId(kakaoPayApprove.getPartner_order_id());
			spJoinApprove.setPartnerUserId(kakaoPayApprove.getPartner_user_id());
			spJoinApprove.setItemCode(kakaoPayApprove.getItem_code());
			spJoinApprove.setItemName(kakaoPayApprove.getItem_name());
			spJoinApprove.setTotalAmount(kakaoPayApprove.getAmount().getTotal());
			spJoinApprove.setTaxFreeAmount(kakaoPayApprove.getAmount().getTax_free());
			
			//여긴 결제 성공하면 결제내역 + 1 
			if(kakaoService.KakaoApproveInsert(spJoinApprove)> 0)
			{
				SpProm spProm = boardService.SpPromSelect(Long.parseLong(spJoinApprove.getItemCode()), "N"); 
				boardService.SpPromViewJoinInsertCntUpdate(spProm);
			}
		}
		
		modelMap.addAttribute("kakaoPayApprove", kakaoPayApprove);
		modelMap.addAttribute("userId", userId);
		
		return "/kakao/payResult";
	}
	
	@RequestMapping(value="/kakao/payFail")
	public String payFail(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String userId = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		modelMap.addAttribute("userId", userId);
		
		return "/kakao/payFail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/kakao/paymentCancel")
	public Response<Object> paymentCancel(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxRes = new Response<Object>();
		
		String nmCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		String partnerOrderId = HttpUtil.get(httpServletRequest, "partnerOrderId", "");
		
		SpJoinApprove spJoinApprove  = kakaoService.KakaoapproveSelect(partnerOrderId, nmCookie);
		
		KakaoPayCancel kakaoPayCancel = kakaoService.kakaoPayCancel(spJoinApprove);
		
		if(kakaoPayCancel != null)
		{
			SpJoinCancel spJoinCancel = new SpJoinCancel();
			
			spJoinCancel.setCid(kakaoPayCancel.getCid());
			spJoinCancel.setTid(kakaoPayCancel.getTid());
			spJoinCancel.setPartnerOrderId(kakaoPayCancel.getPartner_order_id());
			spJoinCancel.setPartnerUserId(kakaoPayCancel.getPartner_user_id());
			spJoinCancel.setItemCode(kakaoPayCancel.getItem_code());
			spJoinCancel.setItemName(kakaoPayCancel.getItem_name());
			spJoinCancel.setCancelTotalAmount(kakaoPayCancel.getAmount().getTotal());
			spJoinCancel.setCancelTaxFreeAmount(kakaoPayCancel.getAmount().getTax_free());
			
			if(kakaoService.KakaoApproveDelete(spJoinApprove) > 0 && kakaoService.KakaoCancelInsert(spJoinCancel) > 0)
			{
				SpProm spProm = boardService.SpPromSelect(Long.parseLong(spJoinApprove.getItemCode()), "N"); 
				boardService.SpPromViewJoinDeleteCntUpdate(spProm);
				ajaxRes.setResponse(200, "Ok");
			}						
		}
		else
		{
			ajaxRes.setResponse(-1, "fail", null);
		}
		
		return ajaxRes;
	}
	
	
}
