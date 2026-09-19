<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Date" %>
<%
    com.gym.model.Member member = (com.gym.model.Member) request.getAttribute("member");
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>办理卡信息</title>
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
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #5a67d8;
        }
        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
    <h2>办理/升级会员卡</h2>
    <!-- 修改 action 为 /member/pay，按钮文字改为“下一步：选择支付方式” -->
    <form action="${pageContext.request.contextPath}/member/pay" method="post">
        <div class="form-group">
            <label>会员姓名</label>
            <input type="text" value="<%= member.getName() %>" disabled>
        </div>
        <div class="form-group">
            <label>当前会员类型</label>
            <input type="text" value="<%= member.getMembershipType() %>" disabled>
        </div>
        <div class="form-group">
            <label>新会员类型</label>
            <select name="membershipType">
                <option value="月卡">月卡</option>
                <option value="季卡">季卡</option>
                <option value="年卡">年卡</option>
            </select>
        </div>
        <div class="form-group">
            <label>新到期日期</label>
            <input type="date" name="expiryDate" required>
        </div>
        <button type="submit">下一步：选择支付方式</button>
    </form>

    <!-- 操作结果提示（支付完成后返回会显示） -->
    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <a href="${pageContext.request.contextPath}/member/dashboard" class="back-link">← 返回会员中心</a>
</div>
</body>
</html>