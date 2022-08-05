/*
현실의 사진및 부가정보를 가진 단위를 객체화 시켜보자
객체화 시키면, 이미지 경로뿐만아니라, 훨씬더 많은 정보들을 담아낼수 있다.
참고) 2015년도 발표된 자바스크립트(ECMASript)에서는 클래스를 지원한다.
*/
class Photo{
	constructor(src, title, addr, content){
		this.img=document.createElement("img"); //이미지 dom
		this.src=src; //경로
		this.title=title; //사진의 제목
		this.addr=addr;//사진의 주소
		this.content=content;//사진의 설명
		
		this.img.src=this.src; //경로지정
		document.body.appendChild(this.img);
	}

}

	
