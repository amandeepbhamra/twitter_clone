jQuery(function(){
  $("textarea.expand").click(function () {
    $(this).animate({ "height" : "100px" }, 500);
	});
});