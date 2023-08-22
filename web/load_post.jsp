<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.helper.HelperDot"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class="row mt-4" >
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
            out.println("<h3 text-white class='display-3 text-center'>No posts in this Category..</h3>");
            return;
        }
        //List<Post> posts=d.getAllPosts();
        for (Post p : posts) {
    %>
    <div class="col-md-4 ">
        <div class="card" style="margin: 10px;">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap" style="max-height: 250px;max-width: 100%;width: auto;">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%= HelperDot.get10Words(p.getpContent())%></p>

            </div>
            <div class="card-footer primary-background text-center ">
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read more...</a>
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());


                %>   
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"> </i><span><%= ld.countLikeOnPost(p.getPid())%></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> </i><span>15</span></a>
            </div>
        </div>
    </div>
    <%
        }

    %>
    <script src="js/script.js" type="text/javascript"></script>
</div>