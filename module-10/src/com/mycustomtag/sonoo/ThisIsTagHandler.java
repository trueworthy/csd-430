// Example based on tutorial from Naukri.com Code360
// Source: https://www.naukri.com/code360/library/jsp-custom-tags
// Accessed on: July 14, 2025

package com.mycustomtag.sonoo;  
import java.util.Calendar;  
import javax.servlet.jsp.JspException;  
import javax.servlet.jsp.JspWriter;  
import javax.servlet.jsp.tagext.TagSupport;  

public class ThisIsTagHandler extends TagSupport {  
    public int doStartTag() throws JspException {  
        JspWriter out = pageContext.getOut();  
        try {  
            out.print(Calendar.getInstance().getTime());  
        } catch(Exception e) {  
            System.out.println(e);  
        }  
        return SKIP_BODY;  
    }  
}
