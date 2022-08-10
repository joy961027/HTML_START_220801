/*��ʿ� ����� ��ǰ�� ��ü�� ����(��Ǫ��)*/
class Product{
	constructor(container,src,width,height,x,y){

		this.container=container;
		this.img=document.createElement("img");//;������ ���� �̹���
		this.src=src;
		this.width=width;
		this.height=height;
		this.x=x; //����left��
		this.y =y;

		this.img.src=this.src;//img���� �������
		this.img.style.width= this.width+"px";
		this.img.style.height= this.height+"px";
		this.img.style.position = "absolute";
		this.img.style.left =this.x+"px";
		this.img.style.top =this.y+"px";
		this.container.appendChild(this.img);
		//������ ����ü�� ���ϴ� �θ��ҿ� ����!!
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
	//��ü�̵��޼�������� ���Ŀ��� left���� ������ ���ϱ�
	move(){
		this.img.style.left =this.x+"px";
		if(this.x < -(this.width+5)){
			this.x = (this.width+5)*6;
		}
	}

}