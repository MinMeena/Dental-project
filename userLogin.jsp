<%@page import="java.io.*,java.sql.*"%>
<%@page session="false"%>
<!DOCTYPE html>
<html>
<body>
    
<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dental","root","meenaSHREE24$");
        System.out.println("Connection Established");
        String uname=request.getParameter("username");
        String upass=request.getParameter("pass");
        Statement stmt=con.createStatement();
        HttpSession session=request.getSession();
        if(uname.equals("admin")  && upass.equals("123"))
            {   
                session.setAttribute("adid",123);
                out.println("ADMIN");
                
            }
        else
        {
        ResultSet rs=stmt.executeQuery("select * from user");
        int f=0;
        while(rs.next())
        {
            
            String uname1=rs.getString("username");
            String pass1=rs.getString("password");
            
          
            if(uname1!=null && uname1.equals(uname) && pass1.equals(upass))
            {   
                session.setAttribute("uid", rs.getInt("userid"));
                out.println("user login="+rs.getInt("userid"));
                f=1;
            } 
            
        }
        if(f==0)
        {
            response.sendRedirect("login.html");
        }
        }
    
        
    }
    catch(Exception e)
    {
        e.printStackTrace();
        out.println(e);
    }


%>
</body>
</html>