<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport"
        content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <meta name="applicable-device" content="pc,mobile">
        <meta name="MobileOptimized" content="width"/>
        <meta name="HandheldFriendly" content="true"/>
        <link rel="shortcut icon" href="/img/logo.png">

        <rapid:block name="description">
            <meta name="description" content="${options.optionMetaDescrption}" />
        </rapid:block>
        <rapid:block name="keywords">
            <meta name="keywords" content="${options.optionMetaKeyword}" />
        </rapid:block>
        <rapid:block name="title">
            <title>
            ${options.optionSiteTitle}-${options.optionSiteDescrption}
            </title>
        </rapid:block>

        <rapid:block name="header-style"></rapid:block>

        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/plugin/font-awesome/css/font-awesome.min.css">

        <style type="text/css">
            * {
            margin: 0;
            padding: 0;
            text-decoration: none;
            }

            #container {
            position: relative;
            width: 100%;
            overflow: hidden;
            margin-bottom: 1.3%;
            }

            #list {
            /*float: left;
            z-index: 1;
            width: 100%;*/
            }

            #list div {
            position: relative;
            display: inline-block;
            overflow: hidden;
            width: 0;
            float: left;
            }

            #list img {
            float: left;
            width: 0;
            }

            #list div.selected{
            width:100%;
            }

            #list .selected img{
            width:100%;
            }

            #buttons {
            position: absolute;
            left: 53%;
            transform: translateX(-50%);
            bottom: 10px;
            z-index: 2;
            height: 10px;
            width: 100px;
            }

            #buttons span {
            float: left;
            margin-right: 5px;
            width: 10px;
            height: 10px;
            border: 1px solid #fff;
            border-radius: 50%;
            background: #333;
            cursor: pointer;
            }

            #buttons .on {
            background: orangered;
            }

            .arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
            display: none;
            width: 40px;
            height: 40px;
            font-size: 36px;
            font-weight: bold;
            line-height: 39px;
            text-align: center;
            color: #fff;
            background-color: RGBA(0, 0, 0, .3);
            cursor: pointer;
            }

            .arrow:hover {
            background-color: RGBA(0, 0, 0, .7);
            }

            #container:hover .arrow {
            display: block;
            }

            #prev {
            left: 20px;
            }

            #next {
            right: 20px;
            }


            .image-package {
            padding-bottom: 15px;
            margin: 0;
            text-align: center;
            }
            .image-package>img{
            margin: auto;
            }
            .image-caption {
            font-size: 14px;
            color: #969696;
            line-height: 1.7;
            text-align: center;
            }
        </style>

        <script type="text/javascript">
            window.onload = function () {
            var container = document.getElementById('container');
            var list = document.getElementById('list');
            var buttons = document.getElementById('buttons').getElementsByTagName('span');
            var prev = document.getElementById('prev');
            var next = document.getElementById('next');
            var index = 0;
            var timer;
            var count=list.getElementsByTagName('div').length;

            function animate() {
            var list=document.getElementById('list');
            var li=list.getElementsByClassName('selected')[0];
            li.classList.toggle('selected');
            list.getElementsByTagName('div')[index].classList.toggle('selected');

            }

            function play() {
            //重复执行的定时器
            timer = setInterval(function () {
                next.onclick();
            }, 2000)
            }

            function stop() {
            clearInterval(timer);
            }

            function buttonsShow() {
            //将之前的小圆点的样式清除
            for (var i = 0; i < buttons.length; i++) {
                if (buttons[i].className == "on") {
                    buttons[i].className = "";
                }
            }
            //数组从0开始
            buttons[index].className = "on";
            }

            prev.onclick = function () {
            index--;
            if (index < 0) {
                index = count-1;
            }
            buttonsShow();
            animate();
            };

            next.onclick = function () {
            //由于上边定时器的作用，index会一直递增下去，我们只有5个小圆点，所以需要做出判断
            index ++;
            if (index === count) {
                index = 0
            }
            animate();
            buttonsShow();
            };

            for (var i = 0; i < buttons.length; i++) {
            (function (i) {
                buttons[i].onclick = function () {

                    /*  这里获得鼠标移动到小圆点的位置，用this把index绑定到对象buttons[i]上，去谷歌this的用法  */
                    /*  由于这里的index是自定义属性，需要用到getAttribute()这个DOM2级方法，去获取自定义index的属性*/
                    var clickIndex = parseInt(this.getAttribute('index'));
                    index = clickIndex; //存放鼠标点击后的位置，用于小圆点的正常显示
                    buttonsShow();
                    animate();
                }
            })(i)
            }

            container.onmouseover = stop;
            container.onmouseout = play;
            play();

            }
        </script>
    </head>

    <body>
        <div id="page" class="site" style="transform: none;">
            <%@ include file="part/header.jsp" %>

            <div id="content" class="site-content" style="transform: none;">
                <rapid:block name="left"></rapid:block>
                <rapid:block name="right">
                    <%@ include file="part/sidebar-1.jsp" %>
                </rapid:block>
            </div>
            <div class="clear"></div>
            <rapid:block name="link"></rapid:block>
            <%@ include file="part/footer.jsp"%>
        </div>

        <script src="/js/jquery.min.js"></script>
        <script src="/js/superfish.js"></script>
        <script src="/js/script.js"></script>
        <script src="/plugin/layui/layui.all.js"></script>

        <rapid:block name="footer-script"></rapid:block>
    </body>
</html>