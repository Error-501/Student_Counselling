package com.dinesh;


import java.sql.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse; 

@WebServlet("/student") 
public class student extends HttpServlet { 
    private static final long serialVersionUID = 1L;
    String DATABASE_URL = "jdbc:mysql://localhost:3306/counselling?characterEncoding=latin1&useConfigs=maxPerformance";
    protected void doPost(HttpServletRequest request,HttpServletResponse response) 
    throws ServletException,IOException
    {
        int stid;
        String sql = "select max(stud_id) from student";
        String sql1 = "insert into student values(?,?,?,?,?,?)";
        try
        {
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection con = DriverManager.getConnection(DATABASE_URL, "newuser", "password");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            rs.next();
            if(rs.getObject(1) == null)
            {
                stid = 1;
            }
            else
            {
                stid = (int) rs.getObject(1) + 1;
            }
            String name = request.getParameter("sname");
            String maths = request.getParameter("maths");
            String physics = request.getParameter("physics");
            String chemistry = request.getParameter("chemistry");

            // System.out.println(name+" "+maths+" "+physics+" "+chemistry);
            int phy = Integer.parseInt(physics);
            int chem = Integer.parseInt(chemistry);
            int mat = Integer.parseInt(maths);
            float cutoff = (phy + chem + mat) / 3;
            PreparedStatement st1 = con.prepareStatement(sql1);
            st1.setInt(1, stid);
            st1.setString(2, name);
            st1.setInt(3, Integer.parseInt(maths));
            st1.setInt(4, Integer.parseInt(physics));
            st1.setInt(5, Integer.parseInt(chemistry));
            st1.setFloat(6, cutoff);
            st1.executeUpdate();
            response.sendRedirect("college-choice.jsp");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
} 