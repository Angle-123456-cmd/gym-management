<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${equipment != null ? '编辑器材' : '添加器材'}</title>
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
    <h1>${equipment != null ? '编辑器材' : '添加器材'}</h1>
</div>

<div class="container">
    <div class="form-card">
        <p style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/equipment" class="back-link">← 返回列表</a>
        </p>

        <form method="post" action="${pageContext.request.contextPath}/equipment/save">
            <c:if test="${equipment != null}">
                <input type="hidden" name="id" value="${equipment.id}">
            </c:if>

            <div class="form-group">
                <label>器材名称 *</label>
                <input type="text" name="name" value="${equipment.name}" required>
            </div>

            <div class="form-group">
                <label>类型 *</label>
                <select name="type" required>
                    <option value="有氧" ${equipment.type == '有氧' ? 'selected' : ''}>有氧</option>
                    <option value="力量" ${equipment.type == '力量' ? 'selected' : ''}>力量</option>
                    <option value="其他" ${equipment.type == '其他' ? 'selected' : ''}>其他</option>
                </select>
            </div>

            <div class="form-group">
                <label>位置 *</label>
                <input type="text" name="location" value="${equipment.location}" required>
            </div>

            <div class="form-group">
                <label>购买日期 *</label>
                <input type="date" name="purchaseDate" value="${equipment.purchaseDate}" required>
            </div>

            <div class="form-group">
                <label>状态 *</label>
                <select name="status" required>
                    <option value="正常" ${equipment.status == '正常' ? 'selected' : ''}>正常</option>
                    <option value="维修中" ${equipment.status == '维修中' ? 'selected' : ''}>维修中</option>
                    <option value="报废" ${equipment.status == '报废' ? 'selected' : ''}>报废</option>
                </select>
            </div>

            <div class="form-group">
                <label>最后维护日期</label>
                <input type="date" name="lastMaintenance" value="${equipment.lastMaintenance}">
            </div>

            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/equipment" class="btn btn-secondary">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>