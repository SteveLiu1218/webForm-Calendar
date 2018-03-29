<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestCalendarCheck.aspx.cs" Inherits="TestCalendarCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
<title>審核工程師外出</title>
    <style>
.allpage
{
    padding-top:10px;
    margin:0 auto;
    width:95%;
}
body
{
    background-color:#eee;
    width:100%;
    margin:0;
    padding:0;
    height:960px;
}
.btn
{
    float:left;
    margin:20px 20px 0 0;    
    cursor:pointer;
    font-weight:bold;
    font-size:24px;
    color:white;
    padding: 15px 40px;
    outline: none;
    background-color: #50b584;
    border: none;
    border-radius: 5px;
    box-shadow: 0 9px #bfbfbf;
}
.btn:active
{
  background-color: #50b584;
  box-shadow: 0 5px #bfbfbf;
  transform: translateY(4px);
}
.bg_green
{
    background-color:#baeae1;
}
input[type=checkbox]
{
  /* Double-sized Checkboxes */
  -ms-transform: scale(1.5); /* IE */
  -moz-transform: scale(1.5); /* FF */
  -webkit-transform: scale(1.5); /* Safari and Chrome */
  -o-transform: scale(1.5); /* Opera */
  padding-left:10px;
}
table
{    
    width:100%;
}
th
{
    background-color:#1abc9c;
    border: 1px solid black;
}
td
{
    padding:4px;
    border: 1px solid black;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="allpage" class="allpage">
            <table>
                <thead>
                    <tr>
                        <th>全選<input type="checkbox" name="all" onclick="check_all(this,'c'),setValue()"/></th>
                        <th>工程師</th>
                        <th>出差時間</th>
                        <th>客戶</th>
                        <th>案號</th>
                        <th>地點</th>
                        <th>識別碼</th>
                        <th>建立者</th>
                        <th>建立日期</th>
                        <th>建立時間</th>
                    </tr>
                </thead>
                <tbody id="tbody" runat="server">
                </tbody>
            </table>
            <div id="ShowText" runat=server style="color:#337ab7; font-size:32px; display:none"><bold>沒有未審核資料</bold></div>
             <asp:Button CssClass="btn" ID="Sendbtn" runat="server" Text="確定" />
             <input style="display:none;" id="ShadowValue" runat="server" />
         </div>
    </form>
</body>
<script type="text/javascript">
    // JSON AJAX物件
    var xmlhttp = new XMLHttpRequest();
    var iNum = 0;

    xmlhttp.onreadystatechange = function () 
    {            //onreadystatechange	Defines a function to be called when the readyState property changes
        if (this.readyState == 4 && this.status == 200) 
        { //4: request finished and response is ready 
            var myArr = JSON.parse(this.responseText);    //200: "OK"
            for (var intA = 0; intA < myArr.length; intA++) 
            {
                var tempTime;
                //僅列出 未審核
                if (myArr[intA].is_check == "N") 
                {
                    //隔行換色
                    if ((iNum + 1) % 2 == 1) 
                    {
                        if (myArr[intA].travel_date1 == myArr[intA].travel_date2) 
                        {
                            if (myArr[intA].travel_time2 == "") 
                            {
                                tempTime = myArr[intA].travel_date1 + "   " + myArr[intA].travel_time1;
                            }
                            else 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_time2;
                            }
                        }
                        else if (myArr[intA].travel_date1 != myArr[intA].travel_date2) 
                        {
                            if (myArr[intA].travel_time2 == "") 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_date2;
                            }
                            else 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_date2 + "  " + myArr[intA].travel_time2;
                            }
                        }
                        var tdHtml = "<td>" + myArr[intA].per_name + "</td>" +
                                     "<td>" + tempTime + "</td>" +
                                     "<td>" + myArr[intA].apc_name + "</td>" +
                                     "<td>" + myArr[intA].our_ref + "</td>" +
                                     "<td>" + myArr[intA].travel_location + "</td>" +
                                     "<td id=\"ser_no" + "_" + iNum + "\">" + myArr[intA].ser_no + "</td>" +
                                     "<td>" + myArr[intA].usr_code + "</td>" +
                                     "<td>" + myArr[intA].cre_date + "</td>" +
                                     "<td>" + myArr[intA].cre_time + "</td>";
                    }
                    else 
                    {
                        if (myArr[intA].travel_date1 == myArr[intA].travel_date2) 
                        {
                            if (myArr[intA].travel_time2 == "") 
                            {
                                tempTime = myArr[intA].travel_date1 + "   " + myArr[intA].travel_time1;
                            }
                            else 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_time2;
                            }
                        }
                        else if (myArr[intA].travel_date1 != myArr[intA].travel_date2) 
                        {
                            if (myArr[intA].travel_time2 == "") 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_date2;
                            }
                            else 
                            {
                                tempTime = myArr[intA].travel_date1 + "  " + myArr[intA].travel_time1 + " ~ " + myArr[intA].travel_date2 + "  " + myArr[intA].travel_time2;
                            }
                        }
                        var tdHtml = "<td class=\"bg_green\">" + myArr[intA].per_name + "</td>" +
                                     "<td class=\"bg_green\">" + tempTime + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].apc_name + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].our_ref + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].travel_location + "</td>" +
                                     "<td class=\"bg_green\" id=\"ser_no" + "_" + iNum + "\">" + myArr[intA].ser_no + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].usr_code + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].cre_date + "</td>" +
                                     "<td class=\"bg_green\">" + myArr[intA].cre_time + "</td>";
                    }
                    document.getElementById("tbody").innerHTML += "<tr>" + "<td>" +
                                                                  "<input onclick=\"singleCheckValue(this)\" id=\"input_" + iNum + "\" style=\"margin:0 40%;\" type=\"checkbox\" name=\"c\" value=\"\">" +
                                                                  "</td>" + tdHtml + "</tr>";
                    //數input數
                    iNum++;
                }
            }
            //數0的話 給沒有未審核資料 字樣
            if (iNum == 0) 
            {
                document.getElementById("ShowText").style.display = "block";
            }
        }
    };
    xmlhttp.open("GET", "http://" + window.location.host + "/TestCalendar/JSON.ashx", true);
    xmlhttp.send(); 
    //全選的按鈕 把所有checkbox name為c的 都勾起
    function check_all(obj, checkboxName) 
    {
        var checkboxs = document.getElementsByName(checkboxName);
        for (var intA = 0; intA < checkboxs.length; intA++) 
        {
            checkboxs[intA].checked = obj.checked;
        }
    }
    function removeA(arr) 
    {

        var what, a = arguments, L = a.length, ax;

        while (L > 1 && arr.length) 
        {

            what = a[--L];

            while ((ax = arr.indexOf(what)) !== -1) 
            {

                arr.splice(ax, 1);

            }

        }

        return arr;

    }
    var Ser_no_Array = []; 
    function setValue() {
        Ser_no_Array = []; 
        for (var intA = 0; intA < iNum; intA++) {
            if (document.getElementById("input_" + intA).checked) {
                Ser_no_Array.push(document.getElementById("ser_no_" + intA).innerHTML);
                Ser_no_Array.join(",");
                document.getElementById("ShadowValue").value = Ser_no_Array.toString();
            }
        }
    }
    function singleCheckValue(inputobj) 
    {
        var temp = inputobj.id.split('_');
        if (document.getElementById(inputobj.id).checked == false) 
        {
            removeA(Ser_no_Array, document.getElementById("ser_no" + "_" + temp[1]).innerHTML);
            document.getElementById("ShadowValue").value = Ser_no_Array.toString();
        }
        if (document.getElementById(inputobj.id).checked == true) 
        {
            Ser_no_Array.push(document.getElementById("ser_no" + "_" + temp[1]).innerHTML);
            document.getElementById("ShadowValue").value = Ser_no_Array.toString();
        }
    }
</script>

</html>