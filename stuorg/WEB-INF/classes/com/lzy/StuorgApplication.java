package com.lzy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StuorgApplication {

	public static void main(String[] args) {

		try {
//			解决异常：org.springframework.boot.devtools.restart.SilentExitExceptionHandler$SilentExitException
//			在Application启动器类中增加参数，禁用热修补，并且必须使用System.setProperty方法而不是将其设置到application.properties文件	
//			System.setProperty("spring.devtools.restart.enabled", "false");
			SpringApplication.run(StuorgApplication.class, args);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
