package com.dinesh;


import java.sql.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.*;

@WebServlet("/allotments") 
public class allotments extends HttpServlet { 
    private static final long serialVersionUID = 1L;
    String DATABASE_URL = "jdbc:mysql://localhost:3306/counselling?characterEncoding=latin1&useConfigs=maxPerformance";
    protected void doPost(HttpServletRequest request,HttpServletResponse response) 
    throws ServletException,IOException
    {
        int allotid=0;
        int capacity=0;
        String sql = "select max(allot_id) from allotment";
        String enrollStudent = "insert into allotment values(?,?,?)";
        String updateCapacity = "update college set freecnt= ? where clg_id= ?";
        String getCapacity = "select freecnt from college where clg_id= ?";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con =DriverManager.getConnection(DATABASE_URL, "newuser", "password");

            Statement st = con.createStatement();
            PreparedStatement rt = con.prepareStatement(getCapacity);

            String sid = request.getParameter("studid");
            String cid = request.getParameter("check");

            ResultSet rs = st.executeQuery(sql);
            rt.setInt(1, Integer.parseInt(cid));
            ResultSet rs1 = rt.executeQuery();
            rs.next();
            if(rs.getObject(1) == null)
            {
                allotid = 1;
            }
            else
            {
                allotid = (int) rs.getObject(1) + 1;
            }

            rs1.next();
            if(rs1.getObject(1) != null)
            {
                capacity = (int) rs1.getObject(1) - 1;
            }
            else{
                response.sendRedirect("college-choice.jsp");
            }

           

            PreparedStatement st1 =
            con.prepareStatement(updateCapacity);
            PreparedStatement st2 =
            con.prepareStatement(enrollStudent);

            st1.setInt(1,capacity);
            st1.setInt(2, Integer.parseInt(cid));

            st2.setInt(1, allotid);
            st2.setInt(2, Integer.parseInt(sid));
            st2.setInt(3, Integer.parseInt(cid));

            st1.executeUpdate();
            st2.executeUpdate();

            response.sendRedirect("allotments.jsp");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
} 