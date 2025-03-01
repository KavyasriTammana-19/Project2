import java.io.*;
import java.lang.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DisplayingDate extends HttpServlet
{
public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException
{
res.setContentType("text/html");
PrintWriter pw=res.getWriter();
Date date=new Date();
pw.println("<html>");
pw.println("<head><title> Displaying Date </title></head>");
pw.println("<body>");
pw.println("Current date and time: " +date.toString());
pw.println("</body></html>");
}
}