package com.lzy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lzy.domain.Admin;
import com.lzy.domain.Dep;
import com.lzy.domain.Filee;
import com.lzy.domain.Org;
import com.lzy.service.DepService;
import com.lzy.service.FileService;
import com.lzy.service.OrgService;

@Controller
@RequestMapping(value = "/file")
public class FileController {

	@Autowired
	private FileService fileService;
	@Autowired
	private OrgService orgService;
	@Autowired
	private DepService depService;

//	去文件管理页面
	@RequestMapping("/toManageFile")
	public String toManageFile(Model model, @RequestParam(required = true, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "5") Integer pageSize, HttpServletRequest request) {
		System.out.println("toManageFile() ran....");
//		分页:每页展示的条数
		PageHelper.startPage(page, 10);
//		准备所有文件，查看
		List<Filee> fileList = this.fileService.findAll();
//		准备所有组织，文件上传选择
		List<Org> orgList = this.orgService.findAll();

		PageInfo<Filee> pageInfo = new PageInfo<Filee>(fileList);
		long total = pageInfo.getTotal(); // 总记录数
		int pages = pageInfo.getPages(); // 总页数
		pageSize = pageInfo.getPageSize(); // 每页的展示条数
		System.out.println("总记录数 :" + total);
		System.out.println("总页数 :" + pages);
		System.out.println("每页的展示条数 :" + pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("fileList", fileList);
		model.addAttribute("orgList", orgList);
		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "manageFile";
		} else {
			return "user/showFile";
		}
	}

//	/file/delFile?fileId=${file.fileId }
	@RequestMapping("/delFile")
	public String delFile(@RequestParam("fileId") Integer fileId) {
		System.out.println("FileController.delFile ran()..");
		this.fileService.delFile(fileId);
		return "redirect:/file/toManageFile";
	}

//	/file/downloadFile?fileId=${file.fileId }
//	文件下载
	@RequestMapping("/downloadFile")
	public ResponseEntity<byte[]> download(@RequestParam(value = "fileId") Integer fileId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("FileController.download() ran ..");
		Filee filee = this.fileService.findById(fileId);
		System.out.println(filee);
		// 原文件名 : a.jpg
		System.out.println("filename : " + filee.getFileName());

//		查找文件的随机名称
		String randomN = filee.getFileRandom();
		System.out.println("randomN随机名是：" + randomN);
		/*
		 * download处理方法接收页面传递的文件名filename后，使用Apache Commons
		 * FileUpload组件的FileUtils读取项目的上传文件，并将其构建成ResponseEntity对象返回客户端下载。
		 * 使用ResponseEntity对象，可以很方便的定义返回的HttpHeaders和HttpStatus。上面代码中的MediaType，
		 * 代表的是Internet Media Type，即互联网媒体类型，也叫做MIME类型。
		 * 在Http协议消息头中，使用Content-Type来表示具体请求中的媒体类型信息。 HttpStatus类型代表的是Http协议中的状态。
		 * 有关MediaType和HttpStatus类可以参考Spring MVC的API文档。
		 */

		// 下载文件路径
		String path = request.getServletContext().getRealPath("/static/file");
		System.out.println("下载路径path ：" + path);

		File file = new File(path + File.separator + randomN);
		// file :
		// D:\myeclipse-java\apache-tomcat-8.0.53\webapps\StudentOrg\static\file\+随机文件名
		System.out.println("file : " + file);

		HttpHeaders headers = new HttpHeaders();
		System.out.println("headers===" + headers);
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String(filee.getFileName().getBytes("UTF-8"), "iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

//	/file/uploadFile
//	文件上传
	@RequestMapping(value = "uploadFile", produces = "application/json; charset=utf-8")
	public String upload(@RequestParam("upFiles") MultipartFile mFile, HttpServletRequest request) {
		System.out.println("FileController.upload() ran ..");
		System.out.println("mFile:" + mFile);
		// 取到文件集合fileList,遍历每一个文件
		try {
			System.out.println("file.getName()===" + mFile.getName());
			String fileName = mFile.getOriginalFilename(); // 原始名称： a.jpg
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
			mFile.transferTo(new File(realFileName));
			/* 因为关闭服务器后，上传的文件都会丢失，因此将上传的文件复制(IOUtils.copy(输入流：上传路径，输出流：项目静态资源))到工作空间下 */
			// 注意文件分隔符
			// String seperator = File.separator; 根据不同的操作系统生成不同的分隔符
			// 导入jar包：commons-io-2.4.jar
			IOUtils.copy(new FileInputStream(new File(realFileName)),
					new FileOutputStream(new File("F:/eclipse-workspace-stuorg/upfiles/" + random + suffix)));

			// 取组织部门Id
			Integer orgId = Integer.parseInt(request.getParameter("orgId"));
			Integer depId = Integer.parseInt(request.getParameter("depId"));
			System.out.println("取到的组织值：" + orgId);
			System.out.println("取到的部门值：" + depId);
			// 取组织部门
			Org org = this.orgService.findById(orgId);
			Dep dep = this.depService.findById(depId);
			System.out.println("取到的部门：" + dep);
			System.out.println("取到的部门：" + org);
			// 取用户
			HttpSession session = request.getSession();
			Admin admin = (Admin) session.getAttribute("admin");
			System.out.println("session中取到的上传者：" + admin);

			String randomN = random + suffix;
			System.out.println("随机名：" + randomN);

			/* 上传文件时，创建日期 */
//			 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
			// 将文件插入数据库的文件表
			Filee f = new Filee();
			f.setFileName(fileName);// 文件名
			f.setFileRandom(randomN);// 随机生成的文件名：随机数+后缀
			f.setFileDep(dep);
//				创建当前时间存入数据库，
			f.setFileDate(new Date());
			f.setFileUploader(admin);
			this.fileService.save(f);

			System.out.println("上传成功");
			return "redirect:/file/toManageFile";

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("上传失败");
			throw new RuntimeException(e);
		}

	}

}
