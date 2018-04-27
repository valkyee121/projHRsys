package com.yao.biz;

import com.yao.model.Trainn;

import java.util.List;

public interface TrainnService {
    boolean saveTrainn (Trainn trainn);
    boolean updateTrainn (Trainn trainn);
    boolean deleteTrainn (Trainn trainn);
    Trainn findTrain (Trainn trainn);
    List<Trainn> listAll ();
}
