package com.sist.withSports.dao;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.SpCoUser;
import com.sist.withSports.model.SpNmUser;

@Repository("UserDao")
public interface UserDao 
{
	public SpNmUser SpNmUserSelect(String nmId);
	
	public int SpNmNicknameSelect(String nmNickname);
	
	public int SpNmEmailSelect(String nmEmail);
	
	public int SpNmTelSelect(String nmTel);
	
	public String SpNmIdPwdFind(SpNmUser spNmUser);
	
	public int SpNmPwdFindChange(SpNmUser spNmUser);
	
	public int SpNmUserInsert(SpNmUser spNmUser);
	
	public int SpNmUserUpdate(SpNmUser spNmUser);
	
	public int SpNmUserSignOut (SpNmUser spNmuser);

	//-----------------------------------------------
	
	public SpCoUser SpCoUserSelect(String coId);
	
	public int SpCoNumSelect(String coNum);
	
	public int SpCoAddrSelect(String coAddr);
	
	public int SpCoTelSelect(String coTel);
	
	public int SpCoEmailSelect(String coEmail);
	
	public int SpCoUserInsert(SpCoUser spCoUser);
	
}
