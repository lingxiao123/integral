<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<% String path = request.getContextPath(); %>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="<%=path%>/mainjs/css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/mainjs/js/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/mainjs/js/themes/icon.css" />
    <script type="text/javascript" src="<%=path%>/mainjs/js/jquery-1.4.4.min.js" ></script>
    <script type="text/javascript" src="<%=path%>/mainjs/js/jquery.easyui.min.1.2.2.js" ></script>
    <script type="text/javascript" src="<%=path%>/mainjs/js/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=path%>/mainjs/js/outlook2.js" > </script>	
	<style type="text/css">
		a:hover {
			text-decoration: none;
		}
		a:link {
			text-decoration: none;
		}
	</style>
    <script type="text/javascript">    
	 var _menus = {"menus":[
							{"menuid":"1","icon":"icons-product-design","menuname":"导入管理",
							 "menus":[
										{"menuid":"12","menuname":"机构数据管理","icon":"icons-payment-card","url":"<%=path%>/cominf/index_log"},
                                        {"menuid":"11","menuname":"居间数据管理","icon":"icons-credit-card","url":"<%=path%>/orginf/index_log"},
                                        {"menuid":"15","menuname":"个代数据管理","icon":"icons-payment-card","url":"<%=path%>/Loaninf/index_log"},
                                        {"menuid":"16","menuname":"终端数据管理","icon":"icons-payment-card","url":"<%=path%>/terminf/index_log"},
										{"menuid":"13","menuname":"财务数据管理","icon":"icons-equalizer","url":"<%=path%>/finance/index_log"}
                                        <%-- ,{"menuid":"13","menuname":"持仓数据管理","icon":"icons-equalizer","url":"<%=path%>/positions/index"} --%>
									]
							},{"menuid":"2","icon":"icons-statistics","menuname":"统计管理",
								"menus":[{"menuid":"20","menuname":"统计机构对账单","icon":"icons-project","url":"<%=path%>/statement/index_log"},
								         {"menuid":"21","menuname":"统计居间对账单","icon":"icons-document","url":"<%=path%>/statement/index1_log"},
								         {"menuid":"22","menuname":"统计个代对账单","icon":"icons-document","url":"<%=path%>/statement/Loanindex"},
								         {"menuid":"23","menuname":"统计终端对账单","icon":"icons-document","url":"<%=path%>/statement/Terminalindex"}
								       
									]
							}
							<c:if test="${usrtyp eq '0'}">
							,
							{"menuid":"4","icon":"icons-home","menuname":"系统管理",
								"menus":[{"menuid":"41","menuname":"用户管理","icon":"icon-users","url":"<%=path%>/user/list"}
									]
							}
							 </c:if>
					]};	 	
     //设置登录窗口
     function openPwd() {
         $('#w').window({
             title: '修改密码',
             width: 300,
             modal: true,
             shadow: true,
             closed: true,
             height: 160,
             resizable:false
         });
     }     
     //关闭登录窗口
     function closePwd() {
     	$('#password').val('');
     	$('#newpassword').val('');
     	$('#repassword').val('');
         $('#w').window('close');
     }
     //修改密码
     function serverLogin() {
         if ($('#password').val() == '') {
             msgShow('系统提示', '请输入旧密码！', 'warning');
             return false;
         }   
         if ($('#newpassword').val() == '') {
             msgShow('系统提示', '请输入新密码！', 'warning');
             return false;
         }        
         if ($('#repassword').val() == '') {
             msgShow('系统提示', '请在一次输入新密码！', 'warning');
             return false;
         }
         if ($('#newpassword').val()  != $('#repassword').val()) {
             msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
             return false;
         }
		 $.ajax({
			//async:false,
			cache:false,
			type:"POST",
			dataType:"json",
			url:"<%=path%>/updPassword",
			data:{"password":$('#password').val(),"newpassword":$('#newpassword').val(),"repassword":$('#repassword').val()},
			error: function () {//请求失败处理函数
				alert("请求失败");
			},success:function(data){
				 $.messager.alert("消息",data.msg,"info");
				 closePwd();
			}
		 });      
     }
     function addTabStr(titleStr,urlStr,iconStr){    	
     		$('#tabs').tabs('add',{
     			title:titleStr,
     			content:createFrameStr(urlStr),
     			closable:true,
     			icon:iconStr
     		});
     }

     function createFrameStr(url)
     {
     	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
     	return s;
     }
     

     $(function() {
     	var urlPP="<%=path%>";
     	addTabStr("居间数据管理",urlPP+"/orginf/index_log","icons-credit-card");        
         function currentTime(){
         	var d = new Date(),str = '';
         	 str += d.getFullYear()+'年';
         	 str  += d.getMonth() + 1+'月';
         	 str  += d.getDate()+'日';
         	 str += d.getHours()+'时'; 
         	 str  += d.getMinutes()+'分'; 
         	str+= d.getSeconds()+'秒'; 
         	return str;
         	}
         	setInterval(function(){$('#timerSpan').html(currentTime)},1000);
         openPwd();
         $('#editpass').click(function() {
             $('#w').window('open');
         });
         $('#btnEp').click(function() {
             serverLogin();
         })
			$('#btnCancel').click(function(){closePwd();})
         $('#loginOut').click(function() {
             $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
                 if (r) {
                     location.href = '<%=path%>/loginOut';
                 }
             });
         });
     });
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
	<!--
		<noscript>
			<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
			    <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
			</div>
		</noscript>
	-->
	<style type="text/css">
			.headerit{overflow: hidden; height: 95px; background-image: url(<%=path%>/images/c_headbg.jpg); background-color: rgb(127, 153, 190); line-height: 20px; color: rgb(255, 255, 255); font-family: Verdana, 微软雅黑, 黑体; width: 1440px; /*background-position: 50% 50%;*/ background-repeat: repeat-x;}
			.optionit{display:block;height:95px;background:url(<%=path%>/images/c_headrbg.jpg) no-repeat top right;line-height: 95px;float:right;width:300px;padding-right:20px;}
			#cicon01{display:block;float:right;width:65px;height:74px;text-indent:-44444px;background:url(<%=path%>/images/c_icon01.png) no-repeat 0 0;margin-top:10px;margin-left:20px;}
			#cicon01:hover{background-image:url(<%=path%>/images/c_icon01-on.png);}
			#editpass{display:block;float:right;width:65px;height:74px;text-indent:-44444px;background:url(<%=path%>/images/c_icon02.png) no-repeat 0 0;margin-top:10px;margin-left:20px;}
			#editpass:hover{background-image:url(<%=path%>/images/c_icon02-on.png);}
			#loginOut{display:block;float:right;width:65px;height:74px;text-indent:-44444px;background:url(<%=path%>/images/c_icon03.png) no-repeat 0 0;margin-top:10px;margin-left:20px;}
			#loginOut:hover{background-image:url(<%=path%>/images/c_icon03-on.png);}
	</style>
	<div region="north" split="true" border="false" class="layout-body panel-body panel-body-noheader panel-body-noborder headerit" title="" style="height:120px;">
        <span class="optionit">
	        <a href="#" id="loginOut">安全退出</a>
	        <a href="#" id="editpass">修改密码</a>
	        <!--<a href="#" id="cicon01">用户信息</a>-->
	    </span>
        <span style="padding-left:0px; font-size: 16px; ">
	        <img src="<%=path%>/images/c_headlogo.jpg" align="absmiddle" alt="赣州网联科技业务技术平台">
        </span>    
    </div>
    <style>
    .top-bar { position: absolute; width: 100%; height: 52px; top: 0; left: 0; }
	.top-bar-left { position: absolute; width: 500px; height: 52px; }
	.top-bar-right { position: absolute; width: 400px; height: 52px; right: 0; }
	.top-bar-right #timerSpan { position: absolute; padding-top: 5px; right: 10px; }
	.top-bar-right #themeSpan { position: absolute; width: 350px; top: 24px; right: 5px; text-align: right; }
	.top-toolbar { position: absolute; font-weight: normal; padding: 0; width: 100%; height: 28px; top: 90px; left: 0; border-top-width: 1px; border-bottom-width: 0; z-index: 100; }
	.top-toolbar-topmost { top: 0px; height: 27px; border-top-width: 0px; border-bottom-width: 1px; }
	.top-toolbar #infobar { position: absolute; height: 26px; line-height: 26px; left: 10px; }
	.top-toolbar #searchbar { position: absolute; height: 26px; left: 400px; padding-top: 1px; }
	.top-toolbar #buttonbar { position: absolute; height: 26px; right: 5px; padding-top: 1px; text-align: right; }
	</style>
    <div id="toolbar" class="panel-header panel-header-noborder top-toolbar">
        <div id="infobar">
            <span class="icons-user" style="padding-left: 25px; background-position: left ;float:left;">
                	您好,${lognam},&nbsp;欢迎登录              
            </span>
            <div id="timerSpan" style="float:left;margin-left:18px;"></div>
        </div>                
    </div>
    <div region="south" split="true" style="height:40px;overflow:hidden; background: #D2E0F2; ">
        <div class="footer"  style="height: 40px;line-height: 30px; background: #D2E0F2; ">Copyright © 2014 江西金澍贵金属投资经营有限公司 电话：400-998-2122</div>
    </div>  
    <div region="west" hide="true" split="true" title="导航菜单" style="width:220px;" id="west">
	<div id="nav" class="easyui-accordion" fit="true" border="false">
		<!--  导航内容 -->		
	</div>
    </div>   
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
        <!--<div title="系统首页" style="padding:20px;overflow:hidden; color:red; " ></div>-->
		</div>
    </div>      
    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 155px; padding: 5px;
        background: #fafafa;">
        <div class="easyui-layout" fit="true" >
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding=3>               
                    <tr>
                        <td>旧密码：</td>
                        <td><input id="password" name="password" type="password" class="txt01" /></td>
                    </tr>                    
                    <tr>
                        <td>新密码：</td>
                        <td><input id="newpassword" name="newpassword" type="password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="repassword" name="repassword" type="password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">          
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)"  onclick="updPassword()">确定</a>               
                <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)" onclick="closePwd()">取消</a>         
            </div>
        </div>
    </div>
	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
</body>
</html>