<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.forms.platform.web.WebUtils"%>
<%@ page import="com.forms.platform.web.consts.WebConsts"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/platform-tags" prefix="p" %>
<%@ taglib uri="http://www.formssi.com/taglibs/froms" prefix="forms" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款信息</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/contract.query.common.js"></script>
<script type="text/javascript">
function  pageInit(){
	App.jqueryAutocomplete();
	$("#payMode").combobox();
	//$("#auditTable .ui-autocomplete-input").css("width","85%");
	//付款确认
	$("#auditDiv").dialog({
		autoOpen: false,
		height: 'auto',
		width: 550,
		modal: true,
		dialogClass: 'dClass',
		resizable: false,
		buttons: {
			"通过": function() {	
				if(!App.valid("#auditForm")){return;}
				var form = $("#auditForm");
			 	form.attr('action', '<%=request.getContextPath()%>/pay/paysure/agree.do?<%=WebConsts.FUNC_ID_KEY%>=03030604');
				App.submit(form);
			},
			"退回":function(){
				if(!App.valid("#auditForm")){return;}
				var form = $("#auditForm");
			 	form.attr('action', '<%=request.getContextPath()%>/pay/paysure/back.do?<%=WebConsts.FUNC_ID_KEY%>=03030605');
				App.submit(form);
			},
				
			"取消": function() {
				$( this ).dialog( "close" );
			}
		}
	});
}
/* //审批
function toAudit(button, url) {
	$('#auditForm').attr("action",url);
	$("#auditDiv").dialog( "option", "title", "付款确认" ).dialog( "open" );
} */
//预付款核销明细查询
function advanceCancelDetail(advancePayId)
{
	<%-- var form=$("#payDetailForm")[0];
	form.action="<%=request.getContextPath()%>/pay/paysure/queryPayAdvCancelDetail.do?<%=WebConsts.FUNC_ID_KEY%>=03030606&advancePayId="+advancePayId;
	App.submit(form);	 --%>
	var url ="<%=request.getContextPath()%>/pay/paysure/queryPayAdvCancelDetail.do?<%=WebConsts.FUNC_ID_KEY%>=03030606&advancePayId="+advancePayId;
// 	App.submitShowProgress();
// 	window.showModalDialog(url, null, "dialogHeight=500px;dialogWidth=900px;center=yes;status=no;");
// 	App.submitFinish();
$.dialog.open(
		url,
		{
			width: "60%",
			height: "80%",
			lock: true,
		    fixed: true,
		    title:"预付款详情",
		    id:"dialogAdvCancelInfoDetail",
			close: function(){
			}		
		}
	)
}
//弹窗进行审批意见
function toAudit(button,url){
	$("#auditDiv").dialog({
		title:'付款确认',
		autoOpen: true,
		height: 'auto',
		width: 550,
		modal: true,
		dialogClass: 'dClass',
		resizable: false,
		buttons: {
			"确定": function() {
				//先必须选择同意或者退回
				if($("#isAgree").val()==''||$("#isAgree").val==null){
					App.notyError("请先选择同意或者退回!");
					return false;
				}
// 				//判断是否通过
// 				if($("#isAgree").val()=='1'){
<%-- 					$('#auditForm').attr('action', '<%=request.getContextPath()%>/pay/paysure/agree.do?<%=WebConsts.FUNC_ID_KEY%>=03030604'); --%>
// 					$('#auditForm').submit();
// 				}
// 				if($("#isAgree").val()=='2'){
// 					//校验
// 					if(!App.valid("#auditForm")){return;}
<%-- 					$('#auditForm').attr('action', '<%=request.getContextPath()%>/pay/paysure/back.do?<%=WebConsts.FUNC_ID_KEY%>=03030605'); --%>
// 					$('#auditForm').submit();
// 				}
				
				//判断是否通过
				if($("#isAgree").val()=='1'){
					$( "<div>确认通过?</div>" ).dialog({
						resizable: false,
						height:150,
						modal: true,
						dialogClass: 'dClass',
						buttons: {
							"确定": function() {
								$('#auditForm').attr('action', '<%=request.getContextPath()%>/pay/paysure/agree.do?<%=WebConsts.FUNC_ID_KEY%>=03030604');
			 					$('#auditForm').submit();
							},
							"取消": function() {
								$( this ).dialog( "close" );
							}
						}
					});
					
				}
				if($("#isAgree").val()=='2'){
					//校验
					if(!App.valid("#auditForm")){return;}
					$( "<div>确认退回?</div>" ).dialog({
						resizable: false,
						height:150,
						modal: true,
						dialogClass: 'dClass',
						buttons: {
							"确定": function() {
								$('#auditForm').attr('action', '<%=request.getContextPath()%>/pay/paysure/back.do?<%=WebConsts.FUNC_ID_KEY%>=03030605');
			 					$('#auditForm').submit();
							},
							"取消": function() {
								$( this ).dialog( "close" );
							}
						}
					});
					
				}
			},
			"取消": function() {
				$( this ).dialog( "close" );
			}
		

		}
	});
}
function toSelectResult(s){
	if(s==$("#isAgree").val()){
		return false;
	}
	if($("#isAgree").val()!=''&&$("#isAgree").val!=null){
		$("#auditForm #auditMemo").val("");
	}
	if(s=='2'){
		//退回
		$("#auditForm #payModeTr").css("display","none");
		$("#auditForm #auditMemo").val("");
		$_showWarnWhenOverLen1(document.getElementById("auditMemo"),500,'authdealCommentSpan');
		$("#auditForm #isAgree").val("2");
		
	}else{
		//同意
		$("#auditForm #payModeTr").css("display","");
		$("#auditForm #auditMemo").val("");
		$_showWarnWhenOverLen1(document.getElementById("auditMemo"),500,'authdealCommentSpan');
		$("#auditForm #isAgree").val("1");
	}
}
//查询付款审批历史记录(弹窗显示)
function queryHis(payId){
	var url = "<%=request.getContextPath()%>/pay/payAdd/queryHis.do?<%=WebConsts.FUNC_ID_KEY%>=03030321&payId="+payId;
	$.dialog.open(
			url,
			{
				width: "60%",
				height: "80%",
				lock: true,
			    fixed: true,
			    title:"查看流转日志",
			    id:"dialogCutPage",
				close: function(){
					}		
			}
		 );
}
</script>
</head>
<body>
<p:authFunc funcArray="03030603"/>
<form action="" id="payDetailForm" method="post">
<table>
	<tr>
		<td>
					<table>
				<tr class="collspan-control">
					<th colspan="4"><b>合同信息</b></th>
				</tr>
				<tr>
					<td class="tdLeft" width="20%"><span class="spanFont">合同号</span></td>
					<td class="tdRight" width="30%">
						 <c:out value="${payInfo.cntNum}"></c:out>
						  <input type="hidden" id="cntNum" name="cntNum" value="${payInfo.cntNum}"/>
					</td>
					<td class="tdLeft" width="20%"><span class="spanFont">进度</span></td>
					<td class="tdRight" width="30%">
						<fmt:parseNumber value="${payInfo.normarlTotalAmt+payInfo.advanceTotalAmt}" var="a"/>
						<fmt:parseNumber value="${payInfo.cntAllAmt}" var="b"/>
						<fmt:formatNumber type="number" value="${a/b*100}" minFractionDigits="2" maxFractionDigits="2"/>%	
					</td>
				</tr>
				<tr>
					<td class="tdLeft" width="20%"><span class="spanFont">合同总金额(人民币)</span></td>
					<td class="tdRight" width="30%">
						<fmt:formatNumber type="number" value="${payInfo.cntAllAmt}" minFractionDigits="2"/>&nbsp;&nbsp;元  <br>
						其中质保金：${payInfo.zbAmt}%
					</td>
					<td class="tdLeft" width="20%"><span class="spanFont">合同类型</span></td>
					<td class="tdRight" width="30%">
						<c:if test="${payInfo.cntType=='0'}">
					    	<c:out value="资产类"></c:out>
					   	</c:if>
					    <c:if test="${payInfo.cntType=='1'}">
					    	<c:out value="费用类"></c:out>
					    </c:if>
					</td>
				</tr>
				<tr>
						<td class="tdLeft">不含税金额(人民币)</td>
						<td class="tdRight">
							<fmt:formatNumber type="number" value="${payInfo.cntAmt}" minFractionDigits="2"/>
						</td>
						<td class="tdLeft">税额(人民币)</td>
						<td class="tdRight">
							<fmt:formatNumber type="number" value="${payInfo.cntTaxAmt}" minFractionDigits="2"/>
							
						</td>
					</tr>
				<tr>
						<td class="tdLeft">正常付款金额（人民币）</td>
						<td class="tdRight">
							<c:if test="${!empty payInfo.normarlTotalAmt}">
								<fmt:formatNumber type="number" value="${payInfo.normarlTotalAmt}" minFractionDigits="2"/>元
							</c:if>
							<c:if test="${empty payInfo.normarlTotalAmt}">
								<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
							</c:if>
						</td>
						<td class="tdLeft">预付款金额（人民币）</td>
						<td class="tdRight">
							<c:if test="${!empty payInfo.advanceTotalAmt}">
								<fmt:formatNumber type="number" value="${payInfo.advanceTotalAmt}" minFractionDigits="2"/>元
							</c:if>
							<c:if test="${empty payInfo.advanceTotalAmt}">
								<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="tdLeft">冻结金额（人民币）</td>
						<td class="tdRight">
							<c:if test="${!empty payInfo.freezeTotalAmt}">
								<fmt:formatNumber type="number" value="${payInfo.freezeTotalAmt}" minFractionDigits="2"/>元
							</c:if>
							<c:if test="${empty payInfo.freezeTotalAmt}">
								<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
							</c:if>
						</td>
						<td class="tdLeft">暂收总金额（人民币）</td>
						<td class="tdRight">
							<c:if test="${!empty payInfo.suspenseTotalAmt}">
								<fmt:formatNumber type="number" value="${payInfo.suspenseTotalAmt}" minFractionDigits="2"/>元
							</c:if>
							<c:if test="${empty payInfo.suspenseTotalAmt}">
								<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
							</c:if>
						</td>
					</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
			<table >
				<tr class="collspan-control">
					<th colspan="4">付款单号：${payInfo.payId}
							<input type="hidden" id="payId" name="payId" value="${payInfo.payId}"/>
					</th>
				</tr>
				<tr>
					<td class="tdLeft" ><span class="spanFont">发票号</span></td>
					<td class="tdRight" colspan="3">
						<c:out value="${payInfo.invoiceId}"></c:out>
					</td>
				</tr>
				<tr>	
					<td class="tdLeft">是否贷项通知单</td>
						<td class="tdRight">
							<c:if test="${payInfo.isCreditNote=='0'}">
								<c:out value="是"></c:out>
							</c:if>
							<c:if test="${payInfo.isCreditNote=='1'}">
								<c:out value="否"></c:out>
							</c:if>
					</td>
					<td class="tdLeft"><span class="spanFont">附件张数</span></td>
					<td class="tdRight">
						<c:out value="${payInfo.attachmentNum}"></c:out>张
					</td>
				</tr>
				<tr>
					<td class="tdLeft"><span class="spanFont">收款单位</span></td>
					<td class="tdRight">
						<c:out value="${payInfo.providerName}"></c:out>
					</td>
					<td class="tdLeft"><span class="spanFont">收款账号</span></td>
					<td class="tdRight">
						<c:out value="${payInfo.provActNo}"></c:out>
					</td>
				</tr>
				<tr>
					<td class="tdLeft"><span class="spanFont">开户行信息</span></td>
					<td class="tdRight">
						<c:out value="${payInfo.bankName}"></c:out>
					</td>
					<c:if test="${payInfo.advanceCancelAmt != payInfo.invoiceAmt}">
						<td class="tdLeft"><span class="spanFont">付款方式</span></td>
						<td class="tdRight">
							<c:out value="${payInfo.payModeName}"></c:out>
						</td>
						</c:if>
						<c:if test="${payInfo.advanceCancelAmt == payInfo.invoiceAmt}">
						<td class="tdLeft"></td>
						<td class="tdRight"></td>
						</c:if>
				</tr>
				<tr>
						<td class="tdLeft" rowspan="2">发票总金额=(预付款核销金额+付款金额+暂收金额)</td>
						<td class="tdRight" rowspan="2">
							<fmt:formatNumber type="number" value="${payInfo.invoiceAmt}" minFractionDigits="2"/>元
						</td>
						<td class="tdLeft">不含税金额</td>
						<td class="tdRight">
							<fmt:formatNumber type="number" value="${payInfo.invoiceAmtNotax}" minFractionDigits="2"/>元
						</td>
					</tr>
					
					<tr>
						<td class="tdLeft">税额</td>
						<td class="tdRight">
							<fmt:formatNumber type="number" value="${payInfo.invoiceAmtTax}" minFractionDigits="2"/>元
						</td>
					</tr>
					<tr>
						<td class="tdRight" colspan="4" style="text-align: center;padding: 0" >
							<%-- <span class="spanFont">预付款核销金额</span>
							【<fmt:formatNumber type="number" value="${payInfo.advanceCancelAmt}" minFractionDigits="2"/>】元
							&nbsp;&nbsp;<span class="spanFont">付款金额</span>
							【<fmt:formatNumber type="number" value="${payInfo.payAmt}" minFractionDigits="2"/>】元&nbsp;&nbsp;
							<span class="spanFont" >暂收金额</span>
							<c:if test="${!empty payInfo.suspenseAmt}">
								【<fmt:formatNumber type="number" value="${payInfo.suspenseAmt}" minFractionDigits="2"/>】元&nbsp;&nbsp;
							</c:if>
							<c:if test="${empty payInfo.suspenseAmt}">
								【<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元】&nbsp;&nbsp;
							</c:if> --%>
							<table style="border: 0">
								<tr>
									<td class="tdLeft" style="border-bottom: 0;border-top: 0;border-left: 0"><span class="spanFont">预付款核销金额</span></td>
									<td class="tdRight" style="border-bottom: 0;border-top: 0;width: 13%"><fmt:formatNumber type="number" value="${payInfo.advanceCancelAmt}" minFractionDigits="2"/>元</td>
									<td class="tdLeft" style="border-bottom: 0;border-top: 0"><span class="spanFont">付款金额</span></td>
									<td class="tdRight" style="border-bottom: 0;border-top: 0;width: 13%"><fmt:formatNumber type="number" value="${payInfo.payAmt}" minFractionDigits="2"/>元</td>
									<td class="tdLeft" style="border-bottom: 0;border-top: 0"><span class="spanFont">暂收金额</span></td>
									<td class="tdRight" style="border-bottom: 0;border-top: 0;border-right:0;width: 13%">
										<c:if test="${!empty payInfo.suspenseAmt}">
											<fmt:formatNumber type="number" value="${payInfo.suspenseAmt}" minFractionDigits="2"/>元
										</c:if>
										<c:if test="${empty payInfo.suspenseAmt}">
											<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
										</c:if>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
			</td>
		</tr>
		<c:if test="${payInfo.advanceCancelAmt!=0}">
			<tr>
			<td></td>
		   </tr>
			<tr>
				<td>
					<table class="tableList">
						<tr class="collspan-control">
							<th colspan="5"><b>预付款核销信息【预付款核销总金额=<span id="advanceCancelAmtSpan">${payInfo.advanceCancelAmt}</span>】</b></th>
						</tr>
						<tr>
							<th width="20%">预付款批次</th>
							<th width="20%">预付款金额(元)</th>
							<th width="20%">已核销金额(元)</th>
							<th width="30%">本次核销金额(元)【累计金额=<span id="cancelAmtsSpan">${payInfo.advanceCancelAmt}</span>】</th>
							<th width="10%">操作</th>
						</tr>
						<c:forEach items="${prePayCancleList}" var="sedList">
						<tr>
							<td>
								<c:out value="${sedList.advancePayId}"></c:out>
							</td>
							<td class="tdr">
								<fmt:formatNumber type="number" value="${sedList.payAmt}" minFractionDigits="2"/>
							</td>
							<td class="tdr">
								<fmt:formatNumber type="number" value="${sedList.cancelAmtTotal}" minFractionDigits="2"/>
							</td>
							<td class="tdr">
								<fmt:formatNumber type="number" value="${sedList.cancelAmt}" minFractionDigits="2"/>
							</td>
							<td align="center">
								<div class="detail" >
									<a href="#" onclick="advanceCancelDetail('${sedList.advancePayId}');" title="明细"></a>
								</div>
							</td>
						<tr>	
						</c:forEach>
					</table>
					<table class="tableList">
						<tr class="collspan-control">
						<th colspan="14">合同采购设备(预付款)【核销总金额=<span id="advanceCancelAmtTotalSpan">${payInfo.advanceCancelAmt}</span>】</th>
					</tr>
					<tr>
						<th width="5%" rowspan="2">核算码</th>
						<th width="6%" rowspan="2">项目</th>
						<th width="6%" rowspan="2">物料名称</th>
						<th width="6%" rowspan="2">费用部门</th>
						<th width="23%" colspan="3">不含税金额(元)</th>
						<th width="5%" rowspan="2">税码</th>
						<th width="23%" colspan="3">税额(元)</th>
						<th width="20%" colspan="2">发票分配金额(元)<br>【累计金额=<span id="advancePayInvAmtsSpan">${payInfo.advanceCancelAmt}</span>】</th>
						<th width="6%" rowspan="2">发票行说明</th>
					</tr>
					<tr>
						<th>总额</th>
						<th>已付</th>
						<th>冻结</th>
						<th>总额</th>
						<th>已付</th>
						<th>冻结</th>
						<th>不含税金额</th>
						<th>税额</th>
					</tr>
					<c:forEach items="${prePayDeviceList}" var="bean">
						<tr>
							<td>${bean.cglCode }
							</td>
							<td>${bean.projName }</td>
							<td>${bean.matrName }</td>
							<td>${bean.feeDeptName }</td>
							<td><fmt:formatNumber type="number" value="${bean.execAmt}" minFractionDigits="2"/>
							</td>
							<td><fmt:formatNumber type="number" value="${bean.payedAmt}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.freezeAmt}" minFractionDigits="2"/></td>
							<td>${bean.taxCode }</td>
							<td><fmt:formatNumber type="number" value="${bean.taxAmt}" minFractionDigits="2"/>
							</td>
							<td><fmt:formatNumber type="number" value="${bean.payedAmtTax}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.freezeAmtTax}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.subInvoiceAmt}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.addTaxAmt}" minFractionDigits="2"/></td>
							<td>${bean.ivrowMemo}</td>
						</tr>
					</c:forEach>		
					</table>
				</td>
			</tr>
		</c:if>
		<c:if test="${payInfo.advanceCancelAmt != payInfo.invoiceAmt}">
		<tr>
			<td></td>
		</tr>
		<tr>
			<td>
				
				<table class="tableList">
					<tr class="collspan-control">
						<th colspan="14">合同采购设备(正常付款金额=付款金额+暂收金额)【正常付款总金额=<span id="payAmtTotalSpan">${payInfo.payAmt+payInfo.suspenseAmt}</span>】</th>
					</tr>
					
					<tr>
						<th width="5%" rowspan="2">核算码</th>
						<th width="6%" rowspan="2">项目</th>
						<th width="6%" rowspan="2">物料名称</th>
						<th width="6%" rowspan="2">费用部门</th>
						<th width="23%" colspan="3">不含税金额(元)</th>
						<th width="5%" rowspan="2">税码</th>
						<th width="23%" colspan="3">税额(元)</th>
						<th width="20%" colspan="2">发票分配金额(元) <br>【累计金额=<span id="payInvAmtsSpan">${payInfo.payAmt+payInfo.suspenseAmt}</span>】</th>
						<th width="6%" rowspan="2">发票行说明</th>
					</tr>
					<tr>
						<th>总额</th>
						<th>已付</th>
						<th>冻结</th>
						<th>总额</th>
						<th>已付</th>
						<th>冻结</th>
						<th>不含税金额</th>
						<th>税额</th>
					</tr>
					<c:forEach items="${payDeviceList}" var="bean">
						<tr>
							<td>${bean.cglCode}</td>
							<td>${bean.projName }</td>
							<td>${bean.matrName }</td>
							<td>${bean.feeDeptName }</td>
							<td>
							<fmt:formatNumber type="number" value="${bean.execAmt}" minFractionDigits="2"/>
							</td>
							<td><fmt:formatNumber type="number" value="${bean.payedAmt}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.freezeAmt}" minFractionDigits="2"/></td>
							<td>${bean.taxCode}</td>
							<td>
							<fmt:formatNumber type="number" value="${bean.taxAmt}" minFractionDigits="2"/>
							</td>
							<td><fmt:formatNumber type="number" value="${bean.payedAmtTax}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.freezeAmtTax}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.subInvoiceAmt}" minFractionDigits="2"/></td>
							<td><fmt:formatNumber type="number" value="${bean.addTaxAmt}" minFractionDigits="2"/></td>
							<td>${bean.ivrowMemo}</td>
						</tr>
					</c:forEach>				
	</table>
	<table>
					<tr class="collspan-control">
						<th colspan="4">正常付款信息</th>
					</tr>
					<tr>
						<td class="tdLeft" width="20%">付款金额</td>
						<td class="tdRight" width="30%">
							<fmt:formatNumber type="number" value="${payInfo.payAmt}" minFractionDigits="2"/>元
						</td>
						<td class="tdLeft">付款日期</td>
						<td class="tdRight">
							${payInfo.payDate}
						</td>
					</tr>
					<tr>
						<td class="tdLeft">暂收金额</td>
						<td class="tdRight">
							<c:if test="${!empty payInfo.suspenseAmt}">
								<fmt:formatNumber type="number" value="${payInfo.suspenseAmt}" minFractionDigits="2"/>元
							</c:if>
							<c:if test="${empty payInfo.suspenseAmt}">
								<fmt:formatNumber type="number" value="0" minFractionDigits="2"/>元
							</c:if>
						</td>
						<c:if test="${payInfo.suspenseAmt != null && payInfo.suspenseAmt !=0 }">
							<td class="tdLeft">暂收付款日期</td>
							<td class="tdRight">${payInfo.suspenseDate }</td>
						</c:if>
						<c:if test="${payInfo.suspenseAmt == null || payInfo.suspenseAmt ==0 }">
							<td class="tdLeft"></td>
							<td class="tdRight"></td>
						</c:if>
						
					</tr>
<%-- 					<c:if test="${payInfo.suspenseAmt != null && payInfo.suspenseAmt !=0 }"> --%>
<!-- 					<tr> -->
<!-- 						<td class="tdLeft">暂收项目</td> -->
<!-- 						<td class="tdRight"> -->
<%-- 							${payInfo.suspenseName} --%>
<!-- 						</td> -->
<!-- 						<td class="tdLeft">预处理时间</td> -->
<!-- 						<td class="tdRight"> -->
<%-- 							${payInfo.suspensePeriod}月 --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 					</c:if> --%>
<!-- 					<tr> -->
<!-- 					</tr> -->
<%-- 					<c:if test="${payInfo.suspenseAmt != null && payInfo.suspenseAmt !=0 }"> --%>
<!-- 					<tr> -->
<!-- 						<td class="tdLeft">挂帐原因</td> -->
<!-- 						<td class="tdRight" colspan="3" > -->
<%-- 							${payInfo.suspenseReason} --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 					</c:if> --%>
					<tr>
						<td class="tdLeft" >发票说明</td>
						<td class="tdRight" colspan="3">
							${payInfo.invoiceMemo}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		</c:if>
	</table>
	</form>			
	<br>
	<div style="text-align:center;" >
	<input type="button" value="查看合同扫描文件" onclick="viewCntScanImg('${cnt.id}','${cnt.icmsPkuuid }')"/>
				<c:if test="${!empty payInfo.id}">
					<input type="button" value="查看付款扫描文件" onclick="viewPayScanImg('${payInfo.payId}','${payInfo.icmsPkuuid}')"/>
				</c:if>
				<input type="button" value="查询审批历史记录" onclick="queryHis('${payInfo.payId}');">
				<p:button funcId="03030603" value="付款确认" onclick="toAudit"/>
				<input type="button" value="返回" onclick="backToLastPage('${uri}');">
	</div>	
<!-- 审批弹出框 -->
<div id="auditDiv">
	<form action="" method="post" id="auditForm">
		<input type="hidden" name="payId" value="${payInfo.payId}">
		<input type="hidden" name="isPrePay" value="${payInfo.isPrePay}"/>
		<input type="hidden" name="isFrozenBgt" value="${payInfo.isFrozenBgt}"/>
		<table width="98%" id="auditTable" >
		   <tr>
				<td align="left" colspan="2">
					<input type="hidden" id="isAgree" name="isAgree" value=""/>
					<div class="base-input-radio" id="authdealFlagDiv">
						<label for="authdealFlag1" onclick="App.radioCheck(this,'authdealFlagDiv');toSelectResult('1');" >同意</label><input type="radio" id="authdealFlag1" name="dealFlag" value="1" >
						<label for="authdealFlag2" onclick="App.radioCheck(this,'authdealFlagDiv');toSelectResult('2')" >退回</label><input type="radio" id="authdealFlag2" name="dealFlag" value="0">
					</div>
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<br>转发意见(<span id="authdealCommentSpan">0/500</span>)：
					<textarea class="base-textArea" onkeyup="$_showWarnWhenOverLen1(this,500,'authdealCommentSpan')" id="auditMemo" name="auditMemo" rows="7" cols="45" valid errorMsg="请输入转发意见。"></textarea>
				</td>
			</tr>
<%-- 			<c:if test="${payInfo.advanceCancelAmt != payInfo.invoiceAmt}"> --%>
<!-- 			<tr id="payModeTr" style="display: none;"> -->
<!-- 					<td class="tdLeft" style="width:45%"> -->
<!-- 						支付方式 -->
<!-- 					</td> -->
<!-- 					<td class="tdLeft" style="width:55%;"> -->
<!-- 					 	<div class="ui-widget" id="payModeDiv" > -->
<!-- 							<select id="payMode" name="payMode" valid   class="erp_cascade_select" > -->
<!-- 								<option value="">-请选择-</option> -->
<%-- 								<forms:codeTable tableName="SYS_SELECT" selectColumn="PARAM_VALUE,PARAM_NAME"  --%>
<%-- 								 valueColumn="PARAM_VALUE" textColumn="PARAM_NAME" orderColumn="PARAM_VALUE" orderType="DESC"  conditionStr="CATEGORY_ID='SYS_PAY_WAY'" selectedValue="${payInfo.payMode}"/> --%>
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 			</c:if> --%>
		</table>
	</form>
</div>
</body>
</html>