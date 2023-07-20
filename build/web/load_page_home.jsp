<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.helper.HelperDot"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class=" col-md-16">
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card-columns">
    <%

        Thread.sleep(500);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = new ArrayList<>();
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
            out.println("No posts in this Category");
            return;
        }
        //List<Post> posts=d.getAllPosts();
        for (Post p : posts) {
    %>
        <div class="card">
           
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%= HelperDot.get10Words(p.getpContent()) %></p>

            </div>
            <div class="card-footer primary-background text-center ">
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read more...</a>
                <%
                            LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                            
                            
                            
                            %>  
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"> </i><span><%= ld.countLikeOnPost(p.getPid()) %></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> </i><span>15</span></a>
            </div>
        </div>
   
    <%
        }

    %>
     </div>
</div>
</div>
