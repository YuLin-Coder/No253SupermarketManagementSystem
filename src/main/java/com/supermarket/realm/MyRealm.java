package com.supermarket.realm;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.supermarket.entity.User;
import com.supermarket.service.UserService;

public class MyRealm extends AuthorizingRealm {

	@Resource
	private UserService userService;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		return null;
	}

	/**
	 * µÇÂ¼È¨ÏÞ
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName = (String) token.getPrincipal();
		User user = userService.findByUserName(userName);
		if (user != null) {
			AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getUserName(),
					user.getPassword(), "x");
			return authenticationInfo;
		} else {
			return null;
		}
	}

}
