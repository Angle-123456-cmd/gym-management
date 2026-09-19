<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("adminName") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>课程管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; }
        .header h1 { font-size: 24px; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .toolbar { background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .btn { padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primary { background: #667eea; color: white; }
        .btn-danger { background: #f56565; color: white; }
        .btn-warning { background: #ed8936; color: white; }
        .btn:hover { opacity: 0.9; }
        table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        th { background: #667eea; color: white; }
        tr:hover { background: #f7fafc; }
        .back-link { color: #667eea; text-decoration: none; margin-right: 20px; }
        .back-link:hover { text-decoration: underline; }

        /* 消息提示样式 */
        .message {
            padding: 12px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 15px;
            border-left: 5px solid;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
        .message.success {
            background-color: #f0fff4;
            border-color: #48bb78;
            color: #22543d;
        }
        .message.error {
            background-color: #fff5f5;
            border-color: #fc8181;
            color: #9b2c2c;
        }
        .message.success::before {
            content: "✅ ";
        }
        .message.error::before {
            content: "❌ ";
        }
    </style>
</head>
<body>
<div class="header">
    <h1>📅 课程管理</h1>
</div>

<div class="container">
    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/index" class="back-link">← 返回首页</a>
        <a href="${pageContext.request.contextPath}/course/add" class="btn btn-primary">添加课程</a>
    </div>

    <!-- 消息显示区域（放在表格上方，独立于表格） -->
    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>课程名称</th>
            <th>教练</th>
            <th>类型</th>
            <th>容量</th>
            <th>已预约</th>
            <th>上课时间</th>
            <th>地点</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="course" items="${courses}">
            <tr>
                <td>${course.id}</td>
                <td>${course.name}</td>
                <td>${course.instructor}</td>
                <td>${course.type}</td>
                <td>${course.capacity}</td>
                <td>${course.enrolledCount}</td>
                <td>${course.schedule}</td>
                <td>${course.location}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/course/edit?id=${course.id}" class="btn btn-warning">编辑</a>
                    <a href="${pageContext.request.contextPath}/course/delete?id=${course.id}"
                       class="btn btn-danger"
                       onclick="return confirm('确定要删除吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty courses}">
            <tr>
                <td colspan="9" style="text-align: center; padding: 30px; color: #999;">暂无数据</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>