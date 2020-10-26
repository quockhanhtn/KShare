<%--
  Created by IntelliJ IDEA.
  User: quock
  Date: 26-Oct-2020
  Time: 11:50:50
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
    <h1>Order Confirmation</h1>
    <p>Thank you for your order of ${orderDetail.getQuantity()} widgets, <b>${orderDetail.getCustomerName()}</b></p>
    <p>At $${pricePerUnit}, your bill will be $${orderDetail.getTotalPrice()}></p>
    <p>You will shortly receive an email confirmation at ${orderDetail.getCustomerEmail()}.</p>
</body>

</html>
