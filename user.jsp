<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>永辉超市管理系统</title>
		<link rel="stylesheet" href="/css/public.css" />
		<link rel="stylesheet" href="/css/main.css" />
		<link rel="stylesheet" href="/css/search.css" />
		<link rel="stylesheet" href="/css/location.css" />
		<link rel="stylesheet" href="/css/style.css" />
		<script src="/js/jquery-3.2.1.js"></script>
		<script src="/js/js.js"></script>
		<script type="text/javascript">
			
				
				
				
				$('#goNum').on('click',function(){
					var n = $('#wantNum').val();
					if( n == ""){
						alert("请输入跳转页面的页码");
					}else{
						if(n > ${num}){
							alert("跳转页面不存在");
						}else{
							location = "${pageContext.request.contextPath }/choose/user/"+n;
						}
					}
				});
			});		
		</script>
	</head>

	<body>
		<section class="publicMian ">
			<div class="right">
				<div class="location">
					<strong>你现在所在的位置是:</strong>
					<span>用户信息页面</span>
				</div>
				<div class="search">
					<span>员工姓名：</span>
					<input type="text" placeholder="请输入员工姓名" id="sinput"/>
					
					<span>员工性别：</span>
					<input type="text" placeholder="请输入员工性别" id="sinput"/>
					
					<span>员工类型：</span>
					<select name="tigong">
						<option value="0">--请选择--</option>
						<option value="">收银员</option>
						<option value="">仓库保管员</option>
						<option value="">管理员</option>
					</select>
					
					<input id="query" type="button" value="查询" />
					<a id="add" href="${pageContext.request.contextPath }/show/userAdd">添加商品</a>
				</div>
				<!--账单表格 样式和供应商公用-->
				<table class="providerTable" cellpadding="0" cellspacing="0">
					<tr class="firstTr">
						<th width="15%">员工姓名</th>
						<th width="15%">登录密码</th>
						<th width="15%">员工性别</th>
						<th width="20%">家庭住址</th>
						<th width="10%">联系方式</th>
						<th width="10%">员工类型</th>
						<th width="15%">操作</th>
					</tr>
					<c:forEach items="${list }" var="user">
						<tr>
							<td>${user.userName }</td>
							<td>${user.userPassword }</td>
							<td>${user.userSex }</td>
							<td>${user.userAddress }</td>
							<td>${user.userPhone }</td>
							<td>${user.userType }</td>
							<td>
								<!--<a href="goodsView.html"><img src="img/read.png" alt="查看" title="查看" /></a>-->
								<a href="goodsUpdate.html"><img src="/img/xiugai.png" alt="修改" title="修改" /></a>
								<a href="#" class="removeBill"><img src="/img/schu.png" alt="删除" title="删除" /></a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="7">
							<c:if test="${pageNum == 1 }">
								<a>首页</a>
								<a>上一页</a>
							</c:if>
							<c:if test="${pageNum > 1 }">
								<a href="${pageContext.request.contextPath }/choose/user/1">首页</a>
								<a href="${pageContext.request.contextPath }/choose/user/${pageNum - 1}">上一页</a>
							</c:if>
							第${pageNum }页/共${num }页 
							&nbsp;
							<c:if test="${pageNum == num }">
								<a>下一页</a>
								<a>尾页</a>
							</c:if>
							<c:if test="${pageNum < num }">
								<a href="${pageContext.request.contextPath }/choose/user/${pageNum + 1}">下一页</a>
								<a href="${pageContext.request.contextPath }/choose/user/${num}">尾页</a>
							</c:if>
							转到第<input id="wantNum" type="text" size="1">页<input id="goNum" type="button" value="go">
						</td>
					</tr>
				</table>
			</div>
		</section>

		<!--点击删除按钮后弹出的页面-->
		<div class="zhezhao"></div>
		<div class="remove" id="removeBi">
			<div class="removerChid">
				<h2>提示</h2>
				<div class="removeMain">
					<p>你确定要删除该订单吗？</p>
					<a href="#" id="yes">确定</a>
					<a href="#" id="no">取消</a>
				</div>
			</div>
		</div>
	</body>
</html>