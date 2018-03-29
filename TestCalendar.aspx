<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestCalendar.aspx.cs" Inherits="TestCalendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <title> 外出日曆-Calendar </title>
<!--Css區塊-->
<style>

html
{
    background-color:#eee;
}
.btn
{
    cursor:pointer;
    font-size:15px;
    padding: 5px 15px 5px 15px;
    margin: 0 10px 0 10px;
    border: 2px solid #dddddd;
    color: white;
    border-color: #50b584;
    background-color: #50b584;
}
body
{
    width:100%;
    margin:auto;
    padding:0;
    height:960px;
}
.days {
    background: #eee;
    margin: 0;
    float: left;
    width: 100%;
}

.daysContent 
{
    cursor:pointer;
    width: 13.9%;
    height:200px;
    border:1px dotted;
    text-align: center;
    font-size:20px;
    color: #777;
    float: left;
    margin-left:1px;
}
.daysDetailsYellow
{
    cursor:pointer;
    font-size:16px;
    text-align: left;
    text-indent: 10px;
    font-weight:bold;
    background-color:#ffef99;
    margin:5px 0 5px 0;    
    }
.daysDetailsGreen
{
    cursor:pointer;
    font-size:16px;
    text-align: left;
    text-indent: 10px;
    font-weight:bold;
    background-color:#c6e589;
    margin:5px 0 5px 0; 
}    
     
.day_inform_input {
  width: 60%;
  padding: 2px 0 2px 10px;
  font-size:14px;
  font-weight: 400;
  color: #377D6A;
  background: #efefef;
  border: 0;
  border-radius: 3px;
  transition: all .5s ease-in-out;
 }
.day_inform 
{
    display:none;
    position: absolute; 
	margin: auto;
	background: #fff;
	padding: 5px;
	border: 5px solid #aaa;
	border-radius: 10px;
	text-align: center;
	 z-index:100;
}
#day_inform_left_label div
{
    margin: 15% 0 15% 0;
}
#day_inform_right_label div
{
    margin: 15% 0 15% 0;
}
#day_inform_left_input input
{
    margin: 4% 0 0 0;
}
#day_inform_right_input input
{
    margin: 4% 0 0 0;
}
.month 
{
    border: 1px solid #eee;
    padding: 20px 0 20px 0;
    width: 100%;
    background: #1abc9c;
}

.month ul {
    margin: 0;
    padding: 0;
    list-style-type:none; /*去點用的*/
}

.month ul li 
{
    color: white;
    font-size: 20px;
    text-transform: uppercase;
    letter-spacing: 3px;
}

.month .prev 
{
    display:inline-block;
    padding-top: 10px;
    cursor:pointer;
}

.month .next 
{
    display:inline-block;
    padding-top: 10px;
    cursor:pointer;
}
.triangle
{
   width: 0;
   height: 0;
   border: 9px solid #aaa;
   border-left-color: transparent;
   border-bottom-color: transparent;
   border-right-color: transparent;
   position:absolute; 
}
.weekdays 
{
    width:100%;
    margin: 0;
    padding: 15px 0 15px 0;
    background-color: #ddd;
}

.weekdays li {
    display: inline-block;
    width: 13.9%;
    color: #666;
    text-align: center;
}
@media screen and (max-width: 980px) {
body 
{
    width:980px;
}  
    </style>
</head>
<body onload="ChangeValue()">
    <form id="form1" runat="server">
        <div class="month">      
          <ul style="text-align:center; letter-spacing:10px;">
            <li id="CalendarPrev" onclick="MonthPrev(),ChangeValue()" style="font-size:18px; padding-left:30px;" class="prev" runat="server"><b>上個月</b></li>
            <li id="CalendarTitle" style="display:inline-block; font-size:24px;text-align:center; padding:15px 0 15px 0;" runat="server"></li>
            <li id="CalendarNext" onclick="MonthNext(),ChangeValue()" style="font-size:18px; padding-right:30px;" class="next" runat="server"><b>下個月</b></li>
          </ul>
        </div>
        <div>
            <ul class="weekdays">
                <li>週日</li>
                <li>週一</li>
                <li>週二</li>
                <li>週三</li>
                <li>週四</li>
                <li>週五</li>
                <li>週六</li>
            </ul>
            <div id="CalendarValue" runat="server" class="days">
            </div>
        </div>
        <div id="day_inform" class="day_inform" style="width:500px;height:155px;" runat="server">
            <div id="day_inform_left_label" style="font-size:12px; width:15%; margin: 0 auto;float:left;">
                <div>工程師: </div>
                <div style="color:Red" >客戶*: </div>
                <div style="color:Red">出差時間-起*: </div>
                <div>出差時間-訖: </div>
            </div >
            <div id="day_inform_left_input" style="width:35%; margin: 0 auto;float:left;">
                <input id="per_name" class="day_inform_input" name="工程師" style="background-color:#bfbfbf;" type="text" runat="server" autocomplete="off" readonly />
                <input onblur="checkValue(this,'checkspace')" id="apc_name" name="客戶" class="day_inform_input" type="text" runat="server" autocomplete="off"  />
                <input onblur="checkValue(this,'checkspace'),checkInputTimeFormat(this.id)" id="travel_time1" name="出差時間-起" class="day_inform_input" placeholder="HH:mm" type="text" runat="server" autocomplete="off"  />
                <input onblur="checkValue(this,''),checkInputTimeFormat(this.id)" id="travel_time2" name="出差時間-訖" class="day_inform_input" placeholder="HH:mm" type="text" runat="server" autocomplete="off" />                                                            
            </div>
                <div id="day_inform_right_label" style="font-size:12px;width:15%; margin: 0 auto;float:left;">
                <div>案號: </div>
                <div>地點: </div>
                <div>出差日期-起: </div>
                <div>出差日期-訖: </div>
            </div>
            <div id="day_inform_right_input" style="width:35%; margin: 0 auto;float:left;">
                <input id="ser_no" style="display:none;" name="識別碼" type="text" runat="server" /> 
                <input id="usr_code" style="display:none;" name="建立者" type="text" runat="server"  />               
                <input onblur="checkValue(this,'')" id="our_ref" class="day_inform_input" name="案號" type="text" runat="server" autocomplete="off" />
                <input onblur="checkValue(this,'')" id="travel_location" class="day_inform_input" name="地點" type="text" runat="server" autocomplete="off" />
                <input id="travel_date1" class="day_inform_input" name="出差日期-起" style="background-color:#bfbfbf;" type="text" runat="server" readonly autocomplete="off" />
                <input onblur="checkValue(this,''),checkInputDateFormat()" id="travel_date2" class="day_inform_input" name="出差日期-訖" placeholder="YYYY/MM/DD" type="text" runat="server" autocomplete="off" />
            </div>
            <div style="clear:both; margin:10px 0 0 0; text-align: left;">
               <asp:Button CssClass="btn" ID="Sendbtn" OnClientClick="if(!SendtbtnClickCheckValue()) return " UseSubmitBehavior=false runat="server" Text="建立" /> <!--先執行JS 在執行C#-->
               <asp:Button CssClass="btn" ID="Modifybtn" OnClientClick="if(!SendtbtnClickCheckValue()) return " UseSubmitBehavior=false runat="server" Text="修改" />  <!-- button事件執行順序 keydown keypress click submit keyup-->
               <asp:Button CssClass="btn" ID="Deletebtn" UseSubmitBehavior=false runat="server" Text="刪除" />
               <input type="button" value="取消" onclick="cancelDisplay()" class="btn" id="Cancelbtn" /> <!--None Refresh-->
               <div id="PassComment" style="font-size:12px;display:none;">不能變更或刪除</div>
            </div>
            <div id="triangle" class="triangle"></div>
        </div>
    </form>
<!--JS區塊-->
<script type="text/javascript">
    var dt = new Date();
    var TempArray = [];
    if (document.getElementById("CalendarTitle").innerHTML == "") 
    {
        if (dt.getMonth() + 1 < 10) 
        {
            document.getElementById("CalendarTitle").innerHTML = dt.getFullYear() + "/" + "0" + (dt.getMonth() + 1);
        }
        else 
        {
            document.getElementById("CalendarTitle").innerHTML = dt.getFullYear() + "/" + (dt.getMonth() + 1);
        }
    }    
    function SendtbtnClickCheckValue()
    {
        var temp1 = document.getElementById("travel_time1").value.split(':');
        var temp2 = document.getElementById("travel_time2").value.split(':');
        var Hour1 = temp1[0];
        var Minute1 = temp1[1];
        var Hour2 = temp2[0];
        var Minute2 = temp2[1];
        //客戶確認 空白確認
        if (document.getElementById("apc_name").value.length == 0) {
            alert("客戶，不得空白")
            document.getElementById("apc_name").style.background = "#ef6671;";
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) 
            {
                document.getElementById("apc_name").style = "background-color:#ef6671;";
            }
            return false;
        }
        //日期確認
        var date1 = document.getElementById("travel_date1").value;
        var date2 = document.getElementById("travel_date2").value;
        //.getDate()如果不正確的日期 輸出會是1
        if (new Date(date2).getDate() != date2.substring(date2.length - 2) || new Date(date1) > new Date(date2))
        {
            alert("出差日期-訖 輸入錯誤");
            document.getElementById("travel_date2").style.background = "#ef6671;";
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) 
            {
                document.getElementById("travel_date2").style = "background-color: #ef6671;";
            }
            return false;
        }
        //時間1確認
        if (document.getElementById("travel_time1").value.length == 0)
        {
            alert("出差時間-起，不得空白");
            document.getElementById("travel_time1").style.background = "#ef6671;"; //紅色
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null)
            {
                document.getElementById("travel_time1").style = "background-color: #ef6671;";
            }
            return false;
        }
        if (Number(Hour1) < 1 || Number(Hour1) > 23 || document.getElementById("travel_time1").value.indexOf(':') < 0 || Number(Minute1) < 0 || Number(Minute1) > 59) 
        {
            alert("出差時間-起，輸入錯誤");
            document.getElementById("travel_time1").style.background = "#ef6671;"; //紅色
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) 
            {
                document.getElementById("travel_time1").style = "background-color: #ef6671;";
            }
            return false
        }
        if (Hour1.length != 2 || Minute1.length != 2) {
            alert("出差時間-起，輸入錯誤");
             document.getElementById("travel_time1").style.background = "#ef6671;"; //紅色
            //非Google執行下列程式
             if (navigator.userAgent.match("Safari") != null)
              {
                 document.getElementById("travel_time1").style = "background-color: #ef6671;";
             }
            return false;
        }
        //時間2確認
        if (Number(Hour2) < 1 || Number(Hour2) > 23 || document.getElementById("travel_time2").value.indexOf(':') < 0 || Number(Minute2) < 0 || Number(Minute2) > 59 || Number(Hour2) <= Number(Hour1))
        {
            //處理空白 不要出現紅色
            if (document.getElementById("travel_time2").value.length == 0) {
                return true;
            }
            //處理 訖 < 起 的問題
            if (Number(Hour2) < Number(Hour1)) 
            {
                alert("出差時間-訖，輸入錯誤");
                return false;
                if (Number(Hour2) == Number(Hour1) && Number(Minute2) < Number(Minute1)) 
                {
                    alert("出差時間-訖，輸入錯誤");
                    return false;
                }
            }
            if (Number(Hour2) == Number(Hour1) && Number(Minute2) > Number(Minute1)) {
                return true;
            }
            alert("出差時間-訖，輸入錯誤");
            document.getElementById("travel_time2").style.background = "#ef6671;";
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) 
            {
                document.getElementById("travel_time2").style = "background-color: #ef6671;";
            }
            return false;
        }

        if (Hour2.length != 2 || Minute2.length != 2) 
        {
            alert("出差時間-訖，輸入錯誤");
            document.getElementById("travel_time2").style.background = "#ef6671;";
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) 
            {
                document.getElementById("travel_time2").style = "background-color: #ef6671;";
            }
            return false;
        }
        else
        {
            return true;
        }
    }
    //取消Button Enter預設
    function TriggeredKey(e) 
    {
        if (window.event.keyCode == 13) return false;
    }
    //每個日期格都會點擊呼叫
    function allpageClickEvent(evnt) 
    {
        var myX;
        var myY;
        if (window.Event) 
        {
        //firefox
            myX = evnt.pageX;
            myY = evnt.pageY;
        }
        else 
        { 
        // IE
            myX = event.x + document.body.scrollLeft;
            myY = event.y + document.body.scrollTop;
        }
        //輸入畫面視窗位置
        var width = document.getElementById("day_inform").style.width;
        var height = document.getElementById("day_inform").style.height;
        document.getElementById("day_inform").style.display = "block";
        document.getElementById("apc_name").focus();
        //未加溢位條件 後面家的數字 都是Margin,padding,border 的寬度 
        document.getElementById("day_inform").style.top = myY - (Number(height.substring(0, (height.length - 2))) + 30) + "px";
        document.getElementById("day_inform").style.left = myX - (Number(width.substring(0, (width.length - 2))) / 2 + 12) + "px";
        document.getElementById("triangle").style.left = (Number(width.substring(0, (width.length - 2))) / 2) + "px";
        document.getElementById("triangle").style.top = (Number(height.substring(0, (height.length - 2))) + 15) + "px";
        //溢位處置
        if (myX - (Number(width.substring(0, (width.length - 2))) / 2) < 0) 
        {
            document.getElementById("day_inform").style.left = 0 + "px";
            document.getElementById("triangle").style.left = myX + "px";
        }
        if (myX + Number(width.substring(0, (width.length - 2))) > document.body.clientWidth) 
        {
            document.getElementById("day_inform").style.left = document.body.clientWidth - Number(width.substring(0, (width.length - 2))) - 40 + "px"; //40 margin+padding 的寬度
            document.getElementById("triangle").style.left = Number(width.substring(0, (width.length - 2))) + 30 - (document.body.clientWidth - myX) + "px";
        }
    }
    //日期往前 應對中間日期變更
    function MonthPrev() 
    {
        var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
        if (CalendarTitle[1] < 2) 
        {
            CalendarTitle[1] = 12;
            document.getElementById("CalendarTitle").innerHTML = Number(CalendarTitle[0]) - 1 + "/" + (Number(CalendarTitle[1]));
            if (CalendarTitle[1] < 11) 
            {
                document.getElementById("CalendarTitle").innerHTML = Number(CalendarTitle[0]) - 1 + "/" + "0" + (Number(CalendarTitle[1]));
            }
        }
        else 
        {
            document.getElementById("CalendarTitle").innerHTML = CalendarTitle[0] + "/" + (Number(CalendarTitle[1]) - 1);
            if (CalendarTitle[1] < 11) 
            {
                document.getElementById("CalendarTitle").innerHTML = CalendarTitle[0] + "/" + "0" + (Number(CalendarTitle[1]) - 1);
            }
        }
    }
    //日期往後 應對中間日期變更
    function MonthNext()
    {
        var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
        if (CalendarTitle[1] > 11)
        {
            CalendarTitle[1] = 1;
            document.getElementById("CalendarTitle").innerHTML = Number(CalendarTitle[0]) + 1 + "/" + "0" + (Number(CalendarTitle[1]));
        }
        else 
        {
            document.getElementById("CalendarTitle").innerHTML = CalendarTitle[0] + "/" + (Number(CalendarTitle[1]) + 1);
            if (CalendarTitle[1] < 9)
            {
                document.getElementById("CalendarTitle").innerHTML = CalendarTitle[0] + "/" + "0" + (Number(CalendarTitle[1]) + 1);
            }
        }
    }
    //每次按下 <<,>>,body onload 就會呼叫 內有AJAX觸動就會更新資料
    function ChangeValue() 
    {
        if (document.getElementById("day_inform").style.display == "block")
        {
            document.getElementById("day_inform").style.display = "";
        }
        //初始當月日期
        var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
        var d = new Date(document.getElementById("CalendarTitle").innerHTML + "/01");
        var sHtml = "";
        //加每月日期空格
        for (var intA = 0; intA < d.getDay(); intA++) 
        {
            sHtml += "<div class=\"daysContent\">" + "</div>";
        }
        //填入真的日期                
        for (var intA = 1; intA < new Date(CalendarTitle[0], CalendarTitle[1], 0).getDate() + 1; intA++) 
        {
            if (intA < 10 && Number(CalendarTitle[1]) < 10)
            {
                sHtml += "<div style=\"overflow:auto;\" onmousedown=\"cancelDisplay()\" onmouseup=\"SetDayInform(" + intA + "),allpageClickEvent(event)\" class=\"daysContent\" id=" + CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + "0" + intA + " " + " >" +
                     "<div  style=\"cursor:pointer;text-align:center;\">" + "0" + intA + "</div>" + "</div>";
            }
            if (intA < 10 && Number(CalendarTitle[1]) >= 10) 
            {
                sHtml += "<div style=\"overflow:auto;\" onmousedown=\"cancelDisplay()\" onmouseup=\"SetDayInform(" + intA + "),allpageClickEvent(event)\" class=\"daysContent\" id=" + CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + "0" + intA + " " + " >" +
                    "<div style=\"cursor:pointer;text-align:center;\">" + "0" + intA + "</div>" + "</div>";
            }
            if (intA >= 10 && Number(CalendarTitle[1]) < 10) 
            {
                sHtml += "<div style=\"overflow:auto;\" onmousedown=\"cancelDisplay()\" onmouseup=\"SetDayInform(" + intA + "),allpageClickEvent(event)\" class=\"daysContent\" id=" + CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + intA + " " + " >" +
                    "<div style=\"cursor:pointer;text-align:center;\">" + intA + "</div>" + "</div>";
            }
            if (intA >= 10 && Number(CalendarTitle[1]) >= 10)
            {
                sHtml += "<div style=\"overflow:auto;\" onmousedown=\"cancelDisplay()\" onmouseup=\"SetDayInform(" + intA + "),allpageClickEvent(event)\" class=\"daysContent\" id=" + CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + intA + " " + " >" +
                    "<div style=\"cursor:pointer;text-align:center;\">" + intA + "</div>" + "</div>";
            }
        }
        document.getElementById("CalendarValue").innerHTML = sHtml;
        //1. 可直接給指定日期var d = new Date("2016 12 08") OUTPUT : Thu Dec 08 2016 00:00:00 GMT+0800 (台北標準時間) 還可以直接輸入 ("2016/12/08") or ("2016-12-08") //這裡面要擺文字型態 
        //2. 所以可以直接使用 d.getDay(); = 4(Thu 星期四) 0是sunday
        //3. ex : new Date(2016,12,0).getDate(); 會顯示 2016/12月 有幾天 //裡面要擺數字型態
//        //Jquery AJAX
//        $(function () {
//            $.ajax({
//                type: 'GET',
//                url: 'http://' + window.location.host + '/TestCalendar/JSON.ashx',
//                success: function (data) {
//                    // 成功的話資料就會傳到 data 變數    
//                    //data Object 格式 所以可以不用再用JSON.parse()
//                    //判斷撈到的值是什麼格式
//                    console.log(typeof (data));

//                    // 將撈來的資料轉為 JSON 格式
//                    var myArr = data;
//                    //將內容顯示在網頁上 
//                    myFunction(myArr)
//                }
//            });
//        });
        // JSON AJAX物件 
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange = function () //onreadystatechange	Defines a function to be called when the readyState property changes
        {
            if (this.readyState == 4 && this.status == 200) //4: request finished and response is ready 網頁載入時 readyState會變動 //200: "OK"
            { 
                // 將撈來的資料轉為 JSON 格式
                var myArr = JSON.parse(this.responseText);
                myFunction(myArr); //呼叫myFunction 並傳入myArr Json資料
            }
        };
        xmlhttp.open("GET", "http://" + window.location.host + "/TestCalendar/JSON.ashx", true);
        xmlhttp.send();

        function myFunction(arr) 
        {
            var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
            //最後顯示的出差事件
            for (var intA = 0; intA < arr.length; intA++) 
            {
                var fromDate = new Date(arr[intA].travel_date1);
                var endDate = new Date(arr[intA].travel_date2);
                var date = (endDate - fromDate) / 24 / 3600 / 1000;
                var htmldivId_date2 = arr[intA].travel_date2.split('/');

                for (var intB = 0; intB < date + 1; intB++) 
                {
                    var tempDate = getFormattedDate(fromDate).split('/')
                    if (tempDate[0] + "/" + tempDate[1] == CalendarTitle[0] + "/" + CalendarTitle[1]) {
                        if (arr[intA].is_check == "Y") 
                        {
                            //識別碼 + 時間起 + 時間訖 + 工程師 +客戶 +案號
                            //                            document.getElementById(getFormattedDate(fromDate)).innerHTML += "<div onclick=\"EditDelete(this)\" id=\"" + arr[intA].travel_date1 + "/" + arr[intA].ser_no +
                            //                                                                                             "\" class=\"daysDetailsGreen\">" + "[" + arr[intA].ser_no + "]" +
                            //                                                                                             arr[intA].travel_time1 + "~" + arr[intA].travel_time2 + " " +
                            //                                                                                             arr[intA].per_name + " " + arr[intA].apc_name + " " + arr[intA].our_ref + "</div>";
                            document.getElementById(getFormattedDate(fromDate)).innerHTML += "<div id=\"" + arr[intA].travel_date1 + "/" + arr[intA].ser_no +
                                                                                             "\" class=\"daysDetailsGreen\" onclick=\"EditDelete(this)\">" + arr[intA].travel_time1 + " " +
                                                                                             arr[intA].per_name + " " + arr[intA].apc_name + " " + arr[intA].our_ref + "</div>";
                        }
                        else 
                        {
                            document.getElementById(getFormattedDate(fromDate)).innerHTML += "<div id=\"" + arr[intA].travel_date1 + "/" + arr[intA].ser_no +
                                                                                             "\" class=\"daysDetailsYellow\" onclick=\"EditDelete(this)\">" + arr[intA].travel_time1 + " " +
                                                                                             arr[intA].per_name + " " + arr[intA].apc_name + " " + arr[intA].our_ref + "</div>";
                        }
                    }
                    fromDate = fromDate.addDays(1);
                }
            }
        }
    }
    //popup區塊,編輯刪除功能 並從AJAX帶入資料進input 
    //AJAX 執行順序 會比SetDayInform() 還要來的慢 如果invoke EditDelete() 順序會是 Edit->Set->AJAX
    function EditDelete(th)
    {
        // JSON AJAX物件
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () //onreadystatechange	Defines a function to be called when the readyState property changes
        {
            if (this.readyState == 4 && this.status == 200) //4: request finished and response is ready 網頁載入時 readyState會變動 //200: "OK"
            {
                // 將撈來的資料轉為 JSON 格式
                var myArr = JSON.parse(this.responseText);
                for (var intA = 0; intA < myArr.length; intA++) {
                    if (th.id == myArr[intA].travel_date1 + "/" + myArr[intA].ser_no) {
                        document.getElementById("usr_code").value = myArr[intA].usr_code;
                        document.getElementById("travel_location").value = myArr[intA].travel_location;
                        document.getElementById("our_ref").value = myArr[intA].our_ref;
                        document.getElementById("travel_date1").value = myArr[intA].travel_date1;
                        document.getElementById("travel_date2").value = myArr[intA].travel_date2;
                        document.getElementById("per_name").value = myArr[intA].per_name;
                        document.getElementById("apc_name").value = myArr[intA].apc_name;
                        document.getElementById("travel_time1").value = myArr[intA].travel_time1;
                        document.getElementById("travel_time2").value = myArr[intA].travel_time2;
                        //按鈕顯示
                        document.getElementById("Sendbtn").style.display = "none";
                        document.getElementById("Modifybtn").style.display = "inline-block";
                        document.getElementById("Deletebtn").style.display = "inline-block";
                        if (th.className == "daysDetailsYellow") {
                            document.getElementById("Modifybtn").style.display = "inline-block";
                            document.getElementById("Deletebtn").style.display = "inline-block";
                        }
                        if (th.className == "daysDetailsGreen") {
                            document.getElementById("Modifybtn").style.display = "none";
                            document.getElementById("Deletebtn").style.display = "none";
                            document.getElementById("PassComment").style.display = "inline-block";
                        }
                    }
                }
            }
        };
        xmlhttp.open("GET", "http://" + window.location.host + "/TestCalendar/JSON.ashx", true);
        xmlhttp.send();

        var ser_no = th.id.split('/');
        document.getElementById("day_inform").style.display = "block";

        document.getElementById("ser_no").value = ser_no[3]; // "ser_no" 在前端是隱藏
    }
    //顯示popup 區塊
    function SetDayInform(divId) 
    {
        //把顏色歸零
        document.getElementById("usr_code").style.background = "#efefef";
        document.getElementById("travel_location").style.background = "#efefef";
        document.getElementById("our_ref").style.background = "#efefef";
        document.getElementById("travel_date2").style.background = "#efefef";
        document.getElementById("apc_name").style.background = "#efefef";
        document.getElementById("travel_time1").style.background = "#efefef";
        document.getElementById("travel_time2").style.background = "#efefef";
        //呼叫把值清空
        document.getElementById("usr_code").value = "";
        document.getElementById("travel_location").value = "";
        document.getElementById("our_ref").value = "";
        document.getElementById("travel_date1").value = "";
        document.getElementById("travel_date2").value = "";
        document.getElementById("per_name").value = "";
        document.getElementById("apc_name").value = "";
        document.getElementById("travel_time1").value = "";
        document.getElementById("travel_time2").value = "";
        //呼叫出現
        document.getElementById("day_inform").style.display = "block";
        //按鈕顯示
        document.getElementById("Sendbtn").style.display = "inline-block";
        document.getElementById("Modifybtn").style.display = "none";
        document.getElementById("Deletebtn").style.display = "none";
        var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
        divId = divId < 10 ? '0' + divId : divId;
        document.getElementById("travel_date1").value = CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + divId;
        document.getElementById("travel_date2").value = CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + divId;
        //全域宣告 重整後會更新
        TempArray.push(divId);
        for (var intA = 0; intA < TempArray.length; intA++) 
        {
            //只有最後一個要填粉紅色
            if (intA == TempArray.length - 1) 
            {
                //選取後日期格顏色
                document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style.background = "#fee;";
                document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style.overflow = "auto;";
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) {
                    document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style = "overflow:auto;background-color:#fee;";
                }
            }
            //其餘變回灰色
            else 
            {
                //選取後日期格顏色
                document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style.background = "#eee;";
                document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style.overflow = "auto;";
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) {
                    document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[intA]).style = "overflow:auto;background-color:#eee;";
                }
            }
        }
    }
    //日期的add函式 可加入變成Date型別的方法
    Date.prototype.addDays = function (days)
    {
        var dat = new Date(this.valueOf()); //這邊的this 代表著 原本Date的物件 然後.valueof() 就是承接呼叫.addDays之前的Date物件值
        dat.setDate(dat.getDate() + days);
        return dat;
    }
    //轉換日期成 yyyy/mm/dd
    function getFormattedDate(date) 
    {
        var year = date.getFullYear();
        var month = (1 + date.getMonth()).toString();
        month = month.length > 1 ? month : '0' + month;
        var day = date.getDate().toString();
        day = day.length > 1 ? day : '0' + day;
        return year + '/' + month + '/' + day;
    }
    //空值檢查並給紅色顏色
    function checkValue(inputObj,checkspace) 
    {    
        //空值檢查
        if (inputObj.value.length == 0 && checkspace == "checkspace") 
        {
            document.getElementById(inputObj.id).style.background = "#ef6671;"; //紅色
            //非Google執行下列程式
            if (navigator.userAgent.match("Safari") != null) {
                document.getElementById(inputObj.id).style = "background-color:#ef6671;";
            }
        }
        else 
        {
            if (inputObj.value.length != 0)
            { 
                document.getElementById(inputObj.id).style.background = "#efefef;"; //黃色
                if (navigator.userAgent.match("Safari") != null) 
                {
                    document.getElementById(inputObj.id).style = "background-color:#efefef;";
                }
            }
        }
    }
    //檢查日期 Input格式
    function checkInputDateFormat() 
    {
        var date1 = document.getElementById("travel_date1").value;
        var date2 = document.getElementById("travel_date2").value;

        //如果沒輸入/ ，加入/
        if (date2.length == 8) 
        {
            document.getElementById("travel_date2").value = date2.substring(0, 4) + "/" + date2.substring(4, 6) + "/" + date2.substring(6, date2.length);
            date2 = document.getElementById("travel_date2").value;
        }
        //.getDate()如果不正確的日期 會是1
        if (new Date(date2).getDate() != date2.substring(date2.length - 2) || new Date(date1) > new Date(date2)) {

            if (date2 == "") 
            {
                document.getElementById("travel_date2").style.background = "#efefef;"; //灰色
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) 
                {
                    document.getElementById("travel_date2").style = "background-color: #efefef;";
                }
                document.getElementById("travel_date2").value = date1;
            }
            else {
                document.getElementById("travel_date2").style.background = "#ef6671;";
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) {
                    document.getElementById("travel_date2").style = "background-color: #ef6671;";
                }
            }
        }
    }
    //檢查時間 Input格式
    function checkInputTimeFormat(thid) {
        //如果沒加入:，加入:
        if (document.getElementById(thid).value.indexOf(':') < 0 && document.getElementById(thid).value.length == 4) {
            document.getElementById(thid).value = document.getElementById(thid).value.substring(0, 2) + ":" +
                document.getElementById(thid).value.substring(2, document.getElementById(thid).value.length);
        }
        var temp1 = document.getElementById("travel_time1").value.split(':');
        var temp2 = document.getElementById("travel_time2").value.split(':');
        var Hour1 = temp1[0];
        var Minute1 = temp1[1];
        var Hour2 = temp2[0];
        var Minute2 = temp2[1];
        if (thid == "travel_time1") {
            if (Number(Hour1) < 1 || Number(Hour1) > 23 ||document.getElementById("travel_time1").value.indexOf(':') < 0 || Number(Minute1) < 0 || Number(Minute1) > 59) {
                document.getElementById("travel_time1").style.background = "#ef6671;";//紅色
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) {
                    document.getElementById("travel_time1").style = "background-color: #ef6671;";
                }
            }
            //防止只打兩個數字
            else if (Hour1 == undefined || Minute1 == undefined) 
            {
                document.getElementById("travel_time1").style.background = "#ef6671;"; //紅色
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) {
                    document.getElementById("travel_time1").style = "background-color: #ef6671;";
                }
            }
            //一定要是 HH:MM
            else if (Hour1.length!=2 || Minute1.length!=2) {
                document.getElementById("travel_time1").style.background = "#ef6671;"; //紅色
                //非Google執行下列程式
                if (navigator.userAgent.match("Safari") != null) 
                {
                    document.getElementById("travel_time1").style = "background-color: #ef6671;";
                }
            }
        }
        if (thid == "travel_time2") {
            if (Number(Hour2) < 1 || Number(Hour2) > 23 || document.getElementById("travel_time2").value.indexOf(':') < 0 || Number(Minute2) < 0 || Number(Minute2) > 59 || Number(Hour2) <= Number(Hour1)) 
            {
                if (Number(Hour2) == Number(Hour1) && Number(Minute2) > Number(Minute1))
                {
                    document.getElementById("travel_time2").style.background = "#efefef;"; //灰色
                    //非Google執行下列程式
                    if (navigator.userAgent.match("Safari") != null) 
                    {
                        document.getElementById("travel_time2").style = "background-color: #efefef;";
                    }
                }

                else if (document.getElementById("travel_time2").value == "")
                {
                    document.getElementById("travel_time2").style.background = "#efefef;"; //灰色
                    //非Google執行下列程式
                    if (navigator.userAgent.match("Safari") != null)
                    {
                        document.getElementById("travel_time2").style = "background-color: #efefef;";
                    }
                }
                //防止只打兩個數字
                else if (Hour2 == undefined || Minute2 == undefined) 
                {
                    document.getElementById("travel_time2").style.background = "#ef6671;"; //紅色
                    //非Google執行下列程式
                    if (navigator.userAgent.match("Safari") != null) {
                        document.getElementById("travel_time2").style = "background-color: #ef6671;";
                    }
                }
                //一定要是 HH:MM
                else if (Hour2.length != 2 || Minute2.length != 2) 
                {
                    document.getElementById("travel_time2").style.background = "#ef6671;"; //紅色
                    //非Google執行下列程式
                    if (navigator.userAgent.match("Safari") != null) 
                    {
                        document.getElementById("travel_time2").style = "background-color: #ef6671;";
                    }
                }
                else 
                {
                    document.getElementById("travel_time2").style.background = "#ef6671;"; //紅色
                    //非Google執行下列程式
                    if (navigator.userAgent.match("Safari") != null)
                     {
                        document.getElementById("travel_time2").style = "background-color: #ef6671;";
                    }
                } 
            }
        }
    }
    //取消輸入畫面顯示
    function cancelDisplay()
    {
        var CalendarTitle = document.getElementById("CalendarTitle").innerHTML.split('/');
        document.getElementById("day_inform").style.display = "none";
        if (TempArray.length > 1) 
        {
            document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[TempArray.length - 1]).style.background = "#eee;";
            document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[TempArray.length - 1]).style.overflow = "auto;";
        }
        //非Google執行下列程式
        if (navigator.userAgent.match("Safari") != null) {
            if (TempArray.length > 1) {
                document.getElementById(CalendarTitle[0] + "/" + CalendarTitle[1] + "/" + TempArray[TempArray.length - 1]).style = "overflow:auto;background-color:#eee;";
            }
        }
    }
</script>
</body>
</html>