using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Win32;

public partial class TestCalendar : System.Web.UI.Page
{
    DateTime result;
    string stravel_date1 = "";
    string stravel_date2 = "";
    string stravel_time1 = "";
    string stravel_time2 = "";    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["travel_date"] != null)
        {
            this.CalendarTitle.InnerText = Session["travel_date"].ToString();
        }

        this.usr_code.Value = this.Request.Form["Usr_code"];
        this.per_name.Value = this.Request.Form["Usr_name"];
        this.Sendbtn.Click += new EventHandler(Sendbtn_Click);
        this.Modifybtn.Click += new EventHandler(Modifybtn_Click);
        this.Deletebtn.Click += new EventHandler(Deletebtn_Click);
    }

    protected void Deletebtn_Click(object sender, EventArgs e)
    {
        SetDate();
        string sSql = "DELETE FROM OutRecord WHERE ser_no =" + Convert.ToInt32(this.ser_no.Value) ;
        TLC.DB.ExecuteSQL(sSql);
        //session 可以保留住數值 但容易吃記憶體 所以不能常用(除非關掉瀏覽器 就會不見)
        Session["travel_date"] = stravel_date1.Substring(0, 7);
        //重新導向 避免重複執行表單提交 
        Response.Redirect(Request.RawUrl);        
    }

    protected void Modifybtn_Click(object sender, EventArgs e)
    {
        SetDate();
        string sSql = "UPDATE OutRecord set    travel_time1 ='" + stravel_time1 + "'," +
                        "                      travel_date2 ='" + stravel_date2 + "'," +
                        "                      travel_time2 ='" + stravel_time2 + "'," +
                        "                      travel_location ='" + this.travel_location.Value + "'," +
                        "                      apc_name ='" + this.apc_name.Value + "'," +
                        "                      our_ref ='" + this.our_ref.Value + "'" +
                        " WHERE                ser_no =" + Convert.ToInt32(this.ser_no.Value) ;
        TLC.DB.ExecuteSQL(sSql);
        //session 可以保留住數值 但容易吃記憶體 所以不能常用(除非關掉瀏覽器 就會不見)
        Session["travel_date"] = stravel_date1.Substring(0, 7);
        //重新導向 避免重複執行表單提交        
        Response.Redirect(Request.RawUrl);
    }
    protected void Sendbtn_Click(object sender, EventArgs e)
    {
        SetDate();
        //新增外出資料進資料庫
        string sSql = "INSERT INTO OutRecord(usr_code,cre_date,cre_time,per_name,travel_date1,travel_time1,travel_date2,travel_time2,travel_location,apc_name,our_ref,is_check)" +
                        "VALUES ('" + this.usr_code.Value + "','" +                        //usr_code
                                    DateTime.Now.ToString("yyyy/MM/dd") + "','" +        //cre_date
                                    DateTime.Now.ToString("HH:mm:ss") + "','" +          //cre_time
                                    this.per_name.Value + "','" +                        //per_name
                                    stravel_date1 + "','" +                              //travel_date1
                                    stravel_time1 + "','" +                              //travel_time1
                                    stravel_date2 + "','" +                              //travel_date2
                                    stravel_time2 + "','" +                              //travel_time2
                                    this.travel_location.Value + "','" +                 //travel_location
                                    this.apc_name.Value + "','" +                        //apc_name
                                    this.our_ref.Value + "','" +                         //our_ref
                                    'N' + "')";                                          //is_check
        TLC.DB.ExecuteSQL(sSql);
        //session 可以保留住數值 但容易吃記憶體 所以不能常用(除非關掉瀏覽器 就會不見)
        Session["travel_date"] = stravel_date1.Substring(0,7);
        //重新導向 避免重複執行表單提交
        Response.Redirect(Request.RawUrl);
    }
    protected bool SetDate()
    {
        if (DateTime.TryParse(this.travel_date1.Value, out result))
        {
            stravel_date1 = this.travel_date1.Value;
        }
        if (DateTime.TryParse(this.travel_date2.Value, out result))
        {
            stravel_date2 = this.travel_date2.Value;
        }
        if (DateTime.TryParse(this.travel_time1.Value, out result))
        {
            stravel_time1 = this.travel_time1.Value;
        }
        if (DateTime.TryParse(this.travel_time2.Value, out result))
        {
            stravel_time2 = this.travel_time2.Value;
        }
        return false;
    }
}