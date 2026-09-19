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
    <title>选择支付方式</title>
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
            width: 450px;
            text-align: center;
        }
        h2 { margin-bottom: 20px; color: #333; }
        .info { margin-bottom: 20px; color: #555; font-size: 16px; }
        .payment-methods {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }
        .payment-methods label {
            cursor: pointer;
            padding: 10px 20px;
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: 0.3s;
        }
        .payment-methods label:hover,
        .payment-methods input[type="radio"]:checked + label {
            border-color: #667eea;
            background-color: #f0f0ff;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn:hover { background-color: #5a67d8; }
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
    <h2>确认支付</h2>
    <div class="info">
        <p>会员类型：<strong>${membershipType}</strong></p>
        <p>到期日期：<strong>${expiryDate}</strong></p>
        <p>支付金额：<strong>¥${amount}</strong></p>
    </div>

    <form action="${pageContext.request.contextPath}/member/showQR" method="get">
        <input type="hidden" name="membershipType" value="${membershipType}">
        <input type="hidden" name="expiryDate" value="${expiryDate}">

        <div class="payment-methods">
            <input type="radio" name="method" value="支付宝" id="alipay" required>
            <label for="alipay">支付宝</label>
            <input type="radio" name="method" value="微信" id="wechat">
            <label for="wechat">微信支付</label>
        </div>

        <button type="submit" class="btn">生成支付码</button>
    </form>

    <a href="${pageContext.request.contextPath}/member/card" class="back-link">← 返回重新选择</a>
</div>
</body>
</html>