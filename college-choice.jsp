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
ResultSet rs = null;
ResultSet resultSet = null;
String cid="";
float s_cutoff=0;
String s_id="";
String s_name="";
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
        
        <script>
            var checked="0";
            function myFun(checkbox) {
              checked= $('input[name="check"]:checked').val();
              var checkboxes = document.getElementsByClassName('checkboxes');
              Array.from(checkboxes).forEach((item) => {
                if (item !== checkbox) item.checked =  false;
              })
            }
          </script>


        <script>
            $("form3").submit(function(event){
            var data = {
            studid: document.getElementsByName("studid")[0].value,
            check: num.toString(checked),
            };
            $.post("${pageContext.request.contextPath}/allotments", $.param(data), function(responseJSON){
            window.alert(responseJSON.msg);
            });
            });
        </script> 

    </head>
<body>
    <%
    try{
        connection = DriverManager.getConnection(connectionUrl, userid, password);
        statement=connection.createStatement();
        String sql ="select * from student";
        rs = statement.executeQuery(sql);
        if(rs.last()){
            s_cutoff=rs.getFloat("cutoff");
            s_id = rs.getString("stud_id");
            s_name= rs.getString("stud_name");
    %>

    <form method="post" id="form3" action="${pageContext.request.contextPath}/allotments">
    <h1>Colleges Available for
        <%= s_id %> 
        <%= s_name%>
        <input type="hidden" name="studid" value="<%=s_id %>">
    </h1>
        

    <table border="1">
        <tr>
        <td>College Id</td>
        <td>College name</td>
        <td>Available Seats</td>
        <td>Cutoff</td>
        <td>Choices</td>

        </tr>
        <%
    }
        String sql1 ="select * from college ORDER BY cutoff,freecnt DESC;";
        resultSet = statement.executeQuery(sql1);
        while(resultSet.next()){
            cid=resultSet.getString("clg_id");
            String cname=resultSet.getString("clg_name");
            int free=resultSet.getInt("freecnt");
            float cutoff=resultSet.getFloat("cutoff");
            if((s_cutoff>=cutoff)&&(free>0))
            {
        %>
        <tr>
        <td><%=cid%></td>
        <td><%=cname %></td>
        <td><%=free %></td>
        <td><%=cutoff %></td>
        <td><input type="checkbox" name="check" value="<%= cid %>" class="checkboxes" onclick="myFun(this)" />&nbsp;</td>
        </tr>
        <%
            }
        }
        connection.close();
        } catch (Exception e) {
        e.printStackTrace();
        }
        %>
    </table>
    <div class="btn--cont">
        <button type="submit" class="btn foot--btn" form="form3" value="Submit">Select Choice</button>
    </div>
</form>

</body>
</html>