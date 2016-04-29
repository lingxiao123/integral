$(function(){
	
	fileManager_Main = new function(){
		   
	     /**
	 	 * 1.1 upload 检测文件格式
	 	 */
	 	this.fileInit = function(thisval) {
	 		var fileInput = $("#fileField")[0];
	 		var ff=$("#fileField");
	 		byteSize = fileInput.files[0].size;//Byte
	 		$("#tipfile").detach();
	 		console.info(-1== thisval.indexOf('.xls'));
	 		if (-1== thisval.indexOf('.xls')) {
	 			this.fl(ff,thisval,1);
	 			Common.showBySite('温馨提示', '请选择正确的文件格式(.xls或.xlsx)!');
	 			return;
	 		}
	 		
	 		if( byteSize > (100 * 1024 * 1024)){
	 			this.fl(ff,thisval,1);
	         	Common.showBySite('温馨提示', '上传文件最大值为100兆(M)!');
	         	return;
	         }
	        	 this.fl(ff,thisval,0);
	 	}; 
	 	
	 	this.fl = function(obj,val,i){
	 		if(i==1){
	 		obj.before("<input type='text' class='ffinput1' id='tipfile' value='"+val+"'/>");
	 		 return;
	 		}
	 		if(i==0){
	 			obj.before("<input type='text' class='ffinput2' id='tipfile' value='"+val+"'/>");
		 	return;
	 		}
	 	};
	 	/*
	 	 * 1.2 进度条显示
	 	 
	 	this.progressBarPro = function() {
	 		
	 		 alert(1);
	 			
	 		    var value = $('#prosbar').progressbar('getValue');
	 		    if (value < 100){
	 		    value += Math.floor(Math.random() * 10);
	 		    $('#prosbar').progressbar('setValue', value);
	 		    }
	 		

	 		
	 	};*/
	 	
	 	/**
	 	 * 1.3文件upload
	 	 */
	 	this.file_upload = function() {
	 		var imgval = $('#fileField').val();
	 		if ("" == imgval) {
	 			Common.showBySite('温馨提示', '请选择文件！');
	 			return;
	 		} else {
	 			if (-1 == imgval.indexOf('.xls')) {
	 				Common.showBySite('温馨提示', '请选择正确的文件格式(.xls 或者 .xlsx)!');
	 				return;
	 			}
	 			var fileInput = $("#fileField")[0];
	 	        byteSize  = fileInput.files[0].size;//Byte
	 	        if( byteSize > (100 * 1024 * 1024)){
	 	        	Common.showBySite('温馨提示', '上传文件最大值为100M!');
	 	        	return;
	 	        }
	 		}
	 		var flag = $('#fm_fileinfo_info').form('validate');
	 		if (flag) {
	 			$("#fm_fileinfo_info").form('submit', {
	 				url :'<%=root%>/implog/tolead',
	 				timeout : 3000000,
	 				success:function(data){
	 					
	 			      var r = jQuery.parseJSON(data);
	 			      $.messager.alert('温馨提示',r.msg,'info');
	 			      $("#dl").dialog('close');
	 			      
	 			     $("#impfinlogdg").datagrid('reload');//刷新

	 				}
	 			});
	 			//$("#prosbar").show();
	 			//_this.progressBarPro();
	 		} else {
	 			return flag;
	 		}
	 	};
	 	
  };
	
});