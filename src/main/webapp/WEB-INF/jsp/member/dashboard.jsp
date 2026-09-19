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
    <title>会员中心</title>
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
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 1000px;
            margin: 30px auto;
            overflow: hidden;
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .header h1 {
            font-size: 24px;
            color: #333;
        }
        .logout {
            background-color: #667eea;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        .logout:hover {
            background-color: #5a67d8;
        }
        .card {
            background: transparent;
            padding: 20px;
            margin-bottom: 20px;
        }
        .card h2 {
            margin-bottom: 15px;
            color: #444;
        }
        .menu {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .menu a {
            display: inline-block;
            padding: 12px 24px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .menu a:hover {
            background: #5a67d8;
        }
        .btn {
            background: #667eea;
            color: white;
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background: #5a67d8;
        }
        p {
            line-height: 1.6;
            color: #555;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🏋️ 会员中心 - 欢迎 ${userName}</h1>
        <a href="${pageContext.request.contextPath}/logout" class="logout">退出登录</a>
    </div>
    <div class="card">
        <h2>快捷操作</h2>
        <div class="menu">
            <a href="${pageContext.request.contextPath}/member/courses">📅 查看课程</a>
            <a href="${pageContext.request.contextPath}/member/appointment">📝 预约教练/课程</a>
            <a href="${pageContext.request.contextPath}/member/card">💳 办理卡信息</a>
            <a href="${pageContext.request.contextPath}/member/profile">👤 我的资料</a>
            <a href="${pageContext.request.contextPath}/member/payments" class="btn">💰 我的缴费记录</a>
        </div>
    </div>
    <div class="card">
        <h2>个人资讯</h2>
        <p>感谢您信任七月健身，您可以通过上方导航进行各项操作。</p>
    </div>
</div>
</body>
</html>