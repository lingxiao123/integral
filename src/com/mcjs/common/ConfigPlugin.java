package com.mcjs.common;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.config.Plugins;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.cache.EhCache;
import com.jfinal.plugin.activerecord.dialect.Dialect;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;

/**
 * 
 * @author yangfeng
 * 
 */
public class ConfigPlugin {

	public static final String DIALECT_MYSQL = "mysql";
	public static final String DIALECT_ORACLE = "oracle";

	public static Map<String, Dialect> dialectMap = null;
	static {
		dialectMap = new HashMap<String, Dialect>();
		dialectMap.put(DIALECT_MYSQL, new MysqlDialect());
		dialectMap.put(DIALECT_ORACLE, new OracleDialect());
	}

	/**
	 * 
	 * @param me为Plugins实例
	 * @param jdbcUrl为jdbc配置文件key
	 * @param user为jdbc配置文件key
	 * @param password为jdbc配置文件key
	 */
	public static ActiveRecordPlugin addC3p0Plugin(Plugins me, String dbtype,
			String dsname, String jdbcUrl, String user, String password) {
		ActiveRecordPlugin arp = null;
		if (me != null && jdbcUrl != null && user != null && password != null) {
			C3p0Plugin c3p0Plugin = new C3p0Plugin(jdbcUrl.trim(), user.trim(),
					password.trim());
			me.add(c3p0Plugin);			
			arp = new ActiveRecordPlugin(dsname, c3p0Plugin);
			arp.setContainerFactory(new CaseInsensitiveContainerFactory());//忽大小写
			me.add(arp);
			arp.setCache(new EhCache());
			arp.setDialect(dialectMap.get(dbtype));
		}
		return arp;
	}
}
