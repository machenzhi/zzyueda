$(function() {
	// 日期控件背景为白色。
	$("body :input[readonly]").each(function() {
		$(this).attr("style", "background:#FFFFFF;cursor:text;");
	});
	// 只读时，控件不可编辑，背景为白色。
	if (viewstate == 'read') {
		$("input").attr("readonly", "disabled").attr("style",
				"background:#FFFFFF;cursor:text;color:#000000;");
		$("textarea").attr("readonly", "disabled").attr("style",
				"background:#FFFFFF;cursor:text;color:#000000;");
		$("select").attr("disabled", "disabled").attr("style",
				"background:#FFFFFF;cursor:text;color:#000000;");
		$("body :input[data-am-datepicker]").each(function() {
			$(this).removeAttr("data-am-datepicker");
		});
		$("body :input[placeholder]").each(function() {
			$(this).removeAttr("placeholder");
		});
	}
});