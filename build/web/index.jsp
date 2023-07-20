
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"  %>
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
                background: url(img/bg.jpg);
                background-size:cover;
                background-attachment: fixed;
                
                
            }
        </style>
    </head>
    <body> 

        <%@include file="normal_navbar.jsp" %>
        <div class="container-fluid p-0 m-0 banner-background">   
            <div class="jumbotron primary-background text-white">
                <div class="container">

                    <h3 class="display-3">Welcome to Tech Blog</h3>

                    <p>
                        A programming language is a system of notation for writing computer programs.[1] Most programming languages are text-based formal languages, but they may also be graphical. They are a kind of computer language.
                    </p>
                    <p>
                        A programming language is a system of notation for writing computer programs.[1] Most programming languages are text-based formal languages, but they may also be graphical. They are a kind of computer language.
                    </p>
                    <button class="btn btn-outline-light btn-lg"> <span class="	fa fa-share-square-o"></span>  Start ! its Free</button>
                    <a href="login_page.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-user-circle-o fa-spin"></span>  Login</a>

                </div>
            </div>

        </div>
        <div class="container text-center bg-photo">
           <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin" ></i>
                            <h3 class="mt-2">Loading ....</h3>
                        </div>
                        <div class="container-fluid" id="post-container">
                        </div>
                        </div>
                
             


        

        <script
            src="https://code.jquery.com/jquery-3.7.0.min.js"
            integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" 
        crossorigin="anonymous"></script>  
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>    
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
    function getPosts(catId, temp) {
        $("#loader").show();
        $("#post-container").hide()
        $(".c-link").removeClass('active')
        $.ajax({
            url: "load_page_home.jsp",
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


    </body>
</html>
