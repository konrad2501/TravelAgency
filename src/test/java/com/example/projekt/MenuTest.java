package com.example.projekt;

import org.junit.Before;
import org.junit.Test;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.junit.jupiter.api.Assertions.*;

public class MenuTest extends TestStart  {

    @Before
    public void SetUp () {
        super.conf();
    }

    @Test
    public void GetTest() throws Exception {
        String url = "/Menu";
        MvcResult mvcResult = mvc.perform(MockMvcRequestBuilders.get(url)).andReturn();
        int httpStatus = mvcResult.getResponse().getStatus();
        assertEquals(httpStatus, 200);
    }

}