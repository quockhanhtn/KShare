<%--
  Created by IntelliJ IDEA.
  User: quock
  Date: 26-Oct-2020
  Time: 11:50:34
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
    <h1>Order Unsuccessful</h1>
    <p>Error: </p>
    <p style="color:red;">${errorMessage} </p>
    <p>Click <a onClick="goBack()" href="#">this link</a> to return.</p>
</body>

<script>
    function goBack() {
        window.history.back();
    }
</script>

</html>
