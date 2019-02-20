package com.bootdo.clouddoadmin.service.impl;

import com.bootdo.clouddoadmin.dao.UserDao;
import com.bootdo.clouddoadmin.domain.UserDO;
import com.bootdo.clouddoadmin.secuity.CurrentUser;
import com.bootdo.clouddocommon.exception.CDException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

/**
 * @author bootdo
 */
@Component
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        List<UserDO> userDOS = userDao.list(new HashMap<String, Object>() {{
            put("username", username);
        }});
        if (userDOS.size() < 1) {
            throw new CDException("用户名或密码错误！");
        }
        return new CurrentUser(username, userDOS.get(0).getPassword(), userDOS.get(0).getUserId(), new HashSet<>());
    }
}
