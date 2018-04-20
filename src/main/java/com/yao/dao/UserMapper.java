package com.yao.dao;

import com.yao.model.User;

public interface UserMapper {
    boolean saveUser (User user);
    boolean updateUser (User user);
    boolean deleteUser (User user);
    User findUser (User user);
    User loginUser (User user);
}
