<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>健身房管理系统 - 登录</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            /* 背景图片设置 */
            background-image: url('${pageContext.request.contextPath}/images/login-bg.jpg');
            background-size: cover;           /* 图片覆盖整个屏幕 */
            background-position: center;      /* 图片居中 */
            background-repeat: no-repeat;     /* 不重复 */
            background-attachment: fixed;     /* 固定背景，滚动时不移动 */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* 如果图片太亮，可以加一层半透明遮罩（可选） */
            position: relative;
        }
        /* 可选：半透明遮罩，让文字更清晰 */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4); /* 黑色半透明，数值可调 */
            z-index: 0;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.95); /* 半透明白色卡片 */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 400px;
            position: relative;
            z-index: 1;
        }
        .login-container h2 { text-align: center; margin-bottom: 30px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .btn { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn:hover { background: #5a67d8; }
        .error { color: red; margin-top: 10px; text-align: center; }
        .info { margin-top: 15px; text-align: center; font-size: 14px; }
        .info a { color: #667eea; text-decoration: none; }
    </style>
</head>
<body>
<div class="login-container">
    <h2>七月健身</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>登录身份</label>
            <select name="role" required>
                <option value="member">会员登录</option>
                <option value="admin">管理员登录</option>
            </select>
        </div>
        <div class="form-group">
            <label>账号</label>
            <input type="text" name="username" placeholder="会员：姓名/手机/邮箱；管理员：姓名" required>
        </div>
        <div class="form-group">
            <label>密码</label>
            <input type="password" name="password" placeholder="密码" required>
        </div>
        <button type="submit" class="btn">登录</button>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
    </form>
    <div class="info">
        还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
    </div>
</div>
</body>
</html>