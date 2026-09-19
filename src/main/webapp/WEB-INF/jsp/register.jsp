<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员注册</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 50px 0; }
        .register-container { max-width: 500px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .btn { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .error { color: red; margin-top: 10px; text-align: center; }
        .info { text-align: center; margin-top: 15px; }
    </style>
</head>
<body>
<div class="register-container">
    <h2>会员注册</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>姓名 *</label>
            <input type="text" name="name" required>
        </div>
        <div class="form-group">
            <label>性别 *</label>
            <select name="gender" required>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
        <div class="form-group">
            <label>手机号 *</label>
            <input type="text" name="phone" required>
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email">
        </div>
        <div class="form-group">
            <label>加入日期 *</label>
            <input type="date" name="joinDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
        </div>
        <div class="form-group">
            <label>密码 *</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn">注册</button>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
    </form>
    <div class="info">已有账号？<a href="${pageContext.request.contextPath}/login">立即登录</a></div>
</div>
</body>
</html>