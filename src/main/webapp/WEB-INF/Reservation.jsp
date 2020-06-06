<%--
  Created by IntelliJ IDEA.
  User: konradmichalski
  Date: 01/06/2020
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Reservation</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <script src="webjars/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript"></script>
</head>
<style>
    body{
        text-align: center;
        background-color: paleturquoise;
        margin: 20px;
        width: 100%;
        height: 100%;
    }

    h1, h4{
        color: orange;
    }

</style>
<body>

<c:if test="${logged}">
    <h1>Zarezerwowane wycieczki: </h1>
    <br>
    <table id="menu" align="center">
        <c:forEach var="tour" begin = "0" items="${tours}">
            <tr id="${tour}">
                <td>
                    <label>${tour.city} </label>
                </td>
                <td>
                    <label> - ${tour.price} zł</label>
                <td>
                    <input type="submit" id="${tour}" value=" X " style="color: red" onclick="removedRes(this, ${tour.idTour})"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <form:form>
        <table align="center">
            <br>
            <h4> Podaj dane do faktury : </h4>
            <br>
            <tr>
                <td>
                    <label>Email:</label>
                </td>
                <td>
                    <input id="email"/>
                </td>
            </tr>
            <tr><td><hr></td><td><hr></td></tr>
            <tr>
                <td>
                    <label>Telefon:</label>
                </td>
                <td>
                    <input id="number"/>
                </td>
            </tr>
        </table>
        <br>
        <a href="Invoice" type="button" onclick="finish()">Rezerwuj</a>
    </form:form>
</c:if>
</body>
</html>
<script>
    var removedReservation = [];
    function removedRes(button, idTour)
    {
        removedReservation.push(idTour);
        var i = button.id;
        document.getElementById(i).hidden = true;
        //document.getElementById(i).style.visibility = "hidden";
    }

    function finish() {
        var email = document.getElementById("email").value;
        var number = document.getElementById("number").value;
        var dir =
            {
                removedReservation: removedReservation,
                email: email,
                number: number
            };
        $.ajax({
            url: "Reservation",
            type: 'POST',
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            data: JSON.stringify(dir),
        }).done(function (result) {
        })
    }
</script>

