package com.sist.withSports.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.withSports.dao.UserDao;
import com.sist.withSports.model.SpCoUser;
import com.sist.withSports.model.SpNmUser;

@Service("UserService")
public class UserService 
{
	private Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	public SpNmUser SpNmUserSelect(String nmId)
	{
		SpNmUser spNmUser = null;
		
		try 
		{
			spNmUser = userDao.SpNmUserSelect(nmId);
		}
		catch (Exception e)
		{
			logger.error("[UserService] (SpNmUserSelect) Exception Error \n" + e);
		}
		
		return spNmUser;
	}
	
	public int SpNmCheckSelect(String nmNickname, String nmEmail, String nmTel)
	{
		int cnt = 0;
		
		try 
		{
			if(userDao.SpNmNicknameSelect(nmNickname) == 0)
			{
				if(userDao.SpNmEmailSelect(nmEmail) == 0)
				{
					if(userDao.SpNmTelSelect(nmTel) == 0)
					{
						return cnt;
					}
					else
					{
						cnt = 3;
					}
				}
				else
				{
					cnt = 2;
				}
			}
			else
			{
				cnt = 1;
			}
		} 
		catch (Exception e) 
		{
			logger.error("[UserService] (SpNmCheckSelect) Exception Error \n" + e);
		}
		
		return cnt;
	}
	
	public String SpNmIdPwdFind(SpNmUser spNmUser)
	{
		String nmId = null;
		
		try 
		{
			nmId = userDao.SpNmIdPwdFind(spNmUser);
		}
		catch (Exception e) 
		{
			logger.error("[UserService] (SpNmIdPwdFind) Exception Error \n" + e);
		}
		
		return nmId;
	}
	
	public int SpNmPwdFindChange(SpNmUser spNmUser)
	{
		int cnt = 0;
		
		try 
		{
			cnt = userDao.SpNmPwdFindChange(spNmUser);
		} 
		catch (Exception e) 
		{
			logger.error("[UserService] (SpPwdFindChange) Exception Error \n" + e);
		}
		
		return cnt;
	}

	public int SpNmUserInsert(SpNmUser spNmUser)
	{
		int cnt = 0;
		
		try 
		{
			cnt = userDao.SpNmUserInsert(spNmUser);
		}
		catch (Exception e) 
		{
			logger.error("[UserService] (SpNmUserInsert) Exception Error \n" + e);
		}
		
		return cnt;
	}
	
	public int SpNmUserUpdate(SpNmUser spNmUser)
	{
		int cnt = 0;
		
		try 
		{
			cnt = userDao.SpNmUserUpdate(spNmUser);
		}
		catch (Exception e) 
		{
			logger.error("[UserService] (SpNmUserUpdate) Exception Error \n" + e);
		}
		
		return cnt;
	}
	
	public int SpNmUserSignOut(SpNmUser spNmUser)
	{
		int cnt = 0;
		
		try 
		{
			cnt = userDao.SpNmUserSignOut(spNmUser);
		}
		catch (Exception e) 
		{
			logger.error("[UserService] (SpNmUserSignOut) Exception Error \n" + e);
		}
		
		return cnt;
	}
//-------------------------------------------------------------------------------------------
	
	
	public SpCoUser SpCoUserSelect(String coId)
	{
		SpCoUser spCoUser = null;
		
		try 
		{
			spCoUser = userDao.SpCoUserSelect(coId);
		}
		catch (Exception e)
		{
			logger.error("[UserService] (SpCoUserSelect) Exception Error \n" + e);
		}
		
		return spCoUser;
	}
	
	public int SpCoCheckSelect(String coNum, String coAddr, String coTel, String coEmail)
	{
		int cnt = 0;
		
		try 
		{
			if(userDao.SpCoNumSelect(coNum) == 0)
			{
				if(userDao.SpCoAddrSelect(coAddr) == 0)
				{
					if(userDao.SpCoTelSelect(coTel) == 0)
					{
						if(userDao.SpCoEmailSelect(coEmail) == 0)
						{
							return cnt;
						}
						else
						{
							cnt = 4;
						}
					}
					else
					{
						cnt = 3;
					}
								
				}
				else
				{
					cnt = 2;
				}
			}
			else
			{
				cnt = 1;
			}
		} 
		catch (Exception e) 
		{
			logger.error("[UserService] (SpCoCheckSelect) Exception Error \n" + e);
		}
		
		return cnt;
	}
	
	
	public int SpCoUserInsert(SpCoUser spCoUser)
	{
		int cnt = 0;
		
		try 
		{
			cnt = userDao.SpCoUserInsert(spCoUser);
		}
		catch (Exception e) 
		{
			logger.error("[UserService] (SpCoUserInsert) Exception Error \n" + e);
		}
		
		return cnt;
	}
}
