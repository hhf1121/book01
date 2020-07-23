package tools;

import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;


public class myConversion implements Converter<String, Date> {
    @Override
    public Date convert(String source) {
        String replace="";
        SimpleDateFormat sdf=new SimpleDateFormat();
        if(!StringUtils.isEmpty(source)){
            if(source.indexOf("T")!=-1){
                 replace = source.replace("T", " ");
                 sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US);
            }
            //07/31/2020
            if(source.indexOf("/")!=-1){
                String[] split = source.split("/");
                replace = split[2]+"-"+split[0]+"-"+split[1];
                sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
            }
        }
        Date date = null;
        try {
            date =sdf.parse(replace);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return date;
    }
}
