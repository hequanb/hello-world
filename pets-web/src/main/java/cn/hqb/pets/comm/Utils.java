package cn.hqb.pets.comm;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

public class Utils {
	
    // 除法运算默认精度  
    private static final int DEF_DIV_SCALE = 10;  
	
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	/**
	 * @throws Exception 
	 * @throws AddressException   
	* @Title: sendMail  
	* @Description: 发送邮件  
	* @param @param to   目标
	* @param @param code 验证码
	* @return void 
	* @throws  
	*/ 
	public static void sendMail(String to, String code) throws AddressException, Exception{
		/**
		 * 1.获得一个Session对象.
		 * 2.创建一个代表邮件的对象Message.
		 * 3.Transport对象发送邮件
		 */
		
		//1.获得连接对象
		Properties props = new Properties();
		 // 表示SMTP发送邮件，必须进行身份验证
        props.put("mail.smtp.auth", "true");
        //此处填写SMTP服务器
        props.put("mail.smtp.host", "smtp.qq.com");
        //端口号，QQ邮箱POP3的端口号995,SMTP的端口号是465或587
        props.put("mail.smtp.port", "587");
        // 此处填写你的账号
        props.put("mail.user", "596910450@qq.com");
        // QQ邮箱POP/SMTP的16位STMP口令
        props.put("mail.password", "pyfuiogqhnzobccd");
        
        Session session = Session.getInstance(props, new Authenticator(){
        	//继承接口方法,配置发送方信息
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("596910450@qq.com", "pyfuiogqhnzobccd");
			}
        });
        
        //2.创建邮件对象
        Message message = new MimeMessage(session);
        
        //设置发件人邮箱
        message.setFrom(new InternetAddress("596910450@qq.com"));
        //设置收件人:第一个参数是发送类型,第二个为地址
        message.addRecipient(RecipientType.TO, new InternetAddress(to));
        //设置标题
        message.setSubject("来自宠物电子商城的注册激活邮件");
        //设置邮件正文
		message.setContent("<h1>这是一封激活邮件!点下面链接完成激活操作!</h1><h3><a href='http://192.168.0.2:8080/pets-web/user/activate?code="+code+"'>http://192.168.0.2:8080/pets-web/user/activate?code="+code+"</a></h3>", "text/html;charset=UTF-8");
        
        //3.Transport对象发送
		Transport.send(message);
	}
	
	/** 
     * 精确乘法 
     */  
    public static double mul(double value1, double value2) {  
        BigDecimal b1 = BigDecimal.valueOf(value1);  
        BigDecimal b2 = BigDecimal.valueOf(value2);  
        return b1.multiply(b2).doubleValue();  
    } 
    /** 
     * 精确加法 
     */  
    public static double add(double value1, double value2) {  
        BigDecimal b1 = BigDecimal.valueOf(value1);  
        BigDecimal b2 = BigDecimal.valueOf(value2);  
        return b1.add(b2).doubleValue();  
    }  
  
    /** 
     * 精确减法 
     */  
    public static double sub(double value1, double value2) {  
        BigDecimal b1 = BigDecimal.valueOf(value1);  
        BigDecimal b2 = BigDecimal.valueOf(value2);  
        return b1.subtract(b2).doubleValue();  
    }  
    
    /** 
     * 精确除法 使用默认精度 
     */  
    public static double div(double value1, double value2) throws IllegalAccessException {  
        return div(value1, value2, DEF_DIV_SCALE);  
    }  
  
    /** 
     * 精确除法 
     * @param scale 精度 
     */  
    public static double div(double value1, double value2, int scale) throws IllegalAccessException {  
        if(scale < 0) {  
            throw new IllegalAccessException("精确度不能小于0");  
        }  
        BigDecimal b1 = BigDecimal.valueOf(value1);  
        BigDecimal b2 = BigDecimal.valueOf(value2);  
        // return b1.divide(b2, scale).doubleValue();  
        return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();  
    }  
    
    public static boolean isListEmpty(List list){
    	if(list!=null && !list.isEmpty()){
			return false;//不为空的情况
		}else{
			return true;//为空的情况
		}
    }
    
    /**  
    * @Title: separateToList  
    * @Description: TODO
    * @param @param str
    * @param @param separator 分隔符
    * @param @return    
    * @return List 
    * @throws  
    */ 
    public static List separateToList(String str, String separator){
    	List list = Arrays.asList(str.split(separator));
    	return list;
    }
	
    /**  
    * @Title: isEmpty  
    * @Description: 判断对象是否为空
    * @param @param obj
    * @param @return    
    * @return boolean 
    * @throws  
    */ 
    public static boolean isEmpty(Object obj)  
    {  
        if (obj == null)  
        {  
            return true;  
        }  
        if ((obj instanceof List))  
        {  
            return ((List) obj).size() == 0;  
        }  
        if ((obj instanceof String))  
        {  
            return ((String) obj).trim().equals("");  
        }  
        return false;  
    }  
    
    /**  
    * @Title: isNotEmpty  
    * @Description: 判断是否不为空
    * @param @param object
    * @param @return    
    * @return boolean 
    * @throws  
    */ 
    public static boolean isNotEmpty(Object obj){
    	return !isEmpty(obj);
    }
	
    
}
