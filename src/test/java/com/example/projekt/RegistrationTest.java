package com.example.projekt;


import com.example.projekt.model.User;
import org.junit.Before;
import org.junit.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.junit.jupiter.api.Assertions.*;

public class RegistrationTest extends TestStart {

    @Before
    public void SetUp () {
        super.conf();
    }

    @Test
    public void GetRegistrationTest() throws Exception {
        String uri = "/Registration";
        MvcResult mvcResult = mvc.perform(MockMvcRequestBuilders.get(uri)).andReturn();
        int httpStatus = mvcResult.getResponse().getStatus();
        assertEquals(httpStatus, 200);
    }

    @Test
    public void PostRegistrationTest() throws Exception {
        String uri = "/Registration";
        User user = new User();
        user.setName("anon");
        user.setPassword("asdff");
        user.setPasswordConfirmation("asdff");
        String inputJson = super.mapToJson(user);
        MvcResult mvcResult = mvc.perform(MockMvcRequestBuilders.post(uri).contentType(MediaType.APPLICATION_JSON_VALUE).content(inputJson)).andReturn();
        int httpStatus = mvcResult.getResponse().getStatus();
        assertEquals(302, httpStatus);
    }
}