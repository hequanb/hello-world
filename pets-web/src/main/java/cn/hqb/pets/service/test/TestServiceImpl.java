package cn.hqb.pets.service.test;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hqb.pets.comm.RedisManager;

@Service
public class TestServiceImpl {
	
	int num = 1;
	
	@Autowired
	private RedisManager redisManager;
	
	public void test(){
		Lock lock = new ReentrantLock();
		lock.lock();
		try{
			Integer num2 = 1;
			if(redisManager.hasKey("aaa")){
				num2 = (Integer)redisManager.get("aaa");
			} 
			num2++;
			num++;
			redisManager.set("aaa", num2);
			System.out.println("num:" + num);
			System.out.println("num2:" + num2);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			lock.unlock();
			System.out.println("lockEnd");
		}
	}

}
