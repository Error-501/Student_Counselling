package com.dinesh;


import java.sql.*;
import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; 

@WebServlet("/college") 
public class college extends HttpServlet { 
    private static final long serialVersionUID = 1L;
    String DATABASE_URL = "jdbc:mysql://localhost:3306/counselling?characterEncoding=latin1&useConfigs=maxPerformance";
    protected void doPost(HttpServletRequest request,HttpServletResponse response) 
    throws ServletException,IOException
    {
        int cid;
        String sql = "select max(clg_id) from college";
        String sql1 = "insert into college values(?,?,?,?)";
        try
        {
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection con = DriverManager.getConnection(DATABASE_URL, "newuser", "password");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            rs.next();
            if(rs.getObject(1) == null)
            {
                cid = 1;
            }
            else
            {
                cid = (int) rs.getObject(1) + 1;
            }

            String cname = request.getParameter("cname");
            String free = request.getParameter("free");
            String cutoff = request.getParameter("cutoff");
            PreparedStatement st1 = con.prepareStatement(sql1);

            System.out.println(cname);
            st1.setInt(1, cid);
            st1.setString(2, cname);
            st1.setInt(3, Integer.parseInt(free));
            st1.setFloat(4, Float.parseFloat(cutoff));
            st1.executeUpdate();
            response.sendRedirect("college-disp.jsp");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
} 