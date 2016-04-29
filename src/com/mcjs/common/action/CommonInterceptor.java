package com.mcjs.common.action;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;

/**
 * BlogInterceptor
 */
public class CommonInterceptor implements Interceptor {
	
	public void intercept(ActionInvocation ai) {
		System.out.println("Before invoking " + ai.getActionKey());
		ai.invoke();
		Controller controller = ai.getController();
		
		//System.out.println("ai.getMethod() :: "+ai.getController().getRequest().getMethod());
		
		//if("GET".equals(ai.getController().getRequest().getMethod())){
		//	controller.render("/jsp/common/login/login.jsp");
		//}
		
		String usernam = (String) controller.getSession().getAttribute("lognam");
		System.out.println("usernam ====="+usernam);
		
		
		if(!ai.getActionKey().equals("/login")){
			
			if(usernam==null){
				System.out.println("99999999999999999999999");
				controller.render("/jsp/common/login/login.jsp");
				
			}
			
		}
		System.out.println("After invoking " + ai.getActionKey());
		return;	
	}
}
