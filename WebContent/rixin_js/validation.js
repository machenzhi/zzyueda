/**
 * form表单验证js文件：包括必填验证、数字验证、小数位验证（两种情况）、长度验证、邮箱验证、手机验证、电话验证、输入唯一验证、身份证格式验证。
 */
$(function() {
	myRequiredCheck();
	$("input").blur(myFieldCheck).keyup(function() {
		$(this).triggerHandler("blur");
	}).focus(function() {
		$(this).triggerHandler("blur");
	});
	$("textarea").blur(myFieldCheck).keyup(function() {
		$(this).triggerHandler("blur");
	}).focus(function() {
		$(this).triggerHandler("blur");
	});
})

/**
 * 表单域验证
 */
function myFieldCheck() {
	myRequiredCheck();
	var parent = $(this).parent();
	parent.find(".formtips").remove();
	$(this).removeClass("am-field-error");
	$(this).removeClass("onError");

	/**
	 * 长度验证：minLength="n" maxLength="n" 描述：minLength 为至少输入的长度，maxLength
	 * 为最大输入数（超过会输不进去） 示例：<input type="text" minLength="3" maxLength="6"/>
	 * 提示错误信息：errorMsg=“xxx”，如果不写默认有为“至多输入n位”或至少输入n位 或者 请输入 n-n 位
	 */
	var minLength = $(this).attr('minLength');
	var maxLength = $(this).attr('maxLength');
	if (this.value != "" && maxLength != undefined && minLength != undefined) {
		if (this.value.length < minLength || this.value.length > maxLength) {
			$(this).addClass('am-field-error');
			$(this).addClass("onError");
			var errorMsg = '<font color="#DD514C">请输入' + minLength + "-"
					+ maxLength + '位</font>';
			parent.find(".formtips").remove();
			parent.append('<span class="formtips onError">' + errorMsg
					+ '</span>');
		}
	} else if (this.value != "" && maxLength != undefined) {
		if (this.value.length > maxLength) {
			$(this).addClass("am-field-error");
			$(this).addClass("onError");
			var errorMsg = '<font color="#DD514C">最多输入' + maxLength
					+ '位</font>';
			parent.find(".formtips").remove();
			parent.append('<span class="formtips onError">' + errorMsg
					+ '</span>');
		}
	} else if (this.value != "" && minLength != undefined) {
		if (this.value.length < minLength) {
			$(this).addClass("am-field-error");
			$(this).addClass("onError");
			var errorMsg = '<font color="#DD514C">至少输入' + minLength
					+ '位</font>';
			parent.find(".formtips").remove();
			parent.append('<span class="formtips onError">' + errorMsg
					+ '</span>');
		}
	}

	/**
	 * 浮点数验证：decimal="n" 描述：n为需要保留的小数位，并且会自动在末尾补足“0” ，不会四舍五入。 示例：<input
	 * type="text" decimal="2"/> 提示错误信息：errorMsg=“xxx”，如果不写默认为“请保留n位小数”
	 */
	if ($(this).attr('decimal') != undefined) {
		var decimalLength = $(this).attr('decimal');
		var value = this.value;
		if (value != "" && /^\d+$/.test(this.value)) {
			if (value.indexOf(".") < 0) {
				value = value + ".";
				for (var i = 0; i < decimalLength; i++) {
					value += "0";
				}
				this.value = value;
			}
			this.setSelectionRange(value.length - 3, value.length - 3);
			this.focus();
			/*
			 * var range=inp.createTextRange(); //选中文本的起始位置（从第3个字符之后开始）
			 * range.("character",1); //选中文本的结束位置（到全部字符的倒第3个之前）
			 * range.moveEnd("character",-3); //选中 range.select();
			 */
		}
		var reg = new RegExp("^\\d+\\.\\d{" + decimalLength + "}$");
		if (value != "" && !reg.test(this.value)) {
			$(this).addClass("am-field-error");
			$(this).addClass("onError");
			var errorMsg = '<font color="#DD514C">请填入合法数字，并保留' + decimalLength
					+ '位小数</font>';
			parent.find(".formtips").remove();
			parent.append('<span class="formtips onError">' + errorMsg
					+ '</span>');
		}
	}

	/**
	 * 浮点数验证：maxDecimal="n" 描述：n为最多输入的的小数位 0-n 位之间都可以，不会四舍五入 示例：<input
	 * type="text" maxDecimal="2"/> 提示错误信息：errorMsg=“xxx”，如果不写默认为“请保留1-n位小数”
	 */
	if ($(this).attr('maxDecimal') != undefined) {
		var decimalLength = $(this).attr('maxDecimal');
		var reg = new RegExp("^\\d+\\.\\d{1," + decimalLength + "}$");
		if (this.value != "" && !reg.test(this.value)) {
			$(this).addClass("am-field-error");
			$(this).addClass("onError");
			var errorMsg = '<font color="#DD514C">请保留1-' + decimalLength
					+ '位小数</font>';
			parent.find(".formtips").remove();
			parent.append('<span class="formtips onError">' + errorMsg
					+ '</span>');
		}
	}

	if ($(this).attr('validatetype') != undefined) {

		/**
		 * 验证身份证：card 描述：身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
		 * 示例：<input type="text" validatetype="card"/>
		 * 提示错误信息：errorMsg=“xxx”，如果不写默认为“请输入正确的身份证号”
		 */
		if ($(this).attr('validatetype').indexOf('card') > -1) {
			var validatetype = $(this).attr('validatetype');
			var errorMsg = "";// 错误提示信息
			if (validatetype.indexOf('||') > -1) {
				var validatetypes = validatetype.split("||");
				validatetype = validatetypes[0];
				errorMsg = validatetypes[1];
			}
			if (this.value != ""
					&& !/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(this.value)) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">请输入正确的身份证号<font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}

		/**
		 * 数字验证：validatetype="number" 只能输入整数包括 负整数（如：-11）、0、正整数。 示例：<input
		 * type="text" validatetype="number"/>
		 * 提示错误信息：errorMsg=“xxx”，如果不写默认为“请输入数字”
		 */
		if ($(this).attr('validatetype').indexOf('number') > -1) {
			var validatetype = $(this).attr('validatetype');
			var errorMsg = "";// 错误提示信息
			if (validatetype.indexOf('||') > -1) {
				var validatetypes = validatetype.split("||");
				validatetype = validatetypes[0];
				errorMsg = validatetypes[1];
			}
			if (this.value != "" && !/^-?\d+$/.test(this.value)) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">请输入数字<font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}

		/**
		 * 邮箱验证：validatetype="email" 描述：务必输入正确的邮箱格式sd52@qq.com 示例：<input
		 * type="text" validatetype="email"/>
		 * 提示错误信息：errorMsg=“xxx”，如果不写默认有为"请输入正确的E-Mail地址"
		 */
		if ($(this).attr('validatetype').indexOf('email') > -1) {
			var validatetype = $(this).attr('validatetype');
			var errorMsg = "";// 错误提示信息
			if (validatetype.indexOf('||') > -1) {
				var validatetypes = validatetype.split("||");
				validatetype = validatetypes[0];
				errorMsg = validatetypes[1];
			}
			if (this.value != "" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value)) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">请输入正确的E-Mail地址<font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}

		/**
		 * 手机验证：validatetype="mobilephone" 描述：目前手机号为1开始，3/5/8位第二位 位数为11的纯数字号码
		 * 示例：<input type="text" validatetype="mobilephone"/>
		 * 提示错误信息：errorMsg=“xxx”，如果不写默认有为"请输入正确的手机号"
		 */
		if ($(this).attr('validatetype').indexOf('mobilephone') > -1) {
			$(this).attr("maxlength", "11");
			var validatetype = $(this).attr('validatetype');
			var errorMsg = "";// 错误提示信息
			if (validatetype.indexOf('||') > -1) {
				var validatetypes = validatetype.split("||");
				validatetype = validatetypes[0];
				errorMsg = validatetypes[1];
			}
			if (this.value != ""
					&& !/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
							.test(this.value)) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">请输入正确的手机号</font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}

		/**
		 * 电话验证：validatetype="telephone" 描述：格式如：：010/0371-88888888，区号可以为3或者4位
		 * 示例：<input type="text" validatetype="telephone"/>
		 * 提示错误信息：errorMsg=“xxx”，如果不写默认有为"请输入正确的电话格式"
		 */
		if ($(this).attr('validatetype').indexOf('telephone') > -1) {
			var validatetype = $(this).attr('validatetype');
			var errorMsg = "";// 错误提示信息
			if (validatetype.indexOf('||') > -1) {
				var validatetypes = validatetype.split("||");
				validatetype = validatetypes[0];
				errorMsg = validatetypes[1];
			}
			if (this.value != ""
					&& !/^(\d{3}-|\d{4}-)(\d{8}|\d{7})$/.test(this.value)) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">请输入正确的电话格式如：010-88888888</font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}
	}

	/**
	 * 输入框内容需要一致时，定义valueSameTo属性。
	 * 主输入框设置valueSameTo="password:main"，别的输入框设置valueSameTo="password:other"或者valueSameTo="password:other||两次填写的密码不一致"
	 * 注：冒号前的值password可以自定义，只要保持前后一致即可。如：valueSameTo="1:main"和valueSameTo="1:other"
	 */
	if ($(this).attr('valueSameTo') != undefined) {
		var thisValue = $(this).val();// 当前值
		var valueSameTo = $(this).attr('valueSameTo');
		var errorMsg = "";// 错误提示信息
		if (valueSameTo.indexOf(':main') > -1) {
			var valueSameTos = valueSameTo.split(":");
			other = valueSameTos[0];
			// 选择所有的valueSameTo属性以变量target+字符串":other"开头的input元素
			$("body :input[valueSameTo^='" + other + ":other']")
					.each(
							function() {
								var tempObj = $(this);
								var tempObjValue = tempObj.val();// 目标值
								var tempObjValueSameTo = tempObj
										.attr('valueSameTo');
								var tempObjParent = tempObj.parent();
								if (tempObjValueSameTo.indexOf('||') > -1) {
									var tempObjValueSameTos = tempObjValueSameTo
											.split("||");
									tempObjValueSameTo = tempObjValueSameTos[0];
									errorMsg = tempObjValueSameTos[1];
								}
								if (tempObjValue != ""
										&& thisValue != tempObjValue) {
									tempObj.addClass("am-field-error");
									tempObj.addClass("onError");
									if (errorMsg != "") {
										errorMsg = '<font color="#DD514C">'
												+ errorMsg + '</font>';
									} else {
										errorMsg = '<font color="#DD514C">两次输入的内容不一致</font>';
									}
									tempObjParent.find(".formtips").remove();
									tempObjParent
											.append('<span class="formtips onError">'
													+ errorMsg + '</span>');
								} else {
									tempObjParent.find(".formtips").remove();
									tempObj.removeClass("am-field-error");
									tempObj.removeClass("onError");
								}
							});
		}
		if (valueSameTo.indexOf(':other') > -1) {
			var valueSameTos = valueSameTo.split(":");
			// 选择所有的valueSameTo属性等于变量target+字符串":main"的input元素
			var mainObj = $("body :input[valueSameTo='" + valueSameTos[0]
					+ ":main']");
			var mainObjValue = mainObj.val();// 目标值
			if (valueSameTo.indexOf('||') > -1) {
				var valueSameTos = valueSameTo.split("||");
				valueSameTo = valueSameTos[0];
				errorMsg = valueSameTos[1];
			}
			if (mainObjValue != "" && thisValue != mainObjValue) {
				$(this).addClass("am-field-error");
				$(this).addClass("onError");
				if (errorMsg != "") {
					errorMsg = '<font color="#DD514C">' + errorMsg + '</font>';
				} else {
					errorMsg = '<font color="#DD514C">两次输入的内容不一致</font>';
				}
				parent.find(".formtips").remove();
				parent.append('<span class="formtips onError">' + errorMsg
						+ '</span>');
			}
		}
	}
}

/**
 * 表单验证
 */
function myRequiredCheck() {
	/**
	 * 必填验证：required 描述：如果是必填添加 required 示例：<input type="text" required/>
	 */
	$("body :input[required]").each(
			function() {
				var parent = $(this).parent();
				if ($(this).val().trim() == ""
						|| parent.html().indexOf('formtips onError') > -1) {
					$(this).addClass("am-field-error");
					$(this).addClass("onError");
				} else {
					$(this).removeClass("am-field-error");
					$(this).removeClass("onError");
				}
			});
}

function isExist() {
	$("input[isExist]")
			.each(
					function() {
						var parent = $(this).parent();
						var errorMsg = "";// 错误提示信息
						var obj = $(this);
						var url = obj.attr('isExist');
						if (url.indexOf('||') > -1) {
							var urls = url.split("||");
							url = urls[0];
							errorMsg = urls[1];
						}
						var objValue = $(this).val();
						var data = {}, name = obj.attr('name');
						data[name] = objValue;
						defaultValue = obj.attr('defaultValue');// 修改前的值
						if (defaultValue != objValue) {
							if (objValue != "") {
								$
										.ajax({
											url : url,
											data : data,
											type : "POST",
											async : false,// false为同步请求
											success : function(data) {
												if (data) {
													$(this).addClass(
															"am-field-error");
													$(this).addClass("onError");
													if (errorMsg != "") {
														errorMsg = '<font color="#DD514C">'
																+ errorMsg
																+ '</font>';
													} else {
														errorMsg = '<font color="#DD514C">该内容已存在，请更换。<font>';
													}
													parent.find(".formtips")
															.remove();
													parent
															.append('<span class="formtips onError">'
																	+ errorMsg
																	+ '</span>');
												}
											}
										});
							}
						}
					});
}

function formValidate() {
	myRequiredCheck();
	isExist();
	var numError = $('body .onError').length;
	if (numError > 0) {
		alert("你好，信息录入有误，不能保存。\n\n说明：红色输入框内为必填内容");
		return false;
	}
	return true;
}