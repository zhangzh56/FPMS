<%@page import="com.forms.platform.web.WebUtils"%>
<%@page import="com.forms.platform.web.consts.WebConsts"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/platform-tags" prefix="p" %>
<%@ taglib uri="http://www.formssi.com/taglibs/froms" prefix="forms" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>参考维护列表</title>

<style type="text/css">
.update{
 	position: relative; 
 	left:100px; 
}

</style>
<script type="text/javascript">

//页面初始化
function pageInit() {
	//调整下拉框样式
	App.jqueryAutocomplete();
}

//查询列表
function listR()
{
 	var form=$("#rFormSearch")[0];
	form.action="<%=request.getContextPath()%>/sysmanagement/referencespecial/referenceList.do?<%=WebConsts.FUNC_ID_KEY%>=011201";
	App.submit(form);
}

//详情
function rUpdate(referenceId){
	$("input[name='referenceId']").val(referenceId);
	var form=$("#referenceId")[0];
	form.action="<%=request.getContextPath()%>/sysmanagement/referencespecial/referenceView.do?<%=WebConsts.FUNC_ID_KEY%>=01120104";
	App.submit(form);
}

//重置查询条件
function initEvent(){
	$("select").val("");
	$(":text").val("");
	$(":selected").prop("selected",false);
	$("#statusDiv1").find("label").eq("").click();
	$("select").each(function(){
		var id = $(this).attr("id");
		if(id!=""){
			var year = $("#"+id+" option:first").text();
			$(this).val(year);
			 $(this).next().val(year) ;
		}
		
	});
};
</script>
</head>
<body>
<p:authFunc funcArray="01120102"/>
<form action="" method="post" id="referenceId">
	<input type="hidden" name="referenceId" id="referenceId">
</form>
<form action="" method="post" id="rFormSearch">
	<p:token/>
	<table>
		<tr class="collspan-control">
			<th colspan="4">
				参考查询 
			</th>
		</tr>
		<tr>
			<td class="tdLeft" width="25%">参考编码</td>
			<td class="tdRight" width="25%">
				<input type="text" id="referenceId" name="referenceId" value="${r.referenceId}" class="base-input-text" maxlength="7" />				
			</td>
			<td class="tdLeft" width="25%">参考说明</td>
			<td class="tdRight" width="25%">
				<input type="text" id="referenceName" name="referenceName" value="${r.referenceName}"  class="base-input-text" maxlength="200"/>	
			</td>		
		</tr>
		<tr>
			<td class="tdLeft" width="25%">安全性</td>
			<td class="tdRight" width="25%" colspan="3">
				<div class="base-input-radio" id="statusDiv1" style="width: 350px;">
					<label for="all" onclick="App.radioCheck(this,'statusDiv1')" <c:if test="${r.scope=='' or r.scope==null}">class="check-label"</c:if>>全部</label>
					<input type="radio" id="all" name="scope" value="" <c:if test="${r.scope=='' or r.scope==null}">checked="checked"</c:if>>
					<label for="isAll" onclick="App.radioCheck(this,'statusDiv1')" <c:if test="${r.scope=='3'}">class="check-label"</c:if>>全局</label>
					<input type="radio" id="isAll" name="scope" value="3" <c:if test="${r.scope=='3'}">checked="checked"</c:if>>
					<label for="ZH" onclick="App.radioCheck(this,'statusDiv1')" <c:if test="${r.scope=='1'}">class="check-label"</c:if>>总行</label>
					<input type="radio" id="ZH" name="scope" value="1" <c:if test="${r.scope=='1'}">checked="checked"</c:if>>
					<label for="FH" onclick="App.radioCheck(this,'statusDiv1')" <c:if test="${r.scope=='2'}">class="check-label"</c:if>>分行</label>
					<input type="radio" id="FH" name="scope" value="2" <c:if test="${r.scope=='2'}">checked="checked"</c:if>>
					<label for="TY" onclick="App.radioCheck(this,'statusDiv1')" <c:if test="${r.scope=='4'}">class="check-label"</c:if>>停用</label>
					<input type="radio" id="TY" name="scope" value="4" <c:if test="${r.scope=='4'}">checked="checked"</c:if>>
				</div>
			</td>	
		</tr>	
		<tr>
			<td colspan="4" class="tdWhite">
				<input type="button" value="查找" onclick="listR();"/>
				<input type="button" value="重置" onclick="initEvent();"/>	
				<p:button funcId="01120102" value="新增"/>			
			</td>
		</tr>
	</table>
</form>
<form action="" method="post" id="rForm">
	<br/>	

	<table id="listTab" class="tableList">		
		<tr>		
			<th width="25%">参考编码</th>
			<th width="25%">参考说明</th>
			<th width="25%">安全性</th>
			<th width="25%">操作</th>
		</tr>
		<c:forEach items="${rList}" var="rl" varStatus="status">
			<tr onmouseover="setTrBgClass(this, 'trOnOver2');" onmouseout="setTrBgClass(this, 'trOther');">				
				<td>${rl.referenceId}</td>								
				<td>${rl.referenceName}</td>	
				<td>${rl.scopeName}</td>					
				<td >
					<div class="update">
					    <a href="#" onclick="rUpdate('${rl.referenceId}');" title="<%=WebUtils.getMessage("button.edit")%>"></a>
					</div>
				</td>	
			</tr>
		</c:forEach>
		<c:if test="${empty rList}">
	    <tr>
		<td colspan="4" style="text-align: center;" class="red"><span>没有找到相关信息</span></td>
		</tr>
	   </c:if>	
	</table>

</form>
<p:page/>
</body>
</html>