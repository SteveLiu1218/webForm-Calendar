using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TestCalendarCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Sendbtn.Click += new EventHandler(Sendbtn_Click);
    }
    protected void Sendbtn_Click(object sender, EventArgs e)
    {
        //ShadowValue 會跟著 勾選幾個而呈現 ser_no 加 ,
        string[] sSer_no = this.ShadowValue.Value.Split(',');
        for (int intA = 0; intA < sSer_no.Length ; intA++)
        {
            if (sSer_no[0] == "")break; 
            string sSql = "UPDATE OutRecord set is_check ='" + "Y" + "'," +
            "                   check_date ='" + DateTime.Now.ToString("yyyy/MM/dd") + "'," +
            "                   check_time ='" + DateTime.Now.ToString("HH:mm:ss") + "'," +
            "                   check_per ='" + "審核者名稱" + "'" +
            " WHERE             ser_no =" + sSer_no[intA];
            TLC.DB.ExecuteSQL(sSql);
        }
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg",
                "<script>alert('審核完成！');</script>");
        Response.Redirect(Request.RawUrl);  
    }
}