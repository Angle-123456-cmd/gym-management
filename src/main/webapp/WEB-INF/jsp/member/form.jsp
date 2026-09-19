<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${member != null ? '编辑会员' : '添加会员'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; }
        .header h1 { font-size: 24px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .form-card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #667eea; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; margin-right: 10px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-secondary { background: #cbd5e0; color: #333; }
        .btn:hover { opacity: 0.9; }
        .back-link { color: #667eea; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="header">
    <h1>${member != null ? '编辑会员' : '添加会员'}</h1>
</div>

<div class="container">
    <div class="form-card">
        <p style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/member" class="back-link">← 返回列表</a>
        </p>
        <c:if test="${not empty error}">
            <div class="message error" style="color: red; margin-bottom: 15px;">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/member/save">
            <c:if test="${member != null}">
                <input type="hidden" name="id" value="${member.id}">
            </c:if>

            <div class="form-group">
                <label>姓名 *</label>
                <input type="text" name="name" value="${member.name}" required>
            </div>

            <div class="form-group">
                <label>性别 *</label>
                <select name="gender" required>
                    <option value="男" ${member.gender == '男' ? 'selected' : ''}>男</option>
                    <option value="女" ${member.gender == '女' ? 'selected' : ''}>女</option>
                </select>
            </div>

            <div class="form-group">
                <label>电话 *</label>
                <input type="text" name="phone" value="${member.phone}" required>
            </div>

            <div class="form-group">
                <label>邮箱</label>
                <input type="email" name="email" value="${member.email}">
            </div>

            <div class="form-group">
                <label>加入日期 *</label>
                <input type="date" name="joinDate" value="${member.joinDate}" required>
            </div>

            <div class="form-group">
                <label>到期日期 *</label>
                <input type="date" name="expiryDate" value="${member.expiryDate}" required>
            </div>

            <div class="form-group">
                <label>会员类型 *</label>
                <select name="membershipType" required>
                    <option value="月卡" ${member.membershipType == '月卡' ? 'selected' : ''}>月卡</option>
                    <option value="季卡" ${member.membershipType == '季卡' ? 'selected' : ''}>季卡</option>
                    <option value="年卡" ${member.membershipType == '年卡' ? 'selected' : ''}>年卡</option>
                </select>
            </div>

            <div class="form-group">
                <label>状态 *</label>
                <select name="status" required>
                    <option value="正常" ${member.status == '正常' ? 'selected' : ''}>正常</option>
                    <option value="过期" ${member.status == '过期' ? 'selected' : ''}>过期</option>
                    <option value="暂停" ${member.status == '暂停' ? 'selected' : ''}>暂停</option>
                </select>
            </div>

            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/member" class="btn btn-secondary">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>