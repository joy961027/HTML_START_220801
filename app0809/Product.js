/*배너에 사용할 상품용 객체를 정의(거푸집)*/
class Product{
	constructor(container,src,width,height,x,y){

		this.container=container;
		this.img=document.createElement("img");//;문서에 붙일 이미지
		this.src=src;
		this.width=width;
		this.height=height;
		this.x=x; //현재left값
		this.y =y;

		this.img.src=this.src;//img돔의 경로지정
		this.img.style.width= this.width+"px";
		this.img.style.height= this.height+"px";
		this.img.style.position = "absolute";
		this.img.style.left =this.x+"px";
		this.img.style.top =this.y+"px";
		this.container.appendChild(this.img);
		//생성된 돔객체를 원하는 부모요소에 부착!!
		this.img.addEventListener("mouseover",function(){
			flag=false;
		});

		this.img.addEventListener("mouseout",function(){
			flag=true;
		});
		this.img.addEventListener("click",function(){
			window.open(this.src,"_blank");
		});
		
	}
	//물체이동메서드생성된 이후에도 left값을 변경할 꺼니까
	move(){
		this.img.style.left =this.x+"px";
		if(this.x < -(this.width+5)){
			this.x = (this.width+5)*6;
		}
	}

}