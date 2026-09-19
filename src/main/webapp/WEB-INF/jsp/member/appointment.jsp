<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>预约课程</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        select, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        button {
            background-color: #667eea;
            color: white;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #5a67d8;
        }

        .message {
            margin-top: 15px;
            font-size: 14px;
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
    <h2>预约课程</h2>
    <form action="${pageContext.request.contextPath}/member/appointment" method="post">
        选择课程：
        <select name="courseId">
            <c:forEach var="c" items="${courses}">
                <option value="${c.id}">${c.name} - ${c.instructor}</option>
            </c:forEach>
        </select>
        <button type="submit">提交预约</button>
    </form>

    <!-- 显示预约成功/失败消息 -->
    <c:if test="${not empty success}">
        <div class="message" style="color:green">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message" style="color:red">${error}</div>
    </c:if>

    <a href="${pageContext.request.contextPath}/member/dashboard" class="back-link">← 返回会员中心</a>
</div>
</body>
</html>