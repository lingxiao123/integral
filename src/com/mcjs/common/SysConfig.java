package com.mcjs.common;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.render.ViewType;
import com.mcjs.common.action.CommonInterceptor;

public class SysConfig extends JFinalConfig {
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		loadPropertyFile("jdbc.properties");
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP);
		me.setUrlParaSeparator(",");
		me.setMaxPostSize(102400000);
	}
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
       
	}
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		ActiveRecordPlugin arp = ConfigPlugin.addC3p0Plugin(me,
				ConfigPlugin.DIALECT_MYSQL, "demo", getProperty("jdbcUrl"),
				getProperty("user"), getProperty("password"));
		// 映射表到 Model模型 
	}
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new CommonInterceptor());
	}
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		
	}

}
