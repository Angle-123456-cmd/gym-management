<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${payment != null ? '编辑收费' : '添加收费'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; }
        .header h1 { font-size: 24px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .form-card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #667eea; }
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
    <h1>${payment != null ? '编辑收费' : '添加收费'}</h1>
</div>

<div class="container">
    <div class="form-card">
        <p style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/payment" class="back-link">← 返回列表</a>
        </p>

        <!-- 修改 action 为 /payment/save -->
        <form method="post" action="${pageContext.request.contextPath}/payment/save">
            <c:if test="${payment != null}">
                <input type="hidden" name="id" value="${payment.id}">
            </c:if>

            <div class="form-group">
                <label>会员姓名 *</label>
                <input type="text" name="memberName" value="${payment.memberName}" required>
            </div>

            <div class="form-group">
                <label>收费类型 *</label>
                <select name="type" required>
                    <option value="会员费" ${payment.type == '会员费' ? 'selected' : ''}>会员费</option>
                    <option value="课程费" ${payment.type == '课程费' ? 'selected' : ''}>课程费</option>
                    <option value="其他" ${payment.type == '其他' ? 'selected' : ''}>其他</option>
                </select>
            </div>

            <div class="form-group">
                <label>金额 *</label>
                <input type="number" name="amount" value="${payment.amount}" step="0.01" required min="0">
            </div>

            <div class="form-group">
                <label>支付日期 *</label>
                <input type="date" name="paymentDate" value="${payment.paymentDate}" required>
            </div>

            <div class="form-group">
                <label>支付方式 *</label>
                <select name="method" required>
                    <option value="现金" ${payment.method == '现金' ? 'selected' : ''}>现金</option>
                    <option value="微信" ${payment.method == '微信' ? 'selected' : ''}>微信</option>
                    <option value="支付宝" ${payment.method == '支付宝' ? 'selected' : ''}>支付宝</option>
                    <option value="银行卡" ${payment.method == '银行卡' ? 'selected' : ''}>银行卡</option>
                </select>
            </div>

            <div class="form-group">
                <label>状态 *</label>
                <select name="status" required>
                    <option value="已支付" ${payment.status == '已支付' ? 'selected' : ''}>已支付</option>
                    <option value="未支付" ${payment.status == '未支付' ? 'selected' : ''}>未支付</option>
                    <option value="已退款" ${payment.status == '已退款' ? 'selected' : ''}>已退款</option>
                </select>
            </div>

            <div class="form-group">
                <label>备注</label>
                <textarea name="remark" rows="3">${payment.remark}</textarea>
            </div>

            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="${pageContext.request.contextPath}/payment" class="btn btn-secondary">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>