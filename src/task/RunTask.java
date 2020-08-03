package task;

import com.dangdang.ddframe.job.config.JobCoreConfiguration;
import com.dangdang.ddframe.job.config.simple.SimpleJobConfiguration;
import com.dangdang.ddframe.job.lite.api.JobScheduler;
import com.dangdang.ddframe.job.lite.config.LiteJobConfiguration;
import com.dangdang.ddframe.job.reg.base.CoordinatorRegistryCenter;
import com.dangdang.ddframe.job.reg.zookeeper.ZookeeperConfiguration;
import com.dangdang.ddframe.job.reg.zookeeper.ZookeeperRegistryCenter;

public class RunTask {

    //创建并初始化zk链接
    public static CoordinatorRegistryCenter initZK(){
        //创建zk链接
        ZookeeperConfiguration zookeeperConfiguration=new ZookeeperConfiguration("127.0.0.1:2181","book-job");
        //超时时间
        zookeeperConfiguration.setSessionTimeoutMilliseconds(500);
        //创建注册中心
        CoordinatorRegistryCenter zookeeperRegistryCenter = new ZookeeperRegistryCenter(zookeeperConfiguration);
        //初始化
        zookeeperRegistryCenter.init();
        return zookeeperRegistryCenter;
    }


    public static void startTask(CoordinatorRegistryCenter zookeeperRegistryCenter){
        //创建：JobCoreConfiguration       任务名，调度表达式，分片数量
        JobCoreConfiguration.Builder jobCoreConfiguration = JobCoreConfiguration.newBuilder("my-task-job", "0/10 * * * * ?", 3);
        //创建：SimpleJobConfiguration      任务配置，任务执行类的完全限定名
        SimpleJobConfiguration simpleJobConfiguration = new SimpleJobConfiguration(jobCoreConfiguration.build(), MyTask.class.getCanonicalName());
        //启动任务
        new JobScheduler(zookeeperRegistryCenter, LiteJobConfiguration.newBuilder(simpleJobConfiguration).overwrite(true).build()).init();
    }


    public static void main(String[] args) throws InterruptedException {
        CoordinatorRegistryCenter coordinatorRegistryCenter = initZK();
//        Thread.sleep(100000);
        startTask(coordinatorRegistryCenter);
    }
}
