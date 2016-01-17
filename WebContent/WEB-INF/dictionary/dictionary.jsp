<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#r_close a:hover {
	background-color: #D44027;
}
</style>
<div class="admin-content">
	<!-- sidebar start -->
	<div class="admin-sidebar">
		<div class="am-panel am-panel-default" style="border-style: none;">
			<div class="am-panel-hd">菜单</div>
			<div class="am-panel-bd" style="padding: 0px;">
				<ul id="zTree" class="ztree"></ul>
			</div>
		</div>
	</div>
	<!-- sidebar end -->

	<!-- 树的右键菜单 -->
	<div id="rMenu">
		<ul>
			<li id="m_add" onclick="addTreeNode();"><span> <i
					class="am-icon-plus"></i>新增
			</span></li>
			<li id="m_edit" onclick="editTreeNode();"><span> <i
					class="am-icon-pencil"></i>修改
			</span></li>
			<li id="m_del" onclick="removeTreeNode();"><span> <i
					class="am-icon-trash-o"></i>删除
			</span></li>
		</ul>
	</div>
	<!-- 树的右键菜单 结束 -->
	<!-- *************弹出模态窗********************** -->
	<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
		<div class="am-modal-dialog" style="width: 800px;">
			<div style="background-color: #5F8FDC; height: 35px;">
				<div class="am-fl">
					<h5 id="modal_hd" class="am-panel-title"
						style="cursor: default; color: #FFFFFF; line-height: 35px; margin-left: 10px;"></h5>
				</div>
				<div class="am-fr" id="r_close">
					<a class="am-icon-close" data-am-modal-cancel
						style="cursor: default; color: #FFFFFF; width: 40px; height: 35px; padding: 10px;"
						title="关闭"></a>
				</div>
			</div>
			<div class="am-modal-bd"
				style="padding-left: 100px; padding-right: 100px;">
				<form class="am-form" type="post" id="myForm">
					<br>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">导航名称：</div>
						<div class="am-u-sm-7 am-u-end">
							<input type="text" id="name" name="name" class="am-form-field"
								placeholder="请输入名称">
						</div>
						<br>
						<label id="name_lab"></label>
					</div>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">导航样式：</div>
						<div class="am-u-sm-7 am-u-end">
							<select id="css" name="css">
								<option value="wu">无下级菜单</option>
								<option value="wenben">单列下级菜单</option>
								<option value="kuai">多列下级菜单</option>
							</select>
						</div>
					</div>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">内容模版：</div>
						<div class="am-u-sm-7 am-u-end">
							<select id="url" name="url">
								<option value="news/qiantai/getNewsList.do?demo=1">文章列表模版</option>
								<option value="news/qiantai/getNewsContent.do?demo=1">文章详情模版</option>
								<option
									value="news/qiantai/getNewsContentWithTitleMenu.do?demo=1">文章详情模板（带文章标题菜单）</option>
								<option value="news/qiantai/getNewsImgList.do?demo=1">图片列表模版</option>
								<option value="news/qiantai/getMain.do?demo=1">首页模版</option>
							</select>
						</div>
					</div>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">是否显示：</div>
						<div class="am-u-sm-7 am-u-end">
							<input type="text" id="visible" name="visible"
								class="am-form-field" placeholder="请输入yes或no">
						</div>
					</div>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">顺序：</div>
						<div class="am-u-sm-7 am-u-end">
							<input type="text" id="sort" name="sort" class="am-form-field"
								placeholder="请输入数字">
						</div>
						<br>
						<label id="sort_lab"></label>
					</div>
					<div class="am-g am-margin-top-sm">
						<div class="am-u-sm-3 am-text-right">是否信息类型：</div>
						<div class="am-u-sm-7 am-u-end am-text-left">
							<input type="radio" id="yes" name="isinfo" value="yes">是
							&nbsp; <input type="radio" id="no" name="isinfo" value="no">否
						</div>
					</div>
				</form>
			</div>
			<div class="am-modal-footer" style="background-color: #EAF2FF;">
				<div align="right" style="padding: 6px">
					<button type="button" class="am-btn am-btn-primary"
						style="padding: 5px" data-am-modal-confirm>
						<span class="am-icon-save"></span> 保存
					</button>
					<button type="button" class="am-btn am-btn-primary"
						style="padding: 5px" data-am-modal-cancel>
						<span class="am-icon-close"></span> 关闭
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- *************弹出模态窗**结束******************** -->
</div>
<script type="text/javascript">
	var zTree, rMenu, isAdd;
	$(function() {
		//非空验证
		$('input').blur(function() {
			if (this.type == 'text' || this.type == 'password') {
				var lab_id = this.name + '_lab';
				if ($(this).val() == '') {
					$("#" + lab_id).attr('class', 'error').html("不能为空");
				} else {
					$("#" + lab_id).attr('class', 'success').html('');
				}
			}
		});
		//初始化树
		var setting = {
			async : {
				enable : true,
				url : "${basePath}dictionary/getAllDictionarys4Json.do",
				autoParam : [ "id" ]
			},
			view : {
				dblClickExpand : true
			},
			edit : {
				enable : true,
				showRemoveBtn : false,
				showRenameBtn : false
			},
			callback : {
				onRightClick : OnRightClick,//右击
				onClick : zTreeOnClick,//点击
				beforeDrop : zTreeBeforeDrop
			//拖拽结束前
			},
		};
		$.fn.zTree.init($("#zTree"), setting);
		zTree = $.fn.zTree.getZTreeObj("zTree");
		rMenu = $("#rMenu");
	});
	//显示菜单
	function showRMenu(type, x, y) {
		$("#rMenu ul").show();
		if (type == "root") {
			$("#m_del").hide();
			$("#m_check").hide();
			$("#m_unCheck").hide();
		} else {
			$("#m_del").show();
			$("#m_check").show();
			$("#m_unCheck").show();
		}
		rMenu.css({
			"top" : y + "px",
			"left" : x + "px",
			"visibility" : "visible"
		});
		$("body").bind("mousedown", onBodyMouseDown);
	}
	//隐藏菜单
	function hideRMenu() {
		if (rMenu)
			rMenu.css({
				"visibility" : "hidden"
			});
		$("body").unbind("mousedown", onBodyMouseDown);
	}
	//点击树以外的地方  隐藏 右键点出来的菜单
	function onBodyMouseDown(event) {
		if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
			rMenu.css({
				"visibility" : "hidden"
			});
		}
	}
	//单击节点 事件
	function zTreeOnClick(event, treeId, treeNode) {
	};
	//右键点击 显示菜单
	function OnRightClick(event, treeId, treeNode) {
		if (!treeNode && event.target.tagName.toLowerCase() != "button"
				&& $(event.target).parents("a").length == 0) {
			zTree.cancelSelectedNode();
		} else if (treeNode && !treeNode.noR) {
			zTree.selectNode(treeNode);
			showRMenu("node", event.clientX, event.clientY);
		}
	}
	//拖拽结束前
	function zTreeBeforeDrop(treeId, treeNodes, targetNode, moveType) {
		return false;
	};
	//新增
	function addTreeNode() {
		hideRMenu();
		isAdd = true;
		backshow("新   增");
		openInfoDialog();
	}
	//修改
	function editTreeNode() {
		hideRMenu();
		var node = zTree.getSelectedNodes()[0];
		isAdd = false;
		backshow("修   改", node);
		openInfoDialog(node);
	}
	//删除
	function removeTreeNode() {
		hideRMenu();
		var node = zTree.getSelectedNodes()[0];
		if (node.children != null) {
			alert("请先删除子节点！");
			return;
		}
		if (confirm("确实要删除吗?")) {
			$.ajax({
				url : "${basePath}dictionary/deleteDictionaryById.do?id="
						+ node.id,
				data : id = node.id,
				type : "post",
				success : function(data) {//ajax返回的数据
					if (data.isSuccess) {
						//alert("删除成功");
						var treeObj = $.fn.zTree.getZTreeObj("zTree");//获取树对象
						treeObj.reAsyncChildNodes(node.getParentNode()
								.getParentNode(), "refresh");//删除时，刷新爷爷节点
					} else {
						alert("抱歉，删除失败。");
					}
				}
			});
		}
	}
	//弹出模态窗 js	
	function openInfoDialog() {
		$('#my-prompt')
				.modal(
						{
							closeViaDimmer : false,
							relatedTarget : this,
							onConfirm : function(e) {
								var selectNode = zTree.getSelectedNodes()[0];
								var id = selectNode.id;
								var abspath = selectNode.abspath;
								//验证数据是否合法
								if (isAdd) {
									$
											.ajax({
												url : "${basePath}dictionary/addDictionary.do?pid="
														+ id
														+ "&abspath="
														+ abspath,
												data : $("#myForm").serialize(),
												type : "post",
												success : function(data) {
													if (data.isSuccess) {
														$('#my-prompt').modal(
																'close');
														//alert("保存成功"); 
														var treeObj = $.fn.zTree
																.getZTreeObj("zTree");//获取树对象
														treeObj
																.reAsyncChildNodes(
																		selectNode
																				.getParentNode(),
																		"refresh");//新增时，刷新父节点
													} else {
														alert("抱歉，新增失败。");
													}
												}
											});
								} else {
									$
											.ajax({
												url : "${basePath}dictionary/updateDictionaryById.do?id="
														+ id,
												data : $("#myForm").serialize(),
												type : "post",
												success : function(data) {
													if (data.isSuccess) {
														$('#my-prompt').modal(
																'close');
														//alert("修改成功");
														var treeObj = $.fn.zTree
																.getZTreeObj("zTree");//获取树对象
														treeObj
																.reAsyncChildNodes(
																		selectNode
																				.getParentNode(),
																		"refresh");//修改时，刷新父节点
													} else {
														alert("抱歉，修改失败。");
													}
												}
											});
								}
							},
							onCancel : function(e) {
								$('#my-prompt').modal('close');
							},
						});
	}
	//模态窗口的回显数据设置
	function backshow(modal_hd, node) {
		$("#modal_hd").html(modal_hd);
		$("input[name='isinfo']").removeAttr('checked');
		if (isAdd) {
			$("#name").val('');
			$("#visible").val('');
			$("#url").val('');
			$("#css").val('wu');
			$("#sort").val('');
			$("#no").prop('checked', 'checked');
		} else {
			$("#name").val(node.name);
			$("#visible").val(node.visible);
			$("#url").val(node.url);
			$("#css").val(node.css);
			$("#sort").val(node.sort);
			$("input[id='" + node.isinfo + "']").prop('checked', 'true');
		}
	}
</script>