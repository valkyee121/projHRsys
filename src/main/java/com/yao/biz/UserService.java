package com.yao.biz;

import com.yao.model.User;

public interface UserService {
    boolean saveUser (User user);
    boolean updateUser (User user);
    boolean deleteUser (User user);
    User findUser (User user);
    User findUserResume (User user);
    User loginUser (User user);
}
