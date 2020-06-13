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
        background-image: url("https://www.tanie-loty.com.pl/czytelnia/wp-content/uploads/2018/03/samolot-chmury-zachód-słońca-shutterstock_272190545.jpg");
    }

    h2 {
        color: red;
    }

    img{
        margin-left: auto;
        margin-right: auto;
        width: 400px;
        height: 400px;
    }

</style>
<div class = "main">
    <hr>
    <h3>Thank you for using the offer </h3> <h2>${users.name} ${users.surname}</h2><br>
    <h3>Have fun!</h3>
    <br>
    <h1>Good bye! :)</h1>
    <hr>
</div>
</body>
</html>
