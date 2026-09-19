<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${course != null ? '编辑课程' : '添加课程'}</title>
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
    <h1>${course != null ? '编辑课程' : '添加课程'}</h1>
</div>

<div class="container">
    <div class="form-card">
        <p style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/course" class="back-link">← 返回列表</a>
        </p>

        <form method="post" action="${pageContext.request.contextPath}/course/save">
            <c:if test="${course != null}">
                <input type="hidden" name="id" value="${course.id}">
            </c:if>

            <div class="form-group">
                <label>课程名称 *</label>
                <input type="text" name="name" value="${course.name}" required>
            </div>

            <div class="form-group">
                <label>教练 *</label>
                <input type="text" name="instructor" value="${course.instructor}" required>
            </div>

            <div class="form-group">
                <label>课程类型 *</label>
                <select name="type" required>
                    <option value="瑜伽" ${course.type == '瑜伽' ? 'selected' : ''}>瑜伽</option>
                    <option value="动感单车" ${course.type == '动感单车' ? 'selected' : ''}>动感单车</option>
                    <option value="拳击" ${course.type == '拳击' ? 'selected' : ''}>拳击</option>
                    <option value="有氧操" ${course.type == '有氧操' ? 'selected' : ''}>有氧操</option>
                    <option value="力量训练" ${course.type == '力量训练' ? 'selected' : ''}>力量训练</option>
                    <option value="其他" ${course.type == '其他' ? 'selected' : ''}>其他</option>
                </select>
            </div>

            <div class="form-group">
                <label>容量 *</label>
                <input type="number" name="capacity" value="${course.capacity}" required min="1">
            </div>

            <div class="form-group">
                <label>已预约人数</label>
                <input type="number" name="enrolledCount" value="${course.enrolledCount != null ? course.enrolledCount : 0}" min="0">
            </div>

            <div class="form-group">
                <label>上课时间 *</label>
                <input type="text" name="schedule" value="${course.schedule}" placeholder="例如: 周一 10:00-11:00" required>
            </div>

            <div class="form-group">
                <label>地点 *</label>
                <input type="text" name="location" value="${course.location}" placeholder="例如: 1号教室" required>
            </div>

            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/course" class="btn btn-secondary">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>