package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

@RestController //��� �� ó���� JSP���ƴ϶�°��� �ǹ� , ��� �޼ҵ�� @ResponseBody�� ����� , (3.xx���� Spring���� ���� ���).
@RequestMapping("/sample")
public class SampleController{
	
	@RequestMapping("/hello1")
	public String sayHello(){
		return "Hello World";
	}
	
	@RequestMapping("/sendVO1")
	public SampleVO sendVO(){
		SampleVO vo = new SampleVO();
		vo.setFirstName("�浿");
		vo.setLastName("ȫ");
		vo.setMno(123);
		
		return vo;
	}
	
	@RequestMapping("/sendList") //ListŸ�� ������ ��ȯ
	public List<SampleVO> sendList(){
		
		List<SampleVO> list = new ArrayList<>(); //<>JDK1.7�̻� Ŭ������ ���׸� Ÿ���� ��������ʾƵ� �ȴ�(Ÿ�� �߷�).
		for(int i=0; i<10; i++){
			SampleVO vo = new SampleVO();
			vo.setFirstName("�浿");
			vo.setLastName("ȫ");
			vo.setMno(i);
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap") //MapŸ�� ��ȯ  
	public Map<Integer, SampleVO> sendMap(){
		
		Map<Integer, SampleVO> map = new HashMap<>();
		
		for(int i=0; i<10; i++){
			SampleVO vo = new SampleVO();
			vo.setFirstName("�浿");
			vo.setLastName("ȫ");
			vo.setMno(i);
			map.put(i, vo);  //(i�� key, SampleVO Ÿ���� ��ü�� value)
		}
		return map;
	}
	
	@RequestMapping("/sendErrorAuth") //400error
	public ResponseEntity<Void> sendListAuth(){
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<SampleVO>> sendListNot() {
		
		List<SampleVO> list = new ArrayList<>();
		for(int i=0; i<10; i++){
			SampleVO vo = new SampleVO();
			vo.setFirstName("�浿");
			vo.setLastName("ȫ");
			vo.setMno(i);
			list.add(vo);
		}
		return new ResponseEntity<>(list, HttpStatus.NOT_FOUND);
	}
}