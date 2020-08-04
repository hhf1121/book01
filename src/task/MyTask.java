package task;

import com.dangdang.ddframe.job.api.ShardingContext;
import com.dangdang.ddframe.job.api.simple.SimpleJob;
import com.google.common.collect.Lists;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 简单任务
 */
public class MyTask implements SimpleJob {

    List<Boolean> lists= Lists.newArrayList(false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false);

    @Override
    public void execute(ShardingContext shardingContext) {
//        System.out.println("分片:"+shardingContext.getShardingItem());
        System.out.println("----------elastic-job执行----------"+ LocalDateTime.now());
//        List<Boolean> result=Lists.newArrayList();
//        for (Boolean list : lists) {
//            System.out.println("源数据:"+lists);
//            if(result.size()==lists.size()){
//                break;
//            }
//            list=true;
//            result.add(list);
//            System.out.println("结果："+result);
//            try {
//                Thread.sleep(500);
//            } catch (InterruptedException e) {
//
//            }
//        }
    }
}
