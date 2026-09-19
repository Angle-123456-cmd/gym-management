<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${staff != null ? '编辑员工' : '添加员工'}</title>
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
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; margin-right: 10px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-secondary { background: #cbd5e0; color: #333; }
        .btn:hover { opacity: 0.9; }
        .back-link { color: #667eea; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
        .error-msg { color: red; font-size: 12px; margin-top: 5px; }
        /* 错误和成功消息全局样式 */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
    </style>
    <script>
        function validateForm() {
            var position = document.getElementById("position").value;
            var password = document.getElementById("password").value;
            var isEdit = ${staff != null};
            if (position === "经理") {
                if (!isEdit && password.trim() === "") {
                    alert("新增经理时，密码不能为空！");
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body>
<div class="header">
    <h1>${staff != null ? '编辑员工' : '添加员工'}</h1>
</div>
<div class="container">
    <div class="form-card">
        <p style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/staff" class="back-link">← 返回列表</a>
        </p>

        <!-- 显示错误消息 -->
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/staff/save" onsubmit="return validateForm()">
            <c:if test="${staff != null}">
                <input type="hidden" name="id" value="${staff.id}">
            </c:if>

            <div class="form-group">
                <label>姓名 *</label>
                <input type="text" name="name" value="${staff.name}" required>
            </div>

            <div class="form-group">
                <label>性别 *</label>
                <select name="gender" required>
                    <option value="男" ${staff.gender == '男' ? 'selected' : ''}>男</option>
                    <option value="女" ${staff.gender == '女' ? 'selected' : ''}>女</option>
                </select>
            </div>

            <div class="form-group">
                <label>电话 *</label>
                <input type="text" name="phone" value="${staff.phone}" required>
            </div>

            <div class="form-group">
                <label>职位 *</label>
                <select name="position" id="position" required>
                    <option value="教练" ${staff.position == '教练' ? 'selected' : ''}>教练</option>
                    <option value="前台" ${staff.position == '前台' ? 'selected' : ''}>前台</option>
                    <option value="经理" ${staff.position == '经理' ? 'selected' : ''}>经理</option>
                    <option value="清洁" ${staff.position == '清洁' ? 'selected' : ''}>清洁</option>
                    <option value="其他" ${staff.position == '其他' ? 'selected' : ''}>其他</option>
                </select>
            </div>

            <div class="form-group">
                <label>入职日期 *</label>
                <input type="date" name="hireDate" value="${staff.hireDate}" required>
            </div>

            <div class="form-group">
                <label>薪资 *</label>
                <input type="number" name="salary" value="${staff.salary}" step="0.01" required min="0">
            </div>

            <div class="form-group">
                <label>状态 *</label>
                <select name="status" required>
                    <option value="在职" ${staff.status == '在职' ? 'selected' : ''}>在职</option>
                    <option value="离职" ${staff.status == '离职' ? 'selected' : ''}>离职</option>
                    <option value="休假" ${staff.status == '休假' ? 'selected' : ''}>休假</option>
                </select>
            </div>

            <div class="form-group">
                <label>密码 <c:if test="${staff == null}">（经理职位必填）</c:if><c:if test="${staff != null}">（留空则不修改）</c:if></label>
                <input type="password" name="password" id="password" value="">
            </div>

            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/staff" class="btn btn-secondary">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>