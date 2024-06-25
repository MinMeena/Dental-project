<%@page import="java.io.*,java.sql.*"%>
<%@page session="false"%>
<!DOCTYPE html>
<html>
<body>
<%
                    try
                    {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dental","root","meenaSHREE24$");
                        System.out.println("Connection Established");
                        Statement stmt=con.createStatement();
                        PreparedStatement ps = null;
                        HttpSession session=request.getSession();
                        String uname=request.getParameter("username");
                        String upass=request.getParameter("pass");
                        int count=1;
                        ResultSet rs1=stmt.executeQuery("select * from user where username='" + uname + "'");
                    if(rs1.next()){ 
                        out.println("<meta http-equiv='refresh' content='3;URL=userRegister.html'>");//redirects after 3 seconds
                        out.println("<p style='color:red;'>User already exist!</p>");
                    }
                    else
                    {
                        ResultSet rs=stmt.executeQuery("select count(userid) as count from user");
                        if(rs.next())
                        {
                            count=rs.getInt("count")+1;
                        }
                        
                        String queryString = "INSERT INTO user(userid,username,password) VALUES (?, ?, ?)";
                        ps = con.prepareStatement(queryString);
                        ps.setInt(1,count);
                        ps.setString(2,uname);
                        ps.setString(3,upass);
                        int updateQuery = ps.executeUpdate();
                        response.sendRedirect("userLogin.html");
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