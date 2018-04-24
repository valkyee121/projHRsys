package com.yao.dao;

import com.yao.model.InterView;

import java.util.List;
import java.util.Map;

public interface InterViewMapper {
    boolean saveInterView (InterView interView);
    boolean updateInterView (InterView interView);
    boolean deleteInterView (InterView interView);
    InterView findThisIV (InterView interView);
    List<InterView> listAll (Map map);
}
