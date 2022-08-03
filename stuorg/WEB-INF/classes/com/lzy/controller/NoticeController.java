package com.lzy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lzy.domain.Admin;
import com.lzy.domain.Filee;
import com.lzy.domain.Notice;
import com.lzy.service.FileService;
import com.lzy.service.NoticeService;

@Controller
@RequestMapping(value = "/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private FileService fileService;

//	去公告通知管理中心
//	/notice/toManageNotice
	@RequestMapping("/toManageNotice")
	public String toManageNotice(Model model, HttpServletRequest request) {
		System.out.println("NoticeController.toManageNotice ran()..");
		List<Notice> noticeList = this.noticeService.findAll();
		model.addAttribute("noticeList", noticeList);

		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "manageNotice";
		} else {
			return "user/showNotice";
		}
	}

//	删除公告
//	"/notice/delNotice?noticeId=${notice.noticeId }
	@RequestMapping("/delNotice")
	public String delNotice(@Param("noticeId") Integer noticeId) {
		System.out.println("NoticeController.delNotice ran()..");
		this.noticeService.delById(noticeId);
		System.out.println("删除notice");
		return "redirect:/notice/toManageNotice";
	}

//	发布公告
//	/notice/addNotice
	@RequestMapping("/addNotice")
	public String addNotice(@RequestParam("upFiles") MultipartFile upFiles,
			@RequestParam("noticeTitle") String noticeTitle, @RequestParam("noticeContent") String noticeContent,
			HttpServletRequest request) {
		System.out.println("NoticeController.addNotice ran()..");
		try {
//			准备Admin，从Session
			HttpSession session = request.getSession();
			Admin admin = (Admin) session.getAttribute("admin");
			System.out.println("session中的admin：" + admin);

			System.out.println("file.getName()===" + upFiles.getName());
			String fileName = upFiles.getOriginalFilename(); // 原始名称： a.jpg
			/* 文件的后缀名:从最后一个.以后的字符串就是后缀 */
			String suffix = fileName.substring(fileName.lastIndexOf("."));// 后缀：.jpg

			/* 使用UUID来获得随机32位字符串作为文件保存时的名字 */
			// 当上传的文件是相同的时候，服务器中产生随机名来存储图片以避免重名问题。
			String random = UUID.randomUUID().toString().replace("-", "");

			/* 找到要上传的服务器Tomcat的真实名称（映射过去） */
			// request.getServletContext() 其实就是ApplicationContext的对象
			String real = request.getServletContext().getRealPath("/static/file/");

			/* 所以，上传的文件的完整的路径的字符串为 */
			String realFileName = real + random + suffix;
			System.out.println(" real + random + suffix =" + realFileName);

			/* 对文件集合里的每一个文件进行存储,即上传：realFileName文件的完整的路径已经得到 */
			// File是io包的，会抛异常
			upFiles.transferTo(new File(realFileName));
			/* 因为关闭服务器后，上传的文件都会丢失，因此将上传的文件复制(IOUtils.copy(输入流：上传路径，输出流：项目静态资源))到工作空间下 */
			// 注意文件分隔符
			// String seperator = File.separator; 根据不同的操作系统生成不同的分隔符
			// 导入jar包：commons-io-2.4.jar
			IOUtils.copy(new FileInputStream(new File(realFileName)),
					new FileOutputStream(new File("F:/eclipse-workspace-stuorg/upfiles/" + random + suffix)));

			String randomN = random + suffix;
			System.out.println("随机名：" + randomN);

//			Notice表：插入
//			准备Notice
			Notice notice = new Notice();
			notice.setNoticeTitle(noticeTitle);
			notice.setNoticeContent(noticeContent);
			notice.setNoticeTime(new Date());
			notice.setNoticePerson(admin);
			notice.setNoticeDep(admin.getAdminDep());
			System.out.println("已准备的Notice：" + notice);
//			插入
			this.noticeService.insertNotice(notice);
			System.out.println("notice 插入成功");

//			找到最新插入的Notice
			Notice noticeNew = this.noticeService.findMaxId();
			/* 上传文件时，创建日期 */
//			 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
			// 将文件插入数据库的文件表
			Filee f = new Filee();
			f.setFileName(fileName);// 文件名
			f.setFileRandom(randomN);// 随机生成的文件名：随机数+后缀
			f.setFileDep(admin.getAdminDep());
//				创建当前时间存入数据库，
			f.setFileDate(new Date());
			f.setFileUploader(admin);
			f.setFileNotice(noticeNew);
			this.fileService.save(f);
			System.out.println("上传成功");

			return "redirect:/notice/toManageNotice";

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("上传失败");
			throw new RuntimeException(e);
		}

	}

}
