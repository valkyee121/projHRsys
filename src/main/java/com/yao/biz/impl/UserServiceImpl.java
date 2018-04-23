package com.yao.biz.impl;

import com.yao.biz.UserService;
import com.yao.dao.UserMapper;
import com.yao.model.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public boolean saveUser(User user) {
        return userMapper.saveUser(user);
    }

    @Override
    public boolean updateUser(User user) {
        return userMapper.updateUser(user);
    }

    @Override
    public boolean deleteUser(User user) {
        return userMapper.deleteUser(user);
    }

    @Override
    public User findUser(User user) {
        return userMapper.findUser(user);
    }

    @Override
    public User findUserResume(User user) {
        return userMapper.findUserResume(user);
    }

    @Override
    public User loginUser(User user) {
        return userMapper.loginUser(user);
    }

}
