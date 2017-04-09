package global.sesoc.project2.msm.util;

import java.text.ParseException;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class AlarmCronTrigger {
	
	Logger log = LoggerFactory.getLogger(AlarmCronTrigger.class);
	
	Scheduler scheduler;
	
	private String time = "0/5 24-25 23 * * ? 3000";
	private String name = "myName";
	private String group = "msm";
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public AlarmCronTrigger(String time, String name) {
		this.time = time;
		this.name = name;
		
		SchedulerFactory schedFact = new org.quartz.impl.StdSchedulerFactory();
		try {
			scheduler = schedFact.getScheduler();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	public AlarmCronTrigger() {}
	
	public void createJob() {
		log.debug("createJob \n group: {}, name: {}, time: {}", group, name, time);
        try {
            JobDetail details = JobBuilder.newJob(AlarmJob.class)
                    .withDescription("something")
                    .withIdentity(name, group)
                    .storeDurably(true).build();

            CronTriggerImpl trigger = new CronTriggerImpl();
            trigger.setName("MSM_ALARM");

            try {
                trigger.setCronExpression(time);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            trigger.setDescription("desc");
            scheduler.scheduleJob(details,trigger);
            scheduler.start();
            log.debug("job started");
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
	}
	
	public void deleteJob() {
		log.debug("deleteJob \n group: {}, name: {}", group, name);
		try {
			scheduler.deleteJob(JobKey.jobKey(name, group));
			log.debug("job deleted");
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
}