import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.redis.core.RedisTemplate;

import cn.hqb.pets.comm.RedisManager;
import cn.hqb.pets.service.test.TestServiceImpl;

public class TestClass {
	public static RedisManager redisManager = null;
	public static RedisTemplate<String, Object> redisTemplate = null;
	static {
		ApplicationContext context = 
		        new ClassPathXmlApplicationContext("classpath:spring/applicationContext-redis.xml");
		redisManager = (RedisManager)context.getBean("redisManager");
		redisTemplate = (RedisTemplate)context.getBean("redisTemplate");
	}
	Integer num = 1;
    public static void main(String[] args) {
        // 创建一个线程池（一个军队）
        ExecutorService service = Executors.newCachedThreadPool();
        // 坏蛋指令，默认为1，变为0时，执行命令
        final CountDownLatch cdOrder = new CountDownLatch(1);
        //小黄人数量
        final int soilder_count = 500;

        // n个小黄人，一个小黄人执行完任务，cdAnswer减1，n个小黄人执行完毕，cdAnswer为0
        final CountDownLatch cdAnswer = new CountDownLatch(soilder_count);

        for (int i = 0; i < soilder_count; i++) {
            Runnable runnable = new Runnable() {
                public void run() {
                    System.out.println("小黄人 : " + Thread.currentThread().getName() + " 准备好了.");
                    try {
                        cdOrder.await();//等着坏蛋发出指令
                        Lock lock = new ReentrantLock();
                		lock.lock();
                		try{
                			int num2 = 1;
                			if(redisManager.hasKey("aaa")){
                				num2 = (int)redisManager.get("aaa");
                			} 
                			num2++;
                			redisManager.set("aaa", num2);
                			System.out.println("num2:" + num2);
                		} catch(Exception e) {
                			e.printStackTrace();
                		} finally {
                			lock.unlock();
                			System.out.println(Thread.currentThread().getName() + "-lockEnd");
                		}
                        //执行完毕，告诉大坏蛋。
                        System.out.println("小黄人 : " + Thread.currentThread().getName() + " 告诉大坏蛋，任务完成.");

                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    } finally {
                        //执行一个减少一次
                        cdAnswer.countDown();
                    }

                }
            };

            service.execute(runnable);// 往执行军队里加派小黄人
        }

        try {
            System.out.println("10秒后爆发.....");
            Thread.sleep((long) (Math.random() * 10000));

            //发布指令，等待他们执行完
            System.out.println("大坏蛋 : " + Thread.currentThread().getName() + " 发布指令了，快去执行，等你们消息");

            cdOrder.countDown();// 发送指令“小黄人出动！”

            cdAnswer.await(); // 大坏蛋等着小黄人回来

            //收到所有完成的反馈
            System.out.println("大坏蛋 : " + Thread.currentThread().getName() + " 任务都完成了，收到了所有的反馈.");

        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        service.shutdown(); 
    }

    
    public static void test(){
		Lock lock = new ReentrantLock();
		lock.lock();
		try{
			Integer num2 = 1;
			if(redisManager.hasKey("aaa")){
				num2 = (Integer)redisManager.get("aaa");
			} 
			num2++;
			redisManager.set("aaa", num2);
			System.out.println("num2:" + num2);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			lock.unlock();
			System.out.println("lockEnd");
		}
	}

}
