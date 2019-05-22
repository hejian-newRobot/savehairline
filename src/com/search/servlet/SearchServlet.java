package com.search.servlet;
import net.sf.json.JSONArray;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class SearchServlet extends HttpServlet{
    private static List<String> keywords ;
    static
    { keywords = new ArrayList<String>();
      keywords.add("卫宁");
      keywords.add("汉得");
      keywords.add("顶点");
      keywords.add("百度");
      keywords.add("阿里巴巴");
      keywords.add("腾讯");
      keywords.add("华为");
      keywords.add("微软");
      keywords.add("甲骨文");
      keywords.add("abstract");
      keywords.add("age");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //编码匹配,防止前后端编码不匹配导致乱码问题
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //获得关键字
        String keyword = request.getParameter("keyword");
        //是否为空
        if (null == keyword){
            return;//为空返回
        }
        //获取与关键字匹配的内容
        List<String> filteredContents = this.getContentsByKeyword(keyword);
        System.out.println("匹配的字符串有 : "+filteredContents.size()+"个");
        //将得到的内容转换为Json格式写入到response
        response.getWriter().write(JSONArray.fromObject(filteredContents).toString());
    }

    /*
    * 获得与关键字参数匹配的内容
    * */
    private List<String> getContentsByKeyword(String keyword){
        //实例化集合,用来存放匹配的内容
        List<String> matchedContents = new ArrayList<String>();
        //遍历集合
        for (String temp:
                keywords) {
            //匹配字符串的内容 比如字符串为 keyword ,匹配字符为 k,则为true
            if (temp.contains(keyword)){
                matchedContents.add(temp);//如果包含则插入到集合中
            }
        }
        return matchedContents;//返回匹配的内容集合
    }
}

