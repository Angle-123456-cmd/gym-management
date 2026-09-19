<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>健身房管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
            position: relative;  /* 为退出按钮提供定位参考 */
        }
        .header h1 { font-size: 28px; margin-bottom: 10px; }
        .logout-btn {
            position: absolute;
            right: 20px;
            top: 20px;
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
            font-size: 14px;
        }
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .menu { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px; }
        .menu-item { background: white; border-radius: 10px; padding: 30px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; text-decoration: none; color: #333; }
        .menu-item:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .menu-item h2 { font-size: 22px; margin-bottom: 10px; color: #667eea; }
        .menu-item p { color: #666; font-size: 14px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-top: 30px; }
        .stat-card { background: white; border-radius: 10px; padding: 20px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .stat-card h3 { font-size: 36px; color: #667eea; margin-bottom: 10px; }
        .stat-card p { color: #666; font-size: 14px; }
    </style>
</head>
<body>
<div class="header">
    <h1>---七月健身---</h1>
    <p>你好！管理员</p>
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
</div>

<div class="container">
    <h2 style="margin-bottom: 20px; color: #333;">系统功能</h2>
    <div class="menu">
        <a href="${pageContext.request.contextPath}/member" class="menu-item">
            <h2>👤 会员管理</h2>
            <p>管理会员信息、会员卡类型、到期提醒</p>
        </a>
        <a href="${pageContext.request.contextPath}/course" class="menu-item">
            <h2>📅 课程管理</h2>
            <p>健身课程排期、教练安排、预约管理</p>
        </a>
        <a href="${pageContext.request.contextPath}/equipment" class="menu-item">
            <h2>🔧 器材管理</h2>
            <p>器材登记、维护记录、状态监控</p>
        </a>
        <a href="${pageContext.request.contextPath}/payment" class="menu-item">
            <h2>💰 收费管理</h2>
            <p>费用记录、支付方式、账单管理</p>
        </a>
        <a href="${pageContext.request.contextPath}/staff" class="menu-item">
            <h2>👨‍💼 员工管理</h2>
            <p>员工信息、职位管理、薪资记录</p>
        </a>
    </div>
</div>
</body>
</html>