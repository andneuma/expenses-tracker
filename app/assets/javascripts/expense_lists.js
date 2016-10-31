$(document).ready(function(){
  // Top scroller
  $(window).scroll(function () {
    if ($(this).scrollTop() > 50) {
      $('#scroll-to-top').fadeIn();
    } else {
      $('#scroll-to-top').fadeOut();
    }
  });

  $('#scroll-to-top').click(function () {
    $('body, html').animate({
      scrollTop: 0
    }, 400);
    return false;
  });


  // Bottom scroller
  var bottom = $(window).height();
  $(window).scroll(function () {
    if ($(this).scrollTop() > bottom * 0.8) {
      $('#scroll-to-bottom').fadeOut();
    } else {
      $('#scroll-to-bottom').fadeIn();
    }
  });

  $('#scroll-to-bottom').click(function () {
    $('body, html').animate({
      scrollTop: bottom
    }, 400);
    return false;
  });

});
