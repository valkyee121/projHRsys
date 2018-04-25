package com.yao.model;

import java.io.Serializable;

public class InternalPost implements Serializable{
    private int postStatus;

    public int getPostStatus() {
        return postStatus;
    }

    public void setPostStatus(int postStatus) {
        this.postStatus = postStatus;
    }

    @Override
    public String toString() {
        return "InternalPost{" +
                "postStatus=" + postStatus +
                '}';
    }
}
