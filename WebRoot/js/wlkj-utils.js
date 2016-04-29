/*validatebox的扩展validType*/
$.extend($.fn.validatebox.defaults.rules, {
    eqPasswd: {/*扩展两次密码输入是否一致*/
        validator: function(value,param){
            return value == $(param[0]).val();
        },
        message: '密码不一致.'
    },
    unqiuename:{
 		 validator:function(value){
 		
 			 $.ajax({
 				 url:'<%=root%>/orginf/isExist',
 					method : 'post',
 					data : {
 						"OrgNam" : value
 					},
 					success : function(data) {

 						if (data.msg == 'yes') {
 							alert(data.msg == 'yes');
 							return true;
 						} else {
 							alert( data.msg == 'yes');
 							 return false;
 						}
 					}
 				});
 			},
 			message : '错误！该名称存在'
 		}

});

