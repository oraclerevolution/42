var Places;
var arr;
var tenmin;
var twosec;
var continueCountdown;
var i;
var current;
var currentID;
var currentDate;
var TurboText;
var turboButton;
var RightNow;


function RefreshPage() {
    location.reload();
}

function SetBlack(element) {
	element.style.color = "black";
}

function getCookieValue(cookieName){
	var startPos;
	var endPos;
	
	startPos = document.cookie.indexOf(cookieName + "=");
	
	if(startPos == -1)
		return "";
	
	startPos += cookieName.length + 1;
	endPos = document.cookie.substring(startPos).indexOf(";");
	return (endPos == -1) ? (document.cookie.substring(startPos)) : (document.cookie.substring(startPos, endPos + startPos));
}

function Countdown(number) {
    if (number > 0 && continueCountdown) {
		turboButton.innerText = TurboText + " (" + number + "s)";
		setTimeout(Countdown, 1000, number - 1);
	}
	else if (continueCountdown)
		RefreshPage();
}

function Turbo() {
	if (getCookieValue("turbo") === "") 
		document.cookie = "turbo=1";
	else
		document.cookie = "turbo=0;expires=" + RightNow;
	RefreshPage();
}

function RemoveAlert() {
	document.cookie = "playsound=0;expires=" + RightNow;
	document.cookie = "alert=0;expires=" + RightNow;
	RefreshPage();
}

function stopCountdown() {
	continueCountdown = false;
	turboButton.innerText = TurboText;
}

function getElementIndex(node) {
    var index;
	
	index = 0;
    while ((node = node.previousElementSibling)) {
        index++;
    }
    return index;
}


function Init() {
	Places 				= document.querySelectorAll(".span12 table.table-hover tr td:nth-child(2)");
	current 			= document.querySelector("table .btn.btn-primary").parentElement.parentElement;
	currentDate 		= current.querySelector("td:nth-child(1)").innerText;
	arr 				= [];
	tenmin 				= new Date();
	twosec 				= new Date();
	tenmin.setTime(tenmin.getTime() + (60000 * 15));
	twosec.setTime(twosec.getTime() + (20000));
	continueCountdown 	= true;
	TurboText 			= (getCookieValue("turbo") === "") ? ("Turbo") : ("Slow down");
	RightNow 			= (new Date()).toUTCString();
	
	if (document.querySelectorAll("table .btn.btn-primary").length > 1)
		current = document.querySelector("head");
	for(var i = Places.length; i--; arr.unshift(Places[i]));
	if (current != document.querySelector("head"))
	{
		current.style.outline = "rgb(129, 129, 129) solid 2px";
		current.querySelectorAll("td").forEach(function(e) {e.style.border = "none";});
		currentID = parseInt(arr.indexOf(current.querySelector("td:nth-child(2)")));
	}
	else
		currentID = -1;
	if (currentID <= 0) {
		currentDate = "";
		currentID = Places.length - 1;
	}
	else if (currentID > getElementIndex(current))
		currentID = getElementIndex(current);
	
	var notice;
	var customTitle;
	var display;
	
	current.scrollIntoView();
	display = "";
	if (currentDate !== "")
		document.title = currentDate;
	
	notice 				= document.querySelector("#false");
	notice.outerHTML 	= notice.outerHTML + '<h1 id="custom-title" style="font-size: 65px;">' + currentDate + '</h1>';
	
	if (currentID == Places.length - 1)
		display = 'style="display: none;"';
	customTitle 			= document.querySelector("#custom-title");
	customTitle.outerHTML 	= customTitle.outerHTML + '<button class="btn" ' + display + ' onclick="Turbo()" id="turbo">'+ TurboText + '</button>';
	
	turboButton = document.querySelector("#turbo");
	if (getCookieValue("alert") !== "" || getCookieValue("playsound") !== "") 
		turboButton.outerHTML = turboButton.outerHTML + ' <button class="btn" onclick="RemoveAlert()">Remove alerts</button>';
	turboButton = document.querySelector("#turbo");
	
	if (getCookieValue("playsound") !== "")
		new Audio('http://noproblo.dayjo.org/ZeldaSounds/WW_New/WW_Get_Item.wav').play();
	
	if (getCookieValue("alert") !== "") {
		customTitle 					= document.querySelector("#custom-title");
		customTitle.style.background 	= "yellow";
		customTitle.style.lineHeight	= "60px";
		document.title				 	= "(1) " + currentDate;
	}
	
	Countdown(getCookieValue("turbo") === "" ? (15) : (5));
	
	checkFreeCheckin();
	updateCheckinStats(0);
}
Init();


function checkFreeCheckin() {
	for(i = 0; i <= currentID; i++)
	{
		var nbrPlaces;
		var parent;
		
		nbrPlaces 	= parseInt(Places[i].innerText);
		parent 		= Places[i].parentElement;
		if (parent != current && nbrPlaces <= 10)
		{
			if (parent.querySelector(":nth-child(5)").innerText === "")
				document.querySelector("table .btn.btn-primary").click();
			else {
				parent.querySelector(":nth-child(5) a").click();
				document.cookie = "playsound=1;expires=" + twosec.toUTCString();
				document.cookie = "alert=1;expires=" + tenmin.toUTCString();
			}
			break;
		}
		else if (parent != current)
		{
			parent.style.opacity = 1 - (0.35 * (i / 3));
			parent.querySelectorAll("td").forEach(SetBlack);
		}
	}
}

function updateCheckinStats(x = -1) {
	if (x != -1)
		i = x;
	while (i < Places.length)
	{
		var oldNbr;
		var newNbr;
		var newText;
		var newColor;
		
		oldNbr 						= parseInt(getCookieValue("p" + i));
		newNbr 						= parseInt(Places[i].innerText);
		document.cookie 			= "p" + i + "=" + newNbr;
		Places[i].style.opacity		= 0.7;
		newText 					= "";
		newColor 					= "grey";
		
		if (oldNbr > newNbr || (isNaN(newNbr) && oldNbr > 0) || getCookieValue("c" + i) == "1")
		{
			if (oldNbr > newNbr || (isNaN(newNbr) && oldNbr > 0))
				document.cookie = "c" + i + "=1;expires=" + tenmin.toUTCString();
			newText  = "▼ ";
			newColor = "red";
		}
		else if (oldNbr < newNbr || (newNbr > 0 && isNaN(oldNbr)) || getCookieValue("c" + i) == "2")
		{
			if (oldNbr < newNbr || (newNbr > 0 && isNaN(oldNbr)))
				document.cookie = "c" + i + "=2;expires=" + tenmin.toUTCString();
			newText  = "▲ ";
			newColor = "green";
		}
		else
			newColor = "grey";
		
		Places[i].innerText		= newText + Places[i].innerText;
		Places[i].style.color 	= newColor;
		i++;
	}
}
