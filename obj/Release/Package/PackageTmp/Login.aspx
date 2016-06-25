<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KPISystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login PSP</title>
    <style>
        .contact {
            padding-left: 88%;
            padding-right: 0px;
            padding-bottom: 30px;
            margin-top: -55px;
            color: #000066;
            font-family: 'Segoe UI';
        }

        .title {
            width: 300px;
            padding-top: 10px;
            padding-left: 20px;
            color: #000066;
            font-family: 'Segoe UI';
            font-size: small;
        }

        .dt {
            color: black;
        }

        .form_login {
            text-align: center;
        }

        .sign {
            padding: 10px 0 0 0;
            text-decoration: none;
        }

        .image {
            padding: 0 20px 0 68%;
            margin: -190px 0 0 0;
        }

        .label_title {
            font-family: 'Segoe UI';
            font-size: 30px;
            font-style: normal;
            margin: 50px 70px -20px 140px;
        }

        .label_body {
            font-family: 'Segoe UI';
            font-size: 15px;
            font-style: normal;
            margin: 40px 0 0 140px;
        }

        .label_two {
            font-family: 'Segoe UI';
            font-size: 15px;
            font-style: normal;
            margin: 20px 0 0 140px;
        }

        .label_three {
            font-family: 'Segoe UI';
            font-size: 15px;
            font-style: normal;
            margin: 20px 0 0 140px;
        }

        .span_font {
            margin: 20px 0 20px 0;
            font-size: 20px;
        }

        .dt_font {
            margin: 50px 0 0 0;
            color: black;
        }

        #code {
            font-family: Arial;
            font-style: italic;
            font-weight: bold;
            border: 0;
            letter-spacing: 2px;
            color: blue;
        }
    </style>
     <script type="text/javascript" src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="layer-v2.2/layer/layer.js"></script> 
    <script>
        function Windowload() {
            var totalWidth = Document.clientWidth;
            document.getElementById(Left).width = totalWidth * 0.5;
        }
        var code;//在全局定义验证码
        //产生验证码
        //window.onload = function createCode() {
        //    code = "";
        //    var codeLength = 4;//验证码的长度
        //    var checkCode = document.getElementById("code");
        //    var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
        //    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//随机数
        //    for (var i = 0; i < codeLength; i++) {//循环操作
        //        var index = Math.floor(Math.random() * 36);//取得随机数的索引（0~35）
        //        code += random[index];//根据索引取得随机数加到code上
        //    }
        //    checkCode.value = code;//把code值赋给验证码
        //};

        function createCode() {
            code = "";
            var codeLength = 4;//验证码的长度
            var checkCode = document.getElementById("code");
            var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
            'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//随机数
            for (var i = 0; i < codeLength; i++) {//循环操作
                var index = Math.floor(Math.random() * 36);//取得随机数的索引（0~35）
                code += random[index];//根据索引取得随机数加到code上
            }
            checkCode.value = code;//把code值赋给验证码
        }
 
        function check(str) {
            validate(str);
        }

        //校验验证码
        function validate(str) {
            if ($("#account").val() == "") {
                layer.tips('账户不能为空！', $("#account"));
                return false;
            }
            else if (str == "") {
                layer.tips('密码不能为空！', $("#pwd"));
                return false;
            }
            else {
                var inputCode = $("#input").val().toUpperCase();//取得输入的验证码并转化为大写
                if (inputCode.length <= 0) {//若输入的验证码长度为0
                    layer.tips('验证码不能为空！', $("#input"));//则弹出请输入验证码
                    document.getElementById("account").value = "";//清空文本框
                }
                    else if (inputCode != str) {//若输入的验证码与产生的验证码不一致时
                        layer.tips('验证码输入错误！', $("#input"));
                        createCode();//刷新验证码
                        document.getElementById("input").value = "";//清空文本框
                        document.getElementById("account").value = "";//清空文本框
                    }
                else {//输入正确时
                    // alert("^-^");//弹出^-^
                }
            }         
        }



    </script>
</head>
<body runat="server">
    <div style="height: 50px; width: 100%; margin-top: 20px;">
        <asp:Label CssClass="title" runat="server" Text="titile" Font-Size="20px"><b>PSP Evaluation System</b></asp:Label>
        <%--<asp:Label CssClass="contact" ID="Contact" runat="server" Text="Contact"></asp:Label>--%>
        <embed name="honehoneclock" class="contact" width="160" height="70" align="middle" pluginspage="http://www.macromedia.com/go/getflashplayer" src="http://chabudai.sakura.ne.jp/blogparts/honehoneclock/honehone_clock_tr.swf" type="application/x-shockwave-flash" allowscriptaccess="always" bgcolor="#ffffff" quality="high" wmode="transparent">
    </div>
    <hr class="dt" />
    <div runat="server" id="Left" style="float: left; display: inline; width: 48%">
        <div class="label_title" style="color: #99ccff;">
            <b>Evaluation system&nbsp;,<br />
                Work efficiently&nbsp;!</b>
        </div>
        <p class="label_body">The evaluation of a system&nbsp;, </p>
        <p class="label_two">where we will find their usual work&nbsp;,</p>
        <p class="label_three">happy coding everyday&nbsp;!</p>
        <asp:Image runat="server" CssClass="image" ImageUrl="~/Images/QQQ.png" />
    </div>
    <div style="height: 500px; display: inline; margin-left: 10px">
        <form runat="server" id="right" class="form_login" style="width: 330px; height: 350px; border: 1px solid #66cc99; margin: 100px 0px 0 60%;">
            <div style="border-color: gray; border: 1px; height: 15px; font-family: 'Segoe UI'; margin: 20px 0 15px 0">
                <label style="width: 200px; height: 100px;"><b>Login</b></label>
            </div>
            <hr style="border: 0.7px solid #66cc99;" />
            <div style="margin-top: 20px">
                <input runat="server" id="account" style="width: 200px; height: 30px; border: 1px solid #66cc99" placeholder="账号" />
            </div>
            <div style="margin-top: 20px">
                <input runat="server" id="pwd" type="password" style="width: 200px; height: 30px; border: 1px solid #66cc99" placeholder="密码" />
            </div>
            <div style="margin-top: 20px">
                <input runat="server" maxlength="5" type="text" id="input" class="input" style="width: 143px; height: 30px; border: 1px solid #66cc99"  placeholder="验证码" />
                <input runat="server" type="button" id="code" style="width: 57px; height: 30px;" value="PXNF" onclick="createCode()" />
            </div>
            <%--<div style="margin:20px 0 0 0"><a runat="server" style="width:200px;height:30px;background-color:#9999ff;font-family:'Segoe UI';font-size:15px;">Sign In</a> </div>--%>
            <div style="margin: 20px 0 0 0">
                <asp:LinkButton OnClick="login" runat="server" ID="Label_onclick" CssClass="sign" Width="200px" Height="30px" BackColor="#9999ff" ForeColor="#ffffff" Font-Bold="true" Text="Sign In" />
            </div>
        </form>
    </div>
    <footer>
        <hr class="dt_font" />
        <div style="text-align: center; margin: 20px 0 0 0">
            <span class="span_font" align="center">@南京邮电大学通达学院</span>
        </div>

    </footer>
</body>


</html>
