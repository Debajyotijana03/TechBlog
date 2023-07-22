/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author DEBAJYOTI
 */
public class ManagePostDao {
        Connection con;

    public ManagePostDao(Connection con) {
        this.con = con;
    }
    public boolean deletePostById(int pId){
          boolean f=false;
        try {
            String q="delete from posts where pid=?";
            PreparedStatement p=this.con.prepareStatement(q);
            p.setInt(1, pId);
            p.executeUpdate();
            f=true;
        } catch (Exception e) {
        
        e.printStackTrace();
        }
        return  f;

    }

}

