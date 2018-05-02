package com.yao.util;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomerDate implements WebBindingInitializer {
    @Override
    public void initBinder(WebDataBinder webDataBinder, WebRequest webRequest) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH24:mm");
        webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
    }
}
