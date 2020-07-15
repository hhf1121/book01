package tools;

import org.springframework.core.convert.converter.Converter;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;


public class myConversion implements Converter<String, Date> {
    @Override
    public Date convert(String source) {
        String replace = source.replace("T", " ");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US);
        Date date = null;
        try {
            date =sdf.parse(replace);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return date;
    }
}
