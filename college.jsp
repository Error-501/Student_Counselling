<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Student Counselling</title>
    
    <!-- jQuery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
    
    <script>
        $("form2").submit(function(event){
        var data = {
        cname: document.getElementsByName("cname")[0].value,
        free:document.getElementsByName("free")[0].value,
        cutoff:document.getElementsByName("cutoff")[0].value
        }; 
        $.post("${pageContext.request.contextPath}/college", $.param(data), function(responseJSON){
        window.alert(responseJSON.msg);
        });
        });
    </script>

    <link rel='stylesheet' href='master.css'>
</head>
<body>
    <header>
    	<h1>College Form</h1>
    	<button class='head--btn'><a href="college-disp.jsp">Colleges</a></button>
    </header>
    
    <form id="form2" action="${pageContext.request.contextPath}/college" method="post">
        <div class="container">
            <label for="cname"><b>College Name</b></label>
            <input type="text" name="cname" placeholder="Enter College Name" required>
            <label for="free"><b>Available Seats</b></label>
            <input type="text" name="free" placeholder="Enter Available Seats" required>
            <label for="cutoff"><b>Minimum Cutoff</b></label>
            <input type="text" name="cutoff" placeholder="Enter Minimum Cutoff" required>
 
            <button type="submit" class="btn" form="form2" value="Submit">Add College</button>
        </div>
      </form>
</body>
</html>