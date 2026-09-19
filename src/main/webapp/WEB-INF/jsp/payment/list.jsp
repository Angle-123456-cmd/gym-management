<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>收费管理</title>
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
        .amount { color: #48bb78; font-weight: bold; }
        .back-link { color: #667eea; text-decoration: none; margin-right: 20px; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="header">
        <h1>💰 收费管理</h1>
    </div>
    
    <div class="container">
        <div class="toolbar">
            <a href="${pageContext.request.contextPath}/index">← 返回首页</a>
            <a href="${pageContext.request.contextPath}/payment/add" class="btn btn-primary">添加记录</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>会员姓名</th>
                    <th>类型</th>
                    <th>金额</th>
                    <th>支付日期</th>
                    <th>支付方式</th>
                    <th>状态</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="payment" items="${payments}">
                    <tr>
                        <td>${payment.id}</td>
                        <td>${payment.memberName}</td>
                        <td>${payment.type}</td>
                        <td class="amount">¥${payment.amount}</td>
                        <td>${payment.paymentDate}</td>
                        <td>${payment.method}</td>
                        <td>${payment.status}</td>
                        <td>${payment.remark}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/payment/edit?id=${payment.id}" class="btn btn-warning">编辑</a>
                            <a href="${pageContext.request.contextPath}/payment/delete?id=${payment.id}" 
                               class="btn btn-danger" 
                               onclick="return confirm('确定要删除吗？')">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty payments}">
                    <tr>
                        <td colspan="9" style="text-align: center; padding: 30px; color: #999;">暂无数据</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
