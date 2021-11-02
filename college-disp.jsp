<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost/counselling?characterEncoding=latin1&useConfigs=maxPerformance";
String userid = "newuser";
String password = "password";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Student Counselling</title>

        <link rel="stylesheet" href="master.css">
        
        <!-- jQuery CDN -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
    </head>
<body>
    <h1>Colleges Available</h1>
    <table border="1">
        <tr>
        <td>College Id</td>
        <td>College name</td>
        <td>Available Seats</td>
        <td>Cutoff</td>

        </tr>
        <%
        try{
        connection = DriverManager.getConnection(connectionUrl, userid, password);
        statement=connection.createStatement();
        String sql ="select * from college";
        resultSet = statement.executeQuery(sql);
        while(resultSet.next()){
        %>
        <tr>
        <td><%=resultSet.getString("clg_id") %></td>
        <td><%=resultSet.getString("clg_name") %></td>
        <td><%=resultSet.getString("freecnt") %></td>
        <td><%=resultSet.getString("cutoff") %></td>
        </tr>
        <%
        }
        connection.close();
        } catch (Exception e) {
        e.printStackTrace();
        }
        %>
    </table>
</body>
</html>