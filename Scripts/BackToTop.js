/**
 * Created by Jacksun on 9/22/2015.
 */

window.onload = function () {
    
    //判断当前浏览器是否为IE
    isIE = Object.hasOwnProperty.call(window, "ActiveXObject") && !window.ActiveXObject ? true : false;

    var topbtn = document.getElementById("btn");
    var timer = null;
    var pagelookheight = document.documentElement.clientHeight;

    
    //document.documentElement.scrollTop适用于IE
    //document.body.scrollTop适用于其他浏览器
    window.onscroll = function () {
        var backtop = isIE ? document.documentElement.scrollTop : document.body.scrollTop;
        if (backtop >= pagelookheight) {
            topbtn.style.display = "block";
        } else {
            topbtn.style.display = "none";
        }
    }

    topbtn.onclick = function () {       
        timer = setInterval(function () {                   
            var backtop = isIE ? document.documentElement.scrollTop : document.body.scrollTop;
            var speedtop = backtop / 5;
            if (isIE) {
                document.documentElement.scrollTop = backtop - speedtop;
            } else {
                document.body.scrollTop = backtop - speedtop;
            }
            if (backtop == 0) {
                clearInterval(timer);
            }
        }, 30);
    }
}