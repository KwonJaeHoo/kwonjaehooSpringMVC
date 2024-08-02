package com.sist.withSports.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.sist.withSports.dao.KakaoDao;
import com.sist.withSports.kakao.KakaoPayApprove;
import com.sist.withSports.kakao.KakaoPayCancel;
import com.sist.withSports.kakao.KakaoPayOrder;
import com.sist.withSports.kakao.KakaoPayReady;
import com.sist.withSports.model.SpJoinApprove;
import com.sist.withSports.model.SpJoinCancel;

@Service("KakaoService")
public class KakaoService 
{
	private static Logger logger = LoggerFactory.getLogger(KakaoService.class);
	
	@Autowired
	KakaoDao kakaoDao;
	
	//kakaoPay host
	@Value("#{env['kakao.pay.host']}")
	private String KAKAO_PAY_HOST;
	
	//kakaoPay adminKey
	@Value("#{env['kakao.pay.admin.key']}")
	private String KAKAO_PAY_ADMIN_KEY;
	
	//kakaoPay 가맹점 code
	@Value("#{env['kakao.pay.cid']}")
	private String KAKAO_PAY_CID;
	
	//결제 url
	@Value("#{env['kakao.pay.request.ready.url']}")
	private String KAKAO_PAY_REQUEST_READY_URL;
	
	//결제 요청 url
	@Value("#{env['kakao.pay.request.approve.url']}")
	private String KAKAO_PAY_REQUEST_APPROVE_URL;
	
	//결제 취소 url
	@Value("#{env['kakao.pay.request.cancel.url']}")
	private String KAKAO_PAY_REQUEST_CANCEL_URL;
	
	//response 받을 결제 성공, 취소, 실패
	@Value("#{env['kakao.pay.success.url']}")
	private String KAKAO_PAY_SUCCESS_URL;
	
	@Value("#{env['kakao.pay.cancel.url']}")
	private String KAKAO_PAY_CANCEL_URL;
	
	@Value("#{env['kakao.pay.fail.url']}")
	private String KAKAO_PAY_FAIL_URL;
	
	
	public KakaoPayReady kakaoPayReady(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayReady kakaoPayReady = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders httpHeaders = new HttpHeaders();
			
			httpHeaders.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			httpHeaders.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			params.add("cid", KAKAO_PAY_CID);
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
			params.add("item_name", kakaoPayOrder.getItemName());
			params.add("item_code", kakaoPayOrder.getItemCode());
			params.add("quantity", String.valueOf(kakaoPayOrder.getQuantity()));
			params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));
			params.add("tax_free_amount", String.valueOf(kakaoPayOrder.getTaxFreeAmount()));
		
			params.add("approval_url", KAKAO_PAY_SUCCESS_URL);
			params.add("cancel_url", KAKAO_PAY_CANCEL_URL);
			params.add("fail_url", KAKAO_PAY_FAIL_URL);
			
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, httpHeaders);
			
			try
			{
				kakaoPayReady = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_REQUEST_READY_URL), body, KakaoPayReady.class);
			
				if(kakaoPayReady != null)
				{
					kakaoPayOrder.settId(kakaoPayReady.getTid());
				}
			} 
			catch (URISyntaxException e) 
			{
				logger.error("[KakaoService] kakaoPayReady URISyntaxException" + e);
			}
		}
		else
		{
			logger.error("[KakaoService] kakaoPayReady kakaoPayOrder is null");
		}
		
		return kakaoPayReady;
	}
	
	public KakaoPayApprove kakaoPayApprove(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders httpHeaders = new HttpHeaders();
			
			httpHeaders.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			httpHeaders.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			params.add("cid", KAKAO_PAY_CID);
			params.add("tid", kakaoPayOrder.gettId());
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
			params.add("pg_token", kakaoPayOrder.getPgToken());
			
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String,String>>(params, httpHeaders);
			
			try
			{
				kakaoPayApprove = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_REQUEST_APPROVE_URL), body, KakaoPayApprove.class);
			} 
			catch (URISyntaxException e) 
			{
				logger.error("[KakaoPayService] kakaoPayApprove URISyntaxException" + e);
			}
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayApprove kakaoPayOrder is null");
		}
		
		return kakaoPayApprove;
	}
	
	
	public KakaoPayCancel kakaoPayCancel(SpJoinApprove spJoinApprove)
	{
		KakaoPayCancel kakaoPayCancel = null;
		
		if(spJoinApprove != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders httpHeaders = new HttpHeaders();
			
			httpHeaders.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			httpHeaders.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			MultiValueMap<String, Object> params = new LinkedMultiValueMap<String, Object>();
			
			params.add("cid", KAKAO_PAY_CID);
			params.add("tid", spJoinApprove.getTid());
			params.add("cancel_amount", spJoinApprove.getTotalAmount());
			params.add("cancel_tax_free_amount", spJoinApprove.getTaxFreeAmount());
			
			HttpEntity<MultiValueMap<String, Object>> body = new HttpEntity<MultiValueMap<String, Object>>(params, httpHeaders);
			
			try
			{
				kakaoPayCancel = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_REQUEST_CANCEL_URL), body, KakaoPayCancel.class);
			} 
			catch (URISyntaxException e) 
			{
				logger.error("[KakaoService] kakaoPayCancel URISyntaxException" + e);
			}
		}
		else
		{
			logger.error("[KakaoService] kakaoPayCancel spJoinApprove is null");
		}
		
		return kakaoPayCancel;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public List<SpJoinApprove> KakaoApproveList(SpJoinApprove spJoinApprove)
	{
		List<SpJoinApprove> SpJoinApproveList = null;
		
		try 
		{
			SpJoinApproveList = kakaoDao.KakaoApproveList(spJoinApprove);
		} 
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoApproveList Exception Error" + e);
		}
		
		return SpJoinApproveList;
	}
	
	public long KakaoApproveCount(SpJoinApprove spJoinApprove)
	{
		long cnt = 0;

		try 
		{
			cnt = kakaoDao.KakaoApproveCount(spJoinApprove);
		} 
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoApproveCount Exception Error" + e);
		}
		
		return cnt;
	}
	
	public List<SpJoinCancel> KakaoCancelList(SpJoinCancel spJoinCancel)
	{
		List<SpJoinCancel> SpJoinCancelList = null;
		
		try 
		{
			SpJoinCancelList = kakaoDao.KakaoCancelList(spJoinCancel);
		}
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoCancelList Exception Error" + e);
		}
		
		return SpJoinCancelList;
	}
	
	
	public long KakaoCancelCount(SpJoinCancel spJoinCancel)
	{
		long cnt = 0;
		
		try 
		{
			cnt = kakaoDao.KakaoCancelCount(spJoinCancel);
		}
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoCancelCount Exception Error" + e);
		}
		
		return cnt;
	}
	
	
	
	
	
	
	public SpJoinApprove KakaoapproveSelect(String partnerOrderId, String partnerUserId)
	{
		SpJoinApprove spJoinApprove = null;
		
		try 
		{
			spJoinApprove = kakaoDao.KakaoapproveSelect(partnerOrderId, partnerUserId);
		} 
		catch (Exception e) 
		{
			logger.error("[KakaoService] SpPromViewLikeSelect Exception Error" + e);
		}
		
		return spJoinApprove;
	}
	
	public int KakaoApproveInsert(SpJoinApprove spJoinApprove)
	{
		int cnt = 0;
		
		try 
		{
			cnt = kakaoDao.KakaoApproveInsert(spJoinApprove);
		} 
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoApproveInsert Exception Error" + e);
		}
		
		return cnt;
	}
	
	public int KakaoApproveDelete(SpJoinApprove spJoinApprove)
	{
		int cnt = 0;
		
		try 
		{
			cnt = kakaoDao.KakaoApproveDelete(spJoinApprove);
		} 
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoApproveDelete Exception Error" + e);
		}
		
		return cnt;
	}
	
	public int KakaoCancelInsert(SpJoinCancel spJoinCancel)
	{
		int cnt = 0;
		
		try
		{
			cnt = kakaoDao.KakaoCancelInsert(spJoinCancel);
		}
		catch (Exception e) 
		{
			logger.error("[KakaoService] KakaoCancelInsert Exception Error" + e);
		}
		
		return cnt;
	}
}
