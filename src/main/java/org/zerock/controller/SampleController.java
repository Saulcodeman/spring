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

@RestController //모든 뷰 처리가 JSP가아니라는것을 의미 , 모든 메소드는 @ResponseBody가 적용됨 , (3.xx버전 Spring까지 쓰던 방식).
@RequestMapping("/sample")
public class SampleController{
	
	@RequestMapping("/hello1")
	public String sayHello(){
		return "Hello World";
	}
	
	@RequestMapping("/sendVO1")
	public SampleVO sendVO(){
		SampleVO vo = new SampleVO();
		vo.setFirstName("길동");
		vo.setLastName("홍");
		vo.setMno(123);
		
		return vo;
	}
	
	@RequestMapping("/sendList") //List타입 데이터 반환
	public List<SampleVO> sendList(){
		
		List<SampleVO> list = new ArrayList<>(); //<>JDK1.7이상 클래스에 제네릭 타입을 명시하지않아도 된다(타입 추론).
		for(int i=0; i<10; i++){
			SampleVO vo = new SampleVO();
			vo.setFirstName("길동");
			vo.setLastName("홍");
			vo.setMno(i);
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap") //Map타입 반환  
	public Map<Integer, SampleVO> sendMap(){
		
		Map<Integer, SampleVO> map = new HashMap<>();
		
		for(int i=0; i<10; i++){
			SampleVO vo = new SampleVO();
			vo.setFirstName("길동");
			vo.setLastName("홍");
			vo.setMno(i);
			map.put(i, vo);  //(i가 key, SampleVO 타입의 객체가 value)
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
			vo.setFirstName("길동");
			vo.setLastName("홍");
			vo.setMno(i);
			list.add(vo);
		}
		return new ResponseEntity<>(list, HttpStatus.NOT_FOUND);
	}
}