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
    <title>我的资料</title>
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
            width: 500px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #5a67d8;
        }
        .back-link {
            display: inline-block;
            margin-top: 15px;
            color: #667eea;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .message {
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>我的资料</h2>
    <c:if test="${not empty error}">
        <div class="message error-message">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="message success-message">${message}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/member/profile" method="post">
        <div class="form-group">
            <label>姓名</label>
            <input type="text" name="name" value="${member.name}" required>
        </div>
        <div class="form-group">
            <label>性别</label>
            <select name="gender">
                <option value="男" ${member.gender == '男' ? 'selected' : ''}>男</option>
                <option value="女" ${member.gender == '女' ? 'selected' : ''}>女</option>
            </select>
        </div>
        <div class="form-group">
            <label>手机号</label>
            <input type="text" name="phone" value="${member.phone}" required>
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email" value="${member.email}">
        </div>
        <button type="submit" class="btn">保存修改</button>
    </form>
    <a href="${pageContext.request.contextPath}/member/dashboard" class="back-link">← 返回会员中心</a>
</div>
</body>
</html>