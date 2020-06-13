package com.example;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.User;
import org.junit.Before;
import org.junit.Test;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.junit.jupiter.api.Assertions.*;

public class LoginTest extends TestStart {

    @Before
    public void SetUp() {
        super.conf();
    }

    @Test
    public void GetLoginTest() throws Exception {
        String uri = "/Login";
        MvcResult mvcResult = mvc.perform(MockMvcRequestBuilders.get(uri)).andReturn();
        int httpStatus = mvcResult.getResponse().getStatus();
        assertEquals(httpStatus, 200);
    }

}