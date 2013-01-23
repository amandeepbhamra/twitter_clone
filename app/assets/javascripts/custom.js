$(function(){
  $("textarea.expand").click(function () {
    $(this).animate({ "height" : "100px" }, 200);
	});
  $(".tweet_btn").click(function () {
    $("textarea.expand").animate({ "height" : "40px" }, 200);
	});
alert("this is alert");
  $("body").ezBgResize({
            img : "/images/bg.jpg", // Required.
        });
});

		