package com.demo.app.restapi.impl;


import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("status")
public class Status {

    @GET
    @Produces("text/plain")
    public String getStatus() {
        return "!!active!!";
    }
}
