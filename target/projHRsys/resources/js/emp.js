/**
 * Created by Founder007 on 2017/10/13.
 */
$(function () {
    //动态菜单数据
    var treeData = [{
        text : "菜单",
        state : "closed",
        children : [{
            text : "数据表格",
            state : "",
            attributes : {
                url : ""
            }
        }, {
            text : "一级菜单2",
            attributes : {
                url : ""
            }
        }, {
            text : "个人信息",
            state : "closed",
            children : [{
                text : "查看/编辑个人信息",
                attributes : {
                    url : "empMyDetails"
                }
            }, {
                text : "离职申请",
                attributes : {
                    url : "myDmsApply"
                }
            }
            ]
        },{
            text : "员工培训计划",
            state : "closed",
            children : [{
                text : "查看培训",
                attributes : {
                    url : "trainnPage"
                }
            }, {
                text : "NULL",
                attributes : {
                    url : "#"
                }
            }
            ]
        },{
            text : "组织架构",
            state : "closed",
            children : [{
                text : "员工通讯表",
                attributes : {
                    url : "addrPage"
                }
            }, {
                text : "NULL",
                attributes : {
                    url : "#"
                }
            }
            ]
        },{
            text : "薪资表",
            state : "closed",
            children : [{
                text : "工资明细",
                attributes : {
                    url : "empSalaryPage"
                }
            }, {
                text : "奖惩明细",
                attributes : {
                    url : "myBonus"
                }
            }, {
                text : "工资复议",
                attributes : {
                    url : "listMyReco"
                }
            }
            ]
        },{
            text : "考勤打卡",
            state : "closed",
            children : [{
                text : "每日考勤",
                attributes : {
                    url : "empAttend"
                }
            }, {
                text : "历史考勤记录",
                attributes : {
                    url : "hisAttePage"
                }
            }
            ]
        }
        ]
    }
    ];

    //实例化树形菜单
    $("#tree").tree({
        data : treeData,
        lines : true,
        onClick : function (node) {
            if (node.attributes) {
                Open(node.text, node.attributes.url);
            }
        }
    });
    //在右边center区域打开菜单，新增tab
    function Open(text, url) {
        var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';

        if ($("#tabs").tabs('exists', text)) {
            $('#tabs').tabs('select', text);
        } else {
            $('#tabs').tabs('add', {
                title : text,
                closable : true,
                content : content
            });
        }
    }

    //绑定tabs的右键菜单
    $("#tabs").tabs({
        onContextMenu : function (e, title) {
            e.preventDefault();
            $('#tabsMenu').menu('show', {
                left : e.pageX,
                top : e.pageY
            }).data("tabTitle", title);
        }
    });

    //实例化menu的onClick事件
    $("#tabsMenu").menu({
        onClick : function (item) {
            CloseTab(this, item.name);
        }
    });

    //几个关闭事件的实现
    function CloseTab(menu, type) {
        var curTabTitle = $(menu).data("tabTitle");
        var tabs = $("#tabs");

        if (type === "close") {
            tabs.tabs("close", curTabTitle);
            return;
        }

        var allTabs = tabs.tabs("tabs");
        var closeTabsTitle = [];

        $.each(allTabs, function () {
            var opt = $(this).panel("options");
            if (opt.closable && opt.title != curTabTitle && type === "Other") {
                closeTabsTitle.push(opt.title);
            } else if (opt.closable && type === "All") {
                closeTabsTitle.push(opt.title);
            }
        });

        for (var i = 0; i < closeTabsTitle.length; i++) {
            tabs.tabs("close", closeTabsTitle[i]);
        }
    }
});