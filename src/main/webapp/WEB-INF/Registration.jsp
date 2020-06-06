<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: konradmichalski
  Date: 11/03/2020
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rejestracja</title>
</head>
<body>
<h1>Rejestracja</h1>
<style>
    body {
        margin-top:100px;
        margin-left: auto;
        margin-right: auto;
        text-align: center;
        padding:0;
        width: 100%;
        height: 100%;
        background-color: paleturquoise;
    }

    h1 {
        color: orange;
    }

    .error {
        color: #ff0000;
    }
    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 3px solid #ff0000;
        padding: 8px;
        margin: 16px;
    }
</style>
<form:form modelAttribute="Registration">
    <form:errors path="*" cssClass="errorblock" element="div"/>
    <table border-collapse="2px" align="center">
        <tr>
            <td>
                Imie:
            </td>
            <td>
                <form:input path="name"/>
            </td>

            <td>
                Nazwisko:
            </td>
            <td>
                <form:input path="surname"/>
            </td>
            <td>
                Hasło:
            </td>
            <td>
                <form:input type="password" path="password"/>
            </td>
            <td>
                Potwierdź hasło:
            </td>
            <td>
                <form:input type="password" path="passwordConfirmation"/>
            </td>
        </tr>
    </table>
    <br><br>
    <input type="submit" value="Zarejestruj" onclick="myFunction()">
    <div id="text" style="margin-top: 10px">
    </div>
</form:form>
</body>
</html>

<script>
    function myFunction() {
        document.getElementById("text").innerHTML = "Analyzes ....";
        document.getElementById("text").children.style.display = 'block';
    }
</script>

