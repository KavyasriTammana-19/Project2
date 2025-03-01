import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class HelloWorld extends HttpServlet
{
public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
{
response.setContentType("text/html");
PrintWriter pw=response.getWriter();
pw.println("<html>");
pw.println("<head><title>HelloWorld</title></head>");
pw.println("<body>");
pw.println("HelloWorld");
pw.println("</body></html>");
}
}