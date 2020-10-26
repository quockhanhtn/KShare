<%--
  Created by IntelliJ IDEA.
  User: quock
  Date: 26-Oct-2020
  Time: 11:50:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>MVC example - Khanh Lam - github@quockhanhtn</title>
    <link rel="icon" type="image/png" href="https://quockhanh.dev/favicon.png" />
</head>
<body>

<h1>Widget Order Form</h1>

<form action="order-reply" method="get">
    <table cellspacing="5">
        <tr>
            <td align="right"><label for="order-quantity">Number to purchase:</label></td>
            <td><input type="number" name="order-quantity" id="order-quantity"></td>
        </tr>
        <tr>
            <td align="right"><label for="customer-name">Your name:</label></td>
            <td><input type="text" name="customer-name" id="customer-name"></td>
        </tr>
        <tr>
            <td align="right"><label for="customer-email">Your email:</label></td>
            <td><input type="email" name="customer-email" id="customer-email"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Place Order" class="btn btn-primary"></td>
        </tr>
    </table>
</form>

</body>
</html>
