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
        $("form1").submit(function(event){
        var data = {
        sname: document.getElementsByName("sname")[0].value,
        maths: document.getElementsByName("maths")[0].value,
        physics:document.getElementsByName("physics")[0].value,
        chemistry:document.getElementsByName("chemistry")[0].value
        }; 
        $.post("${pageContext.request.contextPath}/student", $.param(data), function(responseJSON){
        window.alert(responseJSON.msg);
        });
        });
    </script> 
    
    <link rel='stylesheet' href='master.css'>
</head>
<body>
    
    <header>
    	<h1>Student Form</h1>
           
    </header>
    
    <form method="post" id="form1" action="${pageContext.request.contextPath}/student" >
        <div class="container">
        	<p>Please fill in this form to create your choicelist </p>
            <label for="sname"><b>Student Name</b></label>
            <input type="text" name="sname" placeholder="Enter Fullname" required>
          	 <label for="maths"><b>Maths Marks</b></label>
            <input type="text" name="maths" placeholder="Enter math marks" required>
           <label for="physics"><b>Physics Marks</b></label>
            <input type="text" name="physics" placeholder="Enter physics marks" required>
            <label for="chemistry"><b>Chemistry Marks</b></label>
            <input type="text" name="chemistry" placeholder="Enter chemistry marks" required>
            <button type="submit" form="form1" value="Submit">Fetch Colleges</button>
        </div>
    </form>
</body>
</html>