<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {

        response.sendRedirect("login_page.jsp");

    }


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"><!-- comment -->
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path : polygon(30% 0%, 100% 0, 100% 30%, 100% 96%, 62% 89%, 30% 98%, 0 91%, 0 0);
            }
            body{
                background: url(img/photo-bg.jpeg);
                background-size:cover;
                background-attachment: fixed;


            }
        </style>



    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"><span class="fa fa-bell"></span> Home<span class="sr-only">(current)</span></a>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span>

                            Content
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Projects implemation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data structures</a>
                        </div>

                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about_us_page.html"> <span class="fa fa-address-book-o"></span>  Contact Us</a>
                    </li>  

                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-sticky-note"></span>  Add Post</a>
                    </li>




                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user"></span> <%= user.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fa fa-sign-in"></span> Log Out</a>
                    </li>

                </ul>



                </form>
            </div>
        </nav>







        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%=m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>      

        <!--Main body -->
        <main>
            <div class="container-fluid">
                <div class="row mt-3 mx-2">
                    <div class="col-md-2">
                        <div class="list-group mt-4">
                            <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">
                                All Posts
                            </a>
                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();
                                for (Category cc : list1) {


                            %>
                            <a href="#" onclick="getPosts(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                            <%
                                }
                            %>

                        </div> 
                    </div>
                    <div class="col-md-10" >
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin" ></i>
                            <h3 class="mt-2">Loading ....</h3>
                        </div>
                        <div class="container-fluid" id="post-container">
                        </div>
                    </div>

                </div>
            </div>
        </main>
        <!-- Modal -->





        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center ">
                        <h5 class="modal-title" id="exampleModalLabel">Welcome to TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 150px;;">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID:</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email:</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender:</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Status:</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID:</td>
                                            <td>
                                                <%= user.getId()%>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Email:</td>
                                            <td>
                                                <input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Name:</td>
                                            <td>
                                                <input type="text" class="form-control" name="user_name" value="<%=user.getName()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Password:</td>
                                            <td>
                                                <input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Gender:</td>
                                            <td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>About:</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about">
                                                    <%=user.getAbout()%> 
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile:</td>
                                            <td>

                                                <input type="file" class="form-control" name="image" value="<%=user.getProfile()%>">

                                            </td>
                                        </tr>

                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                </form>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>













    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="AddPostServlet" method="post">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>Select Category</option>

                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCategories();
                                    for (Category c : list) {


                                %>
                                <option value="<%=c.getCid()%>"><%=c.getName()%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>



                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <textarea name="pContent" class="form-control" style="height:150px" placeholder="Enter your Content"></textarea>

                        </div>
                        <div class="form-group">
                            <textarea name="pCode" class="form-control" style="height:150px" placeholder="Enter your Program(if any)"></textarea>

                        </div>
                        <div class="form-contrl">
                            <label>Select your Photo</label>
                            <br>
                            <input type="file" name="pic">
                        </div>

                        <div class="container text-center">
                            <button type="submit" class="btn btn-outline-primary">post</button>
                    </form> 
                </div>


            </div>
        </div>
    </div>
</div>









<!-- Modal -->
<div class="modal fade" id="add-cat-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Category For Blogs</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="add-cat-form"  action="AddCatServlet" method="post">
                    <div class="form-group">
                        <select class="form-control" name="cid">
                            <option selected disabled>Check Category</option>

                            <%
                                PostDao postd2 = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list2 = postd2.getAllCategories();
                                for (Category c : list2) {


                            %>
                            <option  value="<%=c.getCid()%>"><%=c.getName()%></option>

                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Category not Present Add your Content Category</label>
                        <input name="c1Title" type="text" placeholder="Enter Title" class="form-control">
                    </div>
                    <div class="form-group">
                        <textarea  name ="c1Desc" placeholder="Enter Descrtiption" class="form-control"></textarea>
                    </div>

                    <div class="container text-center" >
                        <button type="submit" class="btn btn-outline-primary">Add</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
















<script
    src="https://code.jquery.com/jquery-3.7.0.min.js"
    integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" 
crossorigin="anonymous"></script>  
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>    
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>        
<script src="js/myjs.js" type="text/javascript"></script> 


<script>

                                let editStatus = false;
                                $(document).ready(function () {
                                    $('#edit-profile-button').click(function () {

                                        if (editStatus == false) {

                                            $('#profile-details').hide()
                                            $('#profile-edit').show();
                                            editStatus = true;
                                            $(this).text("Back")
                                        } else {
                                            $('#profile-details').show()
                                            $('#profile-edit').hide();
                                            editStatus = false;
                                            $(this).text("Edit")

                                        }



                                    })

                                });

</script>
<!-- Add post js -->
<script>
    $(document).ready(function (e) {
        $("#add-post-form").on("submit", function (event) {
            //this code gets called wheen submitted
            event.preventDefault();
            console.log("Yoyu have submit")
            let form = new FormData(this);

            $.ajax({
                url: "AddPostServlet",
                type: 'POST',
                data: form,
                success: function (data, textStaus, jqXHR) {
                    console.log(data)
                    if (data.trim() == 'done') {

                        swal("Good job!", "Saved Successfully!", "success");

                    } else {
                        swal("Error!", "Something Went Wrong!!", "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    swal("Error!", "Something Went Wrong!!", "error");
                },
                processData: false,
                contentType: false
            })


        })



    })
</script>
<script>
    function getPosts(catId, temp) {
        $("#loader").show();
        $("#post-container").hide()
        $(".c-link").removeClass('active')
        $.ajax({
            url: "load_post.jsp",
            data: {cid: catId},
            success: function (data, textStatus, jqXHR) {
                console.log(data);

                $("#loader").hide();

                $("#post-container").show();
                $('#post-container').html(data);
                $(temp).addClass('active')
            }
        })



    }
    $(document).ready(function (e) {
        let allPostRef = $('.c-link')[0]
        getPosts(0, allPostRef)
    })

</script>
<script>
    $(document).ready(function (e) {
        $("#add-cat-form").on("submit", function (event) {
            //this code gets called wheen submitted
            event.preventDefault();
            console.log("You have submit")
            let form = new FormData(this);

            $.ajax({
                url: "AddCatServlet",
                type: 'POST',
                data: form,
                success: function (data, textStaus, jqXHR) {
                    console.log(data)
                    if (data.trim() == 'done') {

                        swal("Good job!", "Saved Successfully!", "success");
                    } else {
                        swal("Error!", "Something Went Wrong!!", "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    swal("Error!", "Something Went Wrong!!", "error");
                },
                processData: false,
                contentType: false
            })


        })



    })



</script>




</body>
</html>
