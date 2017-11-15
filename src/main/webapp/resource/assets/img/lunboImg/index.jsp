<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/myTag.tld" prefix="lyz" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>


<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            text-decoration: none;
        }

        body {
            padding: 20px;
        }

        #container {
            position: relative;
            width: 760px;
            height: 300px;
            border: 3px solid #333;
            overflow: hidden;
        }

        #list {
            position: absolute;
            z-index: 1;
            width: 4200px;
            height: 300px;
        }

        #list img {
            float: left;
            width: 760px;
            height: 300px;
        }

        #buttons {
            position: absolute;
            left: 250px;
            bottom: 20px;
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
            top: 180px;
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
    </style>
    <script type="text/javascript">
        /* 知识点：        */
        /*       this用法 */
        /*       DOM事件 */
        /*       定时器 */

        window.onload = function () {
            var container = document.getElementById('container');
            var list = document.getElementById('list');
            var buttons = document.getElementById('buttons').getElementsByTagName('span');
            var prev = document.getElementById('prev');
            var next = document.getElementById('next');
            var index = 1;
            var timer;

            function animate(offset) {
                //获取的是style.left，是相对左边获取距离，所以第一张图后style.left都为负值，
                //且style.left获取的是字符串，需要用parseInt()取整转化为数字。
                var newLeft = parseInt(list.style.left) + offset;
                list.style.left = newLeft + 'px';
                //无限滚动判断
                if (newLeft > -760) {
                    list.style.left = -3000 + 'px';
                }
                if (newLeft < -3000) {
                    list.style.left = -760 + 'px';
                }
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
                //数组从0开始，故index需要-1
                buttons[index - 1].className = "on";
            }

            prev.onclick = function () {
                index -= 1;
                if (index < 1) {
                    index = 5
                }
                buttonsShow();
                animate(760);
            };

            next.onclick = function () {
                //由于上边定时器的作用，index会一直递增下去，我们只有5个小圆点，所以需要做出判断
                index += 1;
                if (index > 5) {
                    index = 1
                }
                animate(-760);
                buttonsShow();
            };

            for (var i = 0; i < buttons.length; i++) {
                (function (i) {
                    buttons[i].onclick = function () {

                        /*  这里获得鼠标移动到小圆点的位置，用this把index绑定到对象buttons[i]上，去谷歌this的用法  */
                        /*  由于这里的index是自定义属性，需要用到getAttribute()这个DOM2级方法，去获取自定义index的属性*/
                        var clickIndex = parseInt(this.getAttribute('index'));
                        var offset = 760 * (index - clickIndex); //这个index是当前图片停留时的index
                        animate(offset);
                        index = clickIndex; //存放鼠标点击后的位置，用于小圆点的正常显示
                        buttonsShow();
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

    <rapid:override name="breadcrumb">
        <nav class="breadcrumb">
            <div class="bull"><i class="fa fa-volume-up"></i></div>
            <div id="scrolldiv">
                <div class="scrolltext">
                    <ul style="margin-top: 0px;">
                        <c:forEach items="${noticeCustomList}" var="n">
                            <li class="scrolltext-title">
                                <a href="/notice/${n.noticeId}" rel="bookmark">${n.noticeTitle}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </nav>
    </rapid:override>

    <rapid:override name="left">
        <div id="primary" class="content-area">

            <main id="main" class="site-main" role="main">

                <div id="slideshow" class="wow fadeInUp" data-wow-delay="0.3s">
                    <ul class="rslides" id="slider">
                        <li>
                            <a href="/aboutSite" target="_blank" rel="external nofollow">
                            <img src="/img/lunboImg/1.jpg"  alt="Welcome to the blog of Acamy!"></a>
                            <p class="slider-caption">Welcome to the blog of Hebh!</p>
                        </li>
                    </ul>
                </div>

                <div id="container">
                    <div id="list" style="left: -600px;">
                        <img src="img/lunboImg/5.jpg" alt="1"/>
                        <img src="img/lunboImg/1.jpg" alt="1"/>
                        <img src="img/lunboImg/2.jpg" alt="2"/>
                        <img src="img/lunboImg/3.jpg" alt="3"/>
                        <img src="img/lunboImg/4.jpg" alt="4"/>
                        <img src="img/lunboImg/5.jpg" alt="5"/>
                        <img src="img/lunboImg/1.jpg" alt="5"/>
                    </div>
                    <div id="buttons">
                        <span index="1" class="on"></span>
                        <span index="2"></span>
                        <span index="3"></span>
                        <span index="4"></span>
                        <span index="5"></span>
                    </div>
                    <a href="javascript:;" id="prev" class="arrow">&lt;</a>
                    <a href="javascript:;" id="next" class="arrow">&gt;</a>
                </div>

                <c:forEach items="${articleListVoList}" var="a">

                    <article  class="post type-post">

                        <figure class="thumbnail">
                            <a href="/article/${a.articleCustom.articleId}">
                                <img width="280" height="210"
                                     src="/img/thumbnail/random/img_${a.articleCustom.articleId%400}.jpg"
                                     class="attachment-content size-content wp-post-image"
                                     alt="${a.articleCustom.articleTitle}">
                            </a>
                            <span class="cat">
                                <a href="/category/${a.categoryCustomList[a.categoryCustomList.size()-1].categoryId}">
                                        ${a.categoryCustomList[a.categoryCustomList.size()-1].categoryName}
                                </a>
                            </span>
                        </figure>

                        <header class="entry-header">
                            <h2 class="entry-title">
                                <a href="/article/${a.articleCustom.articleId}"
                                   rel="bookmark">
                                        ${a.articleCustom.articleTitle}
                                </a>
                            </h2>
                        </header>

                        <div class="entry-content">
                            <div class="archive-content">
                                <lyz:htmlFilter>${a.articleCustom.articleContent}</lyz:htmlFilter>......
                            </div>
                            <span class="title-l"></span>
                            <span class="new-icon">
                                    <c:choose>
                                        <c:when test="${a.articleCustom.articleStatus==2}">
                                            <i class="fa fa-bookmark-o"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <jsp:useBean id="nowDate" class="java.util.Date"/>
                                            <c:set var="interval"
                                                   value="${nowDate.time - a.articleCustom.articlePostTime.time}"/><%--时间差毫秒数--%>
                                            <fmt:formatNumber value="${interval/1000/60/60/24}" pattern="#0"
                                                              var="days"/>
                                            <c:if test="${days <= 7}">NEW</c:if>
                                        </c:otherwise>
                                    </c:choose>


                                </span>
                            <span class="entry-meta">
                                    <span class="date">
                                        <fmt:formatDate value="${a.articleCustom.articlePostTime}" pattern="yyyy年MM月dd日"/>
                                    &nbsp;&nbsp;
                                    </span>
                                    <span class="views">
                                        <i class="fa fa-eye"></i>
                                            ${a.articleCustom.articleViewCount} views
                                    </span>
                                    <span class="comment">&nbsp;&nbsp;
                                        <a href="/article/${a.articleCustom.articleId}#comments" rel="external nofollow">
                                          <i class="fa fa-comment-o"></i>
                                            <c:choose>
                                                <c:when test="${a.articleCustom.articleCommentCount==0}">
                                                    发表评论
                                                </c:when>
                                                <c:otherwise>
                                                    ${a.articleCustom.articleCommentCount}
                                                </c:otherwise>
                                            </c:choose>

                                        </a>
                                    </span>
                                </span>
                            <div class="clear"></div>
                        </div><!-- .entry-content -->

                        <span class="entry-more">
                                <a href="/article/${a.articleCustom.articleId}"
                                   rel="bookmark">
                                    阅读全文
                                </a>
                            </span>
                    </article>
                </c:forEach>
            </main>

            <c:if test="${articleListVoList[0].page.totalPageCount>1}">
            <nav class="navigation pagination" role="navigation">
                <div class="nav-links">
                    <c:choose>
                        <c:when test="${articleListVoList[0].page.totalPageCount <= 3 }">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="${articleListVoList[0].page.totalPageCount }"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${articleListVoList[0].page.pageNow-1 }"/>
                            <c:set var="end" value="${articleListVoList[0].page.pageNow + 2}"/>
                            <c:if test="${begin < 2 }">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="3"/>
                            </c:if>
                            <c:if test="${end > articleListVoList[0].page.totalPageCount }">
                                <c:set var="begin" value="${articleListVoList[0].page.totalPageCount-2 }"/>
                                <c:set var="end" value="${articleListVoList[0].page.totalPageCount }"/>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                        <%--上一页 --%>
                    <c:choose>
                        <c:when test="${articleListVoList[0].page.pageNow eq 1 }">
                            <%--当前页为第一页，隐藏上一页按钮--%>
                        </c:when>
                        <c:otherwise>
                            <a class="page-numbers" href="/p/${articleListVoList[0].page.pageNow-1}" >
                                <span class="fa fa-angle-left"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                        <%--显示第一页的页码--%>
                    <c:if test="${begin >= 2 }">
                        <a class="page-numbers" href="/p/1">1</a>
                    </c:if>
                        <%--显示点点点--%>
                    <c:if test="${begin  > 2 }">
                        <span class="page-numbers dots">…</span>
                    </c:if>
                        <%--打印 页码--%>
                    <c:forEach begin="${begin }" end="${end }" var="i">
                        <c:choose>
                            <c:when test="${i eq articleListVoList[0].page.pageNow }">
                                <a class="page-numbers current" >${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a  class="page-numbers" href="/p/${i}">${i }</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                        <%-- 显示点点点 --%>
                    <c:if test="${end < articleListVoList[0].page.totalPageCount-1 }">
                        <span class="page-numbers dots">…</span>
                    </c:if>
                        <%-- 显示最后一页的数字 --%>
                    <c:if test="${end < articleListVoList[0].page.totalPageCount }">
                        <a href="/p/${articleListVoList[0].page.totalPageCount}">
                                ${articleListVoList[0].page.totalPageCount}
                        </a>
                    </c:if>
                        <%--下一页 --%>
                    <c:choose>
                        <c:when test="${articleListVoList[0].page.pageNow eq articleListVoList[0].page.totalPageCount }">
                            <%--到了尾页隐藏，下一页按钮--%>
                        </c:when>
                        <c:otherwise>
                            <a class="page-numbers" href="/p/${articleListVoList[0].page.pageNow+1}">
                                <span class="fa fa-angle-right"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </div>
            </nav>
                <%--分页 end--%>
            </c:if>
        </div>
    </rapid:override>
    <%--左侧区域 end--%>

    <%--侧边栏 start--%>
    <rapid:override name="right">
        <%@include file="Public/part/sidebar-2.jsp" %>
    </rapid:override>
    <%--侧边栏 end--%>

    <%--友情链接 start--%>
    <rapid:override name="link">
        <div class="links-box">
            <div id="links">
                <c:forEach items="${linkCustomList}" var="l">
                    <ul class="lx7">
                        <li class="link-f link-name">
                            <a href="${l.linkUrl}" target="_blank">
                                    ${l.linkName}
                            </a>
                        </li>
                    </ul>
                </c:forEach>
                <div class="clear"></div>
            </div>
        </div>
    </rapid:override>
    <%--友情链接 end--%>

<%@ include file="Public/framework.jsp" %>

</body>

</html>