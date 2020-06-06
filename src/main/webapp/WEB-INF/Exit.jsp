<%--
  Created by IntelliJ IDEA.
  User: konradmichalski
  Date: 04/06/2020
  Time: 00:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <script src="webjars/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript"></script>
    <title>Exit</title>
</head>
<body>
<style>
    body{
        text-align: center;
        margin-top: 100px;
        margin-left: 300px;
        margin-right: 300px;
        background-color: paleturquoise;
    }

    h3{
        color: darkorange;
    }
    h2 {
        color: red;
    }

</style>
<div class = "main">
    <h3>Thank you for using the offer </h3> <h2>${users.name} ${users.surname}</h2><br>
    <h3>Have fun!</h3>
    <br>
    <h1>Good bye! :)</h1>
</div>
</body>
</html>
