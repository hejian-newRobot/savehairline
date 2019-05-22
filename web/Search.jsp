<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2018/4/1
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Search</title>
    <style type="text/css">
      #mydiv{
      position:absolute;
        left: 50%;
        top: 50%;
        margin-left:-200px;
        margin-right: -200px;
      }
      .mouseOver{
          background: #708090;
          color: #FFFAFA;
      }
      .mouseOut{
          background: #FFFAFA;
          color: #000000;
      }
    </style>
    <script type="text/javascript">
      var xmlhttp;
      function GetMoreContents() {
          //获得id =keyword 得节点 去掉空格的值
        var content = document.getElementById("keyword").value.trim();
        //如果输入得是空格则返回
        if (content == ""){
            //关键字为空清理显示匹配内容的表（id = table_body）的子节点
            cleanPopDiv_table_body();
            return;
        }
        //是否是汉字,不是汉字返回
       /* for(var i=0;i<content.length;i++){
              if (!/^[\u4e00-\u9fa5]$/.test(content.charAt(i).toString())){
                  //关键字某一字符不为汉字清理显示匹配内容的表（id = table_body）的子节点
                  cleanPopDiv_table_body();
                  return;
              }
          }*/
          //使用xmlhttp对象
          xmlhttp = GetXmlHttpRequest();
          var url = "search?keyword="+content;
          // 第三个参数 true:表示javascript脚本会在send()方法之后继续执行,不会等待来自服务器得响应
          xmlhttp.open("GET",url,true);
          xmlhttp.onreadystatechange = callback;
          xmlhttp.send(null);
      }
      //获得xmlHttp对象
      function GetXmlHttpRequest() {
          var xmlHttp;
          if (window.XMLHttpRequest){
              xmlHttp = new XMLHttpRequest();
          }else if (window.ActiveXObject)
              xmlHttp = new ActiveXObject("Microsoft.XMLHTTP ");
              if (!xmlHttp){
                  xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")
              }
          return xmlHttp;
      }
      //实现回调函数
      function callback(){
        if (xmlhttp.readyState == 4){
          // xmlhttp.status =200 表示服务器响应成功
          //404表示代表资源未找到 500 服务器内部错误
          if (xmlhttp.status == 200){
              var result = xmlhttp.responseText;
              var json = eval("("+result+")");
              //展示获得的数据到页面
              setContents(json);
          }
        }
      }
      //展示从服务器获得的数据
      function setContents(contents) {
        ////清理显示匹配文字的表格
        cleanPopDiv_table_body();
        //设置显示匹配数据的容器(table)的显示位置及样式
        setLocation();
        var size = contents.length;
        for(var i = 0;i<size;i++){
            var nextNode = contents[i];
            var tr = document.createElement("tr");
            var td = document.createElement("td");
            td.setAttribute("border",0);
            td.setAttribute("bgcolor","#FFFAFA");
            //注册鼠标over td事件
            td.onmouseover = function (ev) { this.className = 'mouseOver' };
            //注册鼠标离开td事件
            td.onmouseout = function (ev) { this.className = 'mouseOut' };
            //显示匹配数据的td节点被点击触发事件
            td.onmousedown = function(){
                document.getElementById("keyword").value = this.innerText;
            };
            var text = document.createTextNode(nextNode);
            td.appendChild(text);
            tr.appendChild(td);
            document.getElementById("popDiv_table_body").appendChild(tr);
        }
      }
      //设置显示匹配数据容器(table)的显示位置及样式
      function setLocation() {
          var inputKeywordBox = document.getElementById("keyword");
          var width = inputKeywordBox.offsetWidth;
          var left = inputKeywordBox["offsetLeft"];
          var top = inputKeywordBox["offsetTop"] + inputKeywordBox.offsetHeight;
          var popDiv = document.getElementById("popDiv");
          popDiv.style.border = "black 1px solid";//div边框样式
          popDiv.style.left = left +"px";
          popDiv.style.top = top + "px";//popDiv离顶部的距离应该是输入框到顶部的距离加上本上的高度
          popDiv.style.width = width+"px";
          document.getElementById("popDiv_table").style.width = popDiv.style.width;
      }
      //清理显示匹配文字的表格
      function cleanPopDiv_table_body() {
          var popDiv_table_body = document.getElementById("popDiv_table_body");
          var size = popDiv_table_body.childNodes.length;
          for (var i=size-1;i>=0;i--){
              popDiv_table_body.removeChild(popDiv_table_body.childNodes[i]);
          }
          document.getElementById("popDiv").style.border = "none";
      }
      //当输入框失去焦点触发事件
      function KeywordBlur() {
          //清理匹配数据
          cleanPopDiv_table_body();
      }
      //当输入框获得焦点触发事件
      function KeywordFocus() {
          //获得匹配数据
          GetMoreContents();
      }
      //显示匹配数据的td节点被点击触发事件

    </script>
    <head>
  <body>
  <div id = "mydiv">
    <!--输入框-->
    <input type="text" size="50" id="keyword" onkeyup="GetMoreContents()" onblur="KeywordBlur()" onfocus="KeywordFocus()"/>
    <input type="button" value="百度一下" width="50px"/>
    <div id="popDiv">
      <table id="popDiv_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
        <tbody id="popDiv_table_body">
        </tbody>
      </table>
    </div>
  </div>
  </body>
</html>
