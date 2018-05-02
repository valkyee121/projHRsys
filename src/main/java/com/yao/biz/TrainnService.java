package com.yao.biz;

import com.yao.model.Trainn;

import java.util.List;
import java.util.Map;

public interface TrainnService {
    boolean saveTrainn (Trainn trainn);
    boolean updateTrainn (Trainn trainn);
    boolean deleteTrainn (Trainn trainn);
    Trainn findTrain (Trainn trainn);
    List<Trainn> findWithEmp (Trainn trainn);
    List<Trainn> listPast (Map map);
    List<Trainn> listCurr ();
    boolean saveTrEmp (List<Object> empList,int trId);
}
