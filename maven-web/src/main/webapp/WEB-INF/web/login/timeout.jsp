<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户失效</title>
</head>
<body>
	你的登录已经失效，请重新登录。
	<br />
	<a href="<c:url value='${ ctx}/login/login.htm'/>"> 点击这里登录</a>
</body>
</html>
