<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Data.OleDb;
using System.Data;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class Handler : IHttpHandler {
    public void ProcessRequest(HttpContext context)
    {
        //除非選擇「每次造訪網頁時」，IE在存取ASP.NET網頁時，都有可能直接取用Cache內容而不是重新執行ASP.NET程式
        //所以讓.ashx這頁不要儲存cache，就可以每次抓新的內容
        //只有IE讀取 JSON.ashx 的時候會用開啟 儲存方式進行 
        //每次更新JSON 即可讓前端顯示
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        DataTable dt = TLC.DB.GetDt("Select * from OutRecord order by travel_time1");
        //建立要轉換的資料
        List<Item> ItemList = new List<Item>();
        for (int intA = 0; intA < dt.Rows.Count; intA++)
        {
            ItemList.Add(new Item
            {
                ser_no = Convert.ToInt32(dt.Rows[intA]["ser_no"]),
                usr_code = dt.Rows[intA]["usr_code"].ToString(),
                cre_date = dt.Rows[intA]["cre_date"].ToString(),
                cre_time = dt.Rows[intA]["cre_time"].ToString(),
                per_name = dt.Rows[intA]["per_name"].ToString(),
                travel_date1 = dt.Rows[intA]["travel_date1"].ToString(),
                travel_time1 = dt.Rows[intA]["travel_time1"].ToString(),
                travel_date2 = dt.Rows[intA]["travel_date2"].ToString(),
                travel_time2 = dt.Rows[intA]["travel_time2"].ToString(),
                travel_location = dt.Rows[intA]["travel_location"].ToString(),
                apc_name = dt.Rows[intA]["apc_name"].ToString(),
                our_ref = dt.Rows[intA]["our_ref"].ToString(),
                is_check = dt.Rows[intA]["is_check"].ToString(),
                check_date = dt.Rows[intA]["check_date"].ToString(),
                check_time = dt.Rows[intA]["check_time"].ToString(),
                check_per = dt.Rows[intA]["check_per"].ToString()
            });
        }
        //設定輸入的contentType為JSON格式
        context.Response.ContentType = "application/json";
        context.Response.Charset = "utf-8";
        //將資料序列化為JSON格式輸出
        JavaScriptSerializer Serializer = new JavaScriptSerializer();
        context.Response.Write(Serializer.Serialize(ItemList));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    public class Item
    {
        public int ser_no;
        public string usr_code;
        public string cre_date;
        public string cre_time;
        public string per_name;
        public string travel_date1;
        public string travel_time1;
        public string travel_date2;
        public string travel_time2;
        public string travel_location;
        public string apc_name;
        public string our_ref;
        public string is_check;
        public string check_date;
        public string check_time;
        public string check_per;
    }
}