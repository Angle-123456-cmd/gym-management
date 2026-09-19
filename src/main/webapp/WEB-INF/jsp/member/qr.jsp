<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>扫码支付</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-image: url('${pageContext.request.contextPath}/images/login-bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: -1;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }
        h2 { margin-bottom: 20px; color: #333; }
        .qr-image {
            width: 200px;
            height: 200px;
            margin: 20px auto;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
        }
        .qr-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn:hover { background-color: #218838; }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h2>扫码支付</h2>
    <p>请使用 <strong>${method}</strong> 扫码完成支付</p>

    <div class="qr-image">
        <c:choose>
            <c:when test="${method == '微信'}">
                <img src="${pageContext.request.contextPath}/images/wx.jpg" alt="微信支付二维码">
            </c:when>
            <c:when test="${method == '支付宝'}">
                <img src="${pageContext.request.contextPath}/images/zfb.jpg" alt="支付宝支付二维码">
            </c:when>
            <c:otherwise>
                <p>未知支付方式</p>
            </c:otherwise>
        </c:choose>
    </div>

    <form action="${pageContext.request.contextPath}/member/confirmPay" method="post">
        <input type="hidden" name="membershipType" value="${membershipType}">
        <input type="hidden" name="expiryDate" value="${expiryDate}">
        <input type="hidden" name="method" value="${method}">
        <button type="submit" class="btn">已完成支付</button>
    </form>

    <a href="${pageContext.request.contextPath}/member/card" class="back-link">← 返回重新选择</a>
</div>
</body>
</html>