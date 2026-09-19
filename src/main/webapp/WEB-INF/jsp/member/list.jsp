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
    <title>会员管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; }
        .header h1 { font-size: 24px; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .toolbar { background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .btn { padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primary { background: #667eea; color: white; }
        .btn-success { background: #48bb78; color: white; }
        .btn-danger { background: #f56565; color: white; }
        .btn-warning { background: #ed8936; color: white; }
        .btn:hover { opacity: 0.9; }
        table { width: 100%; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        th { background: #667eea; color: white; }
        tr:hover { background: #f7fafc; }
        .status-normal { color: #48bb78; font-weight: bold; }
        .status-expired { color: #f56565; font-weight: bold; }
        .status-pause { color: #ed8936; font-weight: bold; }
        .back-link { color: #667eea; text-decoration: none; margin-right: 20px; }
        .back-link:hover { text-decoration: underline; }
        /* 新增消息样式 */
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
    </style>
</head>
<body>
<div class="header">
    <h1>👤 会员管理</h1>
</div>

<div class="container">
    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/index">← 返回首页</a>
        <a href="${pageContext.request.contextPath}/member/add" class="btn btn-primary">添加会员</a>
    </div>

    <!-- 显示消息 -->
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
            <th>姓名</th>
            <th>性别</th>
            <th>电话</th>
            <th>邮箱</th>
            <th>加入日期</th>
            <th>到期日期</th>
            <th>会员类型</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="member" items="${members}">
            <tr>
                <td>${member.id}</td>
                <td>${member.name}</td>
                <td>${member.gender}</td>
                <td>${member.phone}</td>
                <td>${member.email}</td>
                <td>${member.joinDate}</td>
                <td>${member.expiryDate}</td>
                <td>${member.membershipType}</td>
                <td>
                    <c:choose>
                        <c:when test="${member.status == '正常'}">
                            <span class="status-normal">正常</span>
                        </c:when>
                        <c:when test="${member.status == '过期'}">
                            <span class="status-expired">过期</span>
                        </c:when>
                        <c:when test="${member.status == '暂停'}">
                            <span class="status-pause">暂停</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/member/edit?id=${member.id}" class="btn btn-warning">编辑</a>
                    <a href="${pageContext.request.contextPath}/member/delete?id=${member.id}"
                       class="btn btn-danger"
                       onclick="return confirm('确定要删除吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty members}">
            <tr>
                <td colspan="10" style="text-align: center; padding: 30px; color: #999;">暂无数据</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>