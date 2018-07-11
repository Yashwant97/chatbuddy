<%-- 
    Document   : messenger
    Created on : Jun 19, 2018, 3:47:57 PM
    Author     : user
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <title>Chat Buddy Messenger</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="index.css">
        <script src="bootstrap/js/jquery-3.2.1.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js" ></script>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store,must-revalidate");
            response.setHeader("Pragma","no-cache");
            response.setHeader("Expires","0");
            
            
          if(session.getAttribute("U_ID")==null)
          {
               response.sendRedirect("index.html");
          } 
        %>
            
        <%@include file="header.jsp" %> 
        <div class="content">
        <div class="container-fluid">
            
            
            <%--CONTACT LIST SIDEPANEL--%>
            <div class="row content-page">
                <div class="col-sm-3 " >
                <div class="collapse navbar-collapse "id="mycontacts" >
                    <div class="side-pane contacts">
                    <br>
                    <br>
                    <table class="table table-responsive table-hover table-striped container side-pane">
                        <thead><td>Chat Buddy List</td></thead>
                        <%!
                            Connection conn=null;
                            Statement stmt=null;
                            ResultSet rs=null;
                            int U_ID=0;
                        %>
                       <%
                           
                           
                           try
                        {
                            U_ID=(int) session.getAttribute("U_ID");
                            Class.forName("com.mysql.jdbc.Driver");
                            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/chatbuddy","root","");
                            stmt=conn.createStatement();
                
                
                            String sql2 = "Select name,userid from chatuser where userid not in('"+U_ID+"')";
                            rs = stmt.executeQuery(sql2);
                
                
                            while(rs.next())
                            {
                                out.print("<tr><td><a href='messenger.jsp?buddy="+rs.getString("userid")+"'>"+rs.getString("name")+"</a></tr></td>");
                                
                            }
                        }
                        catch(Exception e) {
                            request.setAttribute("label",e.getMessage());
                        }
                       %>
                    </table>
                </div>
                </div>
                    
                </div>
                    
                    
                    
                    
                    
                    
                    
                    <%--Message Panel--%>
                    <div class="col-sm-6">
                        <br><br><h1>Welcome To ChatBuddy Messenger</h1>
                        <div class="panel panel-default ">
                            
                            <div class="panel-body">
                                <%--Messages--%>
                                
                                <%  
                                    int R_ID=Integer.parseInt(request.getParameter("buddy"));
                                    session.setAttribute("R_ID", R_ID);
                                    if(R_ID==0)
                                    {
                                        out.println("<h4>Select Your Chat Buddy </h4>");
                                        
                                    }
                                    else{
                                   /* int R_ID=0;
                                    String sqlR_ID="Select userid from chatuser where email='"+Reciever+"'";
                                    rs=stmt.executeQuery(sqlR_ID);
                                    if(rs.next())
                                    {
                                        R_ID=rs.getInt("userid");
                                        
                                    }*/
                                    String Sql="Select * FROM "+U_ID+"_message where R_ID="+R_ID+";";
                                    rs=stmt.executeQuery(Sql);
                                    
                                    while(rs.next())
                                    {
                                        String Sender=rs.getString("Sender");
                                        String Message=rs.getString("Message");
                                        String time=rs.getTimestamp("time").toString();
                                        out.print("<div class='panel panel-default'>"+
                                    "<div class='panel-title'>"+
                                        Sender+
                                    "</div>"+
                                    "<div class='panel-body'>"+
                                        Message+
                                    "</div>"+
                                    "<div class='panel-footer'>"+
                                        time+
                                    "</div>"+
                                    "</div>");
                                        
                                    }}
                                %>
                                
                                
                            </div>
                                
                                <%-- SEND MESSAGE FORM--%>
                            <div class="panel-footer">
                            <div class="message_pane content">
                                
                                <div class="fixed-bottom">
                                    <form action="send" class="form-inline" method="post">
                                        <div class="panel-defaul">
                                            <textarea rows="3"  name="message" class="lead  form-group form-control" placeholder="Type your message here..."></textarea>
                                            <input type="submit" class=" left form-group form-control btn-primary" value="Send">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    
            </div>
                    
        </div>
        </div>
    </body>
</html>
