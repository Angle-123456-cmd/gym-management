<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("userId") == null) response.sendRedirect(request.getContextPath() + "/login");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>课程列表</title>
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
        .cancel-btn {
            color: red;
            text-decoration: none;
            margin-left: 10px;
        }
        .cancel-btn:hover {
            text-decoration: underline;
        }
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
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
    <h2>全部课程</h2>

    <!-- 取消预约消息显示 -->
    <c:if test="${not empty cancelSuccess}">
        <div class="message success">${cancelSuccess}</div>
    </c:if>
    <c:if test="${not empty cancelError}">
        <div class="message error">${cancelError}</div>
    </c:if>

    <table>
        <thead>
        <tr><th>ID</th><th>课程名称</th><th>教练</th><th>类型</th><th>容量</th><th>已预约</th><th>时间</th><th>地点</th><th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${courses}">
            <tr>
                <td>${c.id}</td>
                <td>${c.name}</td>
                <td>${c.instructor}</td>
                <td>${c.type}</td>
                <td>${c.capacity}</td>
                <td>${c.enrolledCount}</td>
                <td>${c.schedule}</td>
                <td>${c.location}</td>
                <td>
                    <c:set var="booked" value="false" />
                    <c:forEach var="bid" items="${bookedCourseIds}">
                        <c:if test="${bid == c.id}">
                            <c:set var="booked" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${booked}">
                        <a href="${pageContext.request.contextPath}/member/cancelAppointment?courseId=${c.id}"
                           class="cancel-btn"
                           onclick="return confirm('确定要取消预约【${c.name}】吗？')">取消预约</a>
                    </c:if>
                    <c:if test="${not booked}">
                        <span style="color:gray;">未预约</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/member/dashboard" class="back-link">← 返回会员中心</a>
</div>
</body>
</html>