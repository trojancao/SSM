package ecloud;

public class test {

	public static void main(String[] args){
		A a1 = new A();  
        A a2 = new B();  
        B b = new B();  
        D d = new D();   
        System.out.println(a1.show(b));
        System.out.println(a2.show(b));
        System.out.println(a2.show(d));
        StringBuilder sBuilder = new StringBuilder();
        StringBuffer stringBuffer = new StringBuffer();
        
	}
}
//对于多态，可以总结以下几点：
//
//一、使用父类类型的引用指向子类的对象；
//
//二、该引用只能调用父类中定义的方法和变量；
//
//三、如果子类中重写了父类中的一个方法，那么在调用这个方法的时候，将会调用子类中的这个方法；（动态连接、动态调用）;
//
//四、变量不能被重写（覆盖），"重写"的概念只针对方法，如果在子类中"重写"了父类中的变量，那么在编译时会报错。
class A {  
	public  A() {
		System.err.println("A");
	}
    public String show(D obj){  
           return ("A and D");  
    }   
    public String show(A obj){  
           return ("A and A");  
    }   
}   
class B extends A{  
	public  B() {
		System.err.println("B");
	}
    public String show(B obj){  
           return ("B and B");  
    }  
    public String show(A obj){  
           return ("B and A");  
    }   
}  

class D {  
public  D() {
		
	}
    public String show(D obj){  
           return ("D and D");  
    }  
    public String show(B obj){  
           return ("B and D");  
    }   
}  