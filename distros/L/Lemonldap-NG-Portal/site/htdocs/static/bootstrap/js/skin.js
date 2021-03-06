$(window).on("load", function() {

  // Adapt some class to fit Bootstrap theme
  $("div.message-positive").addClass("alert-success");
  $("div.message-warning").addClass("alert-warning");
  $("div.message-negative").addClass("alert-danger");

  $("table.info").addClass("table");

  $(".notifCheck").addClass("checkbox");

  // Collapse menu on click
  $('.collapse li[class!="dropdown"]').on('click', function() {
    if (!$('.navbar-toggler').hasClass('collapsed')) {
      $(".navbar-toggler").trigger("click");
    }
  });

  // Remember selected tab
  $('#authMenu .nav-link').on('click', function (e) {
      window.datas.choicetab = e.target.hash.substr(1)
  });

});
