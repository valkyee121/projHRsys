package com.yao.biz;

import com.yao.model.InterView;

import java.util.List;
import java.util.Map;

public interface InterViewService {
    boolean saveInterView (InterView interView);
    boolean updateInterView (InterView interView);
    boolean deleteInterView (InterView interView);
    InterView findThisIV (int resuID, int reID);
    InterView finfIvById (InterView interView);
    List<InterView> listAll (int resuID);
}
