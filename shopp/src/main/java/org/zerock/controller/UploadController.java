package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		System.out.println("upload form 화면 호출");
//		log.info("upload form");
	}
		
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile,Model model) {
		System.out.println("uploadFormAction 요청");
		
		String uploadFolder="C:\\studySpring\\shopp\\src\\main\\webapp\\resources\\upload\\";
		
		for(MultipartFile multipartFile:uploadFile) {			
			System.out.println("-----------------");
			System.out.println("업로드 파일 이름:"+multipartFile.getOriginalFilename());
			System.out.println("업로드 파일 크기:"+multipartFile.getSize());
			
			// c:\\upload\\파일이름
			File saveFile=new File(uploadFolder,multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction",
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile,Model model) {
		log.info("Ajax 전송.....");
		
		List<AttachFileDTO> list=new ArrayList<>();
		String uploadFolder="C:\\studySpring\\shopp\\src\\main\\webapp\\resources\\upload";
		
		//폴더 경로 만들기
		String uploadFolderPath="2021";
		
		File uploadPath=new File(uploadFolder,uploadFolderPath);
		
		log.info("upload path:"+uploadPath);
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();	//폴더 생성
		}
		
		for(MultipartFile multipartFile:uploadFile) {
			
			log.info("-----------------");
			log.info("업로드 파일 이름:"+multipartFile.getOriginalFilename());
			log.info("업로드 파일 크기:"+multipartFile.getSize());
			
			String uploadFileName=multipartFile.getOriginalFilename();
			log.info("crome과 IE file name 비교:"+uploadFileName);
			
			//IE 브라우저 파일 path
			uploadFileName=uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("only file name:"+uploadFileName);
			
			UUID uuid=UUID.randomUUID();
			
			AttachFileDTO attachDTO=new AttachFileDTO();
			attachDTO.setFileName(uploadFileName);
			attachDTO.setUploadPath(uploadFolderPath);
			attachDTO.setUuid(uuid.toString());
			
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			
//			File saveFile=new File(uploadFolder,multipartFile.getOriginalFilename());
			File saveFile=new File(uploadPath,uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
								
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail=new FileOutputStream(
							new File(uploadPath,"s_"+uploadFileName));
					
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(),thumbnail,100,100);
					
					thumbnail.close();
				}
				list.add(attachDTO);
				
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName1:"+fileName);
		
		File file=new File("C:\\studySpring\\shopp\\src\\main\\webapp\\resources\\upload\\"+fileName);
		log.info("file2:"+file);
		
		ResponseEntity<byte[]> result=null;
		
		try {
			HttpHeaders header=new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<>(
					FileCopyUtils.copyToByteArray(file),
					header,HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType=Files.probeContentType(file.toPath());
			
			System.out.println("contentType:"+contentType);
			
			return contentType.startsWith("image");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@GetMapping(value="/download",
			produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
			@RequestHeader("User-Agent") String userAgent,
			String fileName){
		
		log.info("download file:"+fileName);
		
		Resource resource=new FileSystemResource("c:\\upload\\"+fileName);
		
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName=resource.getFilename();
		
		//uuid 이름 제거
		String resourceOriginalName=resourceName.substring(
				resourceName.lastIndexOf("_")+1);
		
		HttpHeaders headers=new HttpHeaders();
		try {
			String downloadName=null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				
				downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8")
						.replaceAll("\\+", " ");
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				
				downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8");
				log.info("Edge name: "+downloadName);
			}else {
				log.info("Chroome browser");
				downloadName=new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", 
					"attachment; filename="+downloadName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(
				resource,headers,HttpStatus.OK);		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type){
		log.info("deleteFile:"+fileName);
		
		File file;
		
		try {
			file=new File("c:\\upload\\"+URLDecoder.decode(fileName,"UTF-8"));
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName=file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName:"+largeFileName);
				
				file=new File(largeFileName);
				file.delete();
			}
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
}
