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
    <title>我的缴费记录</title>
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: transparent;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background: #667eea;
            color: white;
        }
        .amount {
            color: #48bb78;
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>我的缴费记录</h2>
    <table>
        <thead>
        <tr><th>ID</th><th>类型</th><th>金额</th><th>支付日期</th><th>支付方式</th><th>状态</th><th>备注</th></tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${payments}">
            <tr>
                <td>${p.id}</td>
                <td>${p.type}</td>
                <td class="amount">¥${p.amount}</td>
                <td>${p.paymentDate}</td>
                <td>${p.method}</td>
                <td>${p.status}</td>
                <td>${p.remark}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty payments}">
            <tr><td colspan="7" style="text-align:center">暂无缴费记录</td></tr>
        </c:if>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/member/dashboard" class="back-link">← 返回会员中心</a>
</div>
</body>
</html>