$(document).ready(function(){
  $('.sign-in-form').submit(function(e){
    signin();
    e.preventDefault();
  });
  $('.sign-up-form').submit(function(e){
    signup();
    e.preventDefault();
  });
  $('.post-form').submit(function(e){
    post();
    e.preventDefault();
  })
})
//SIGNUP
function signup(){
  $.ajax({
     url: 'http://localhost:4000/api/users',
     type: 'POST',
     data: {
       user: {
         firstname: $('.firstname').val(),
         lastname:  $('.lastname').val(),
         email: $('.email').val(),
         username: $('.username').val(),
         password: $('.password').val(),
       }
      },
     success: function(res) {
       console.log('s',res);
     },
     error : function(res) {
       console.log('e',res);
     }
       });
}
//SIGNIN
function signin(){
  $.ajax({
    url: 'http://localhost:4000/api/login',
    type: 'POST',
    data: {
        username: $('.username').val(),
        password: $('.password').val()
    },
    success: function(res){
      console.log('Success',res);
        location.href = 'homepage.html';
        localStorage.setItem("posts", res.data.posts);
        console.log(localStorage.getItem("posts"));
        localStorage.setItem("token", res.data.meta.token);
        localStorage.setItem("username", res.data.username);
    },
    error : function(res){
      console.log('Error',res);
    }

  });
}
//HOMEPAGE
function post(){
  $.ajax({
    url: 'http://localhost:4000/api/posts',
    headers: {
       "Authorization":"Bearer "+localStorage.getItem("token")
    },
    type: 'POST',
    data: {
      post: {
        body:$('.post').val()
      }
    },
    success: function(res){
      console.log('S');
    },
    error: function(res){
      console.log('E');
    }
  });
}
//POSTS
function show(){
  $.ajax({
      url: 'http://localhost:4000/api/newsfeed',
      headers: {
         "Authorization":"Bearer "+localStorage.getItem("token")
      },
      type: 'GET',
      success: function(res){
        set_posts(res);
      },
      error: function(res){
        console.log(res);
      }
  });
}
function set_posts(res){

  $.each(res.data, function(i, d){  
      $('.af').append('<h3 class="'+d.id+'">'+ "Date Created: "+ d.inserted_at + "<br>" + d.body +'</h3>');
     });
}
