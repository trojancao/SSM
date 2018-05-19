function loadPage(url, container) {
    if (!container)
        container = "#mainDiv";
    jQuery(container).load(url, function (response, status, xhr) {
        if (status == "success") {
            if (response) {
                try {
                    var result = jQuery.parseJSON(response);
                    if (result.code == 100) {
                        jQuery(container).html("");
                        alert(result.data);
                    }
                } catch (e) {
                    return response;
                }
            }
        }
    });
}

/**
 * Load a url into a page
 * 增加beforeSend以便拦截器在将该请求识别为非ajax请求
 */
var _old_load = jQuery.fn.load;
jQuery.fn.load = function (url, params, callback) {
    if (typeof url !== "string" && _old_load) {
        return _old_load.apply(this, arguments);
    }

    var selector, type, response,
        self = this,
        off = url.indexOf(" ");
    if (off > -1) {
        selector = jQuery.trim(url.slice(off));
        url = url.slice(0, off);
    }
    if (jQuery.isFunction(params)) {
        callback = params;
        params = undefined;
    } else if (params && typeof params === "object") {
        type = "POST";
    }
    if (self.length > 0) {
        jQuery.ajaxSetup({cache:true});
        jQuery.ajax({
            url: url,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-Requested-With', {
                    toString: function () {
                        return '';
                    }
                });
            },
            type: type || "GET",
            dataType: "html",
            data: params
        }).done(function (responseText) {
            //console.log(responseText);
            response = arguments;
            //页面超时跳转到首页
            if (responseText.startWith("<!--login_page_identity-->")) {
                window.location.href = 'web' + "/";
            } else {
                self.html(selector ?
                    jQuery("<div>").append(jQuery.parseHTML(responseText)).find(selector) :
                    responseText);
            }
        }).always(callback && function (jqXHR, status) {
                self.each(function () {
                    callback.apply(this, response || [jqXHR.responseText, status, jqXHR]);
                });
            });
    }

    return this;
};

//递归删除空属性防止把null变成空值
function deleteEmptyProp(obj) {
    for (var a in obj) {
        if (typeof (obj[a]) == "object" && obj[a] != null) {
            deleteEmptyProp(obj[a]);
        }
        else {
            if (!obj[a]) {
                delete obj[a];
            }
        }
    }
    return obj;
}

/**
 * 比较两个时间的大小 d1>d2 返回大于0
 * @param d1
 * @param d2
 * @returns {number}
 * @constructor
 */
function DateDiff(d1, d2) {
    var result = Date.parse(d1.replace(/-/g, "/")) - Date.parse(d2.replace(/-/g, "/"));
    return result;
}

/**
 * 字符串转日期
 * @returns {number}
 */
String.prototype.strToDate = function () {
    if (this && this != "") {
        return Date.parse(this.replace(/-/g, "/"));
    }
    else
        return "";
};
/**
 * 将map类型[name,value]的数据转化为对象类型
 */
function getObjectFromMap(aData) {
    var map = {};
    for (var i = 0; i < aData.length; i++) {
        var item = aData[i];
        if (!map[item.name]) {
            map[item.name] = item.value;
        }
    }
    return map;
}


/**
 * 获取下一个编码 000001，000001000006，6
 * 得到结果 000001000007
 */
function getNextCode(prefix, maxCode, length) {
    if (maxCode == null) {
        var str = "";
        for (var i = 0; i < length - 1; i++) {
            str += "0";
        }
        return prefix + str + 1;
    } else {
        var str = "";
        var sno = parseInt(maxCode.substring(prefix.length)) + 1;
        for (var i = 0; i < length - sno.toString().length; i++) {
            str += "0";
        }
        return prefix + str + sno;
    }

}


String.prototype.startWith = function (s) {
    if (s == null || s == "" || this.length == 0 || s.length > this.length)
        return false;
    if (this.substr(0, s.length) == s)
        return true;
    else
        return false;
    return true;
};

String.prototype.replaceAll = function (s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2);
};

String.prototype.format = function () {
    if (arguments.length == 0) return this;
    for (var s = this, i = 0; i < arguments.length; i++)
        s = s.replace(new RegExp("\\{" + i + "\\}", "g"), arguments[i]);
    return s;
};

/**
 * 对Date的扩展，将 Date 转化为指定格式的String
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
 * eg:
 * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
 * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04
 * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04
 * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04
 * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18
 */
Date.prototype.format = function(fmt) {
    var o = {
        "M+" : this.getMonth()+1, //月份
        "d+" : this.getDate(), //日
        "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时
        "H+" : this.getHours(), //小时
        "m+" : this.getMinutes(), //分
        "s+" : this.getSeconds(), //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S" : this.getMilliseconds() //毫秒
    };
    var week = {
        "0" : "/u65e5",
        "1" : "/u4e00",
        "2" : "/u4e8c",
        "3" : "/u4e09",
        "4" : "/u56db",
        "5" : "/u4e94",
        "6" : "/u516d"
    };
    if(/(y+)/.test(fmt)){
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    if(/(E+)/.test(fmt)){
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);
    }
    for(var k in o){
        if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
    return fmt;

};

$._messengerDefaults = {
    extraClasses: 'messenger-fixed messenger-theme-air messenger-on-bottom messenger-on-right'
}

var fillForm = function ($form, json) {
    var jsonObj = json;
    if (typeof json === 'string') {
        jsonObj = $.parseJSON(json);
    }

    for (var key in jsonObj) {  //遍历json字符串
        var objtype = jsonObjType(jsonObj[key]); // 获取值类型

         if (objtype === "array") { //如果是数组，一般都是数据库中多对多关系

            var obj1 = jsonObj[key];
            for (var arraykey in obj1) {
                //alert(arraykey + jsonObj[arraykey]);
                var arrayobj = obj1[arraykey];
                for (var smallkey in arrayobj) {
                    setCkb(key, arrayobj[smallkey]);
                    break;
                }
            }
        } else if (objtype === "object") { //如果是对象，啥都不错，大多数情况下，会有 xxxId 这样的字段作为外键表的id

        } else if (objtype === "string") { //如果是字符串
            var str = jsonObj[key];
            var date = new Date(str);
            if (date.getDay()) {  //这种判断日期是本人懒，不想写代码了，大家慎用。
                $("[name=" + key + "]", $form).val(date.format("yyyy-MM-dd"));
                continue;
            }

            var tagobjs = $("[name=" + key + "]", $form);
            if ($(tagobjs[0]).attr("type") == "radio") {//如果是radio控件 
                $.each(tagobjs, function (keyobj,value) {
                    if ($(value).attr("val") == jsonObj[key]) {
                        value.checked = true;
                    }
                });
                continue;
            }
            
            $("[name=" + key + "]", $form).val(jsonObj[key]);
            
        } else { //其他的直接赋值
            $("[name=" + key + "]", $form).val(jsonObj[key]);
        }

    }
}

var setCkb = function (name, value) {
    //alert(name + " " + value);
    //$("[name=" + name + "][value=" + value + "]").attr("checked", "checked");  不知为何找不到具体标签;
    $("[name=" + name + "][val=" + value + "]").attr("checked", "checked");
}