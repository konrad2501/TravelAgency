<%--
  Created by IntelliJ IDEA.
  User: konradmichalski
  Date: 01/06/2020
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Faktura</title>
</head>
<body>
<style>
    body{
        text-align: center;
        margin-top: 20px;
        margin-left: 300px;
        margin-right: 300px;
        background-color: paleturquoise;
    }
    h1, h3{
        color: darkorange;
    }

    a{
        font: 18px Arial;
        color: red;
        font-weight: bold;
        text-align: center;
    }

    table{
        margin-left: auto;
        margin-right: auto;
        border: 1px solid black;
        border-collapse: collapse;
    }

    table td{
        border: 1px solid black;
        padding: 5px;
    }
    label{
        background-color: orange;
    }
</style>
<div class = "main">
<c:if test="${logged}">
    <h1>Dane faktury</h1>
    <table id="menu">
        <tr>
            <td>
                <b>Imię</b> :
                ${users.name}
            </td>
        </tr>
            <td>
                <b>Nazwisko</b> :
                ${users.surname}
            </td>
        </tr>
        <tr>
            <td>
                <b>Email</b> :
                    ${orders.email}
            </td>
        </tr>
        <tr>
        <td>
            <b>Numer</b> :
                ${orders.number}
        </td>
        </tr>
        <tr>
            <td>
                <b>Całkowity koszt</b> :
                    ${orders.total} zł
            </td>
        </tr>
        <tr>
            <td>
                <b>Data złożenia zamówienia</b> :
                    ${orders.date}
            </td>
        </tr>
    </table>
    <h2> Bilety :</h2>
    <table>
        <c:forEach var="tour" items="${tours}">
            <table>
            <tr style="background-color: orange">
                <td>
                    <b>Kraj</b> : ${tour.country}
                </td>
            </tr>
            <tr>
                <td>
                    <b>Miasto</b> : ${tour.city}
                </td>
            </tr>
            <tr>
                <td>
                    <b>Cena</b> : ${tour.price} zł/1 os.
                </td>
            </tr>
            <tr>
                <td>
                    <b>Liczba dni</b> : ${tour.days}
                </td>
            </tr>
            <tr>
                <td>
                    <b>Data odlotu</b> : ${tour.departure}
                </td>
            </tr>
            <tr>
                <td>
                    <b>Data przylotu</b> : ${tour.arrival}
                </td>
            </tr>
            </table>
            <br>
        </c:forEach>
    </table>
</c:if>
</div>
<div class="bottom">
    <a href="Exit" type="submit" id="finished">Dalej</a>
</div>
</body>
</html>
