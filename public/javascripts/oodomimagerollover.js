/*
	Header Information------------------------------------[Do Not Remove This Header]--
	Title: OO Dom Image Rollover
	Description: This script makes it easy to add rollover/ mousedown 
  	effects to any image on the page, including image submit buttons. Automatically 
  	preloads images as well. Script works in all DOM capable browsers- IE5+, NS6+, 
  	Opera7+.
	
	Legal: Copyright 2005 Adam Smith
	Author Email Address: ibulwark@hotmail.com
	Date Created: June 6, 2005
	Website: Codevendor.com | eBadgeman.com
	Script featured on Dynamic Drive: http://www.dynamicdrive.com
	-----------------------------------------------------------------------------------
*/

function imageholderclass(){
	this.over=new Array();
	this.down=new Array();
	this.src=new Array();
	this.store=store;
	
	function store(src, down, over){
		var AL=this.src.length;
		this.src[AL]=new Image(); this.src[AL].src=src;
		this.over[AL]=new Image(); this.over[AL].src=over;
		this.down[AL]=new Image(); this.down[AL].src=down;
	}
}

var ih = new imageholderclass();
var mouseisdown=0;

function preloader(t){
	for(i=0;i<t.length;i++){
		if(t[i].getAttribute('srcover')||t[i].getAttribute('srcdown')){
			
			storeimages(t[i]);
			var checker='';
			checker=(t[i].getAttribute('srcover'))?checker+'A':checker+'';
			checker=(t[i].getAttribute('srcdown'))?checker+'B':checker+'';
			
			switch(checker){
			case 'A' : mouseover(t[i]);mouseout(t[i]); break;
			case 'B' : mousedown(t[i]); mouseup2(t[i]); break;
			case 'AB' : mouseover(t[i]);mouseout(t[i]); mousedown(t[i]); mouseup(t[i]); break;
			default : return;			
			}
			
			if(t[i].src){t[i].setAttribute("oldsrc",t[i].src);}
		}
	}
}
function mouseup(t){
	var newmouseup;
	if(t.onmouseup){
		t.oldmouseup=t.onmouseup;
		newmouseup=function(){mouseisdown=0;this.src=this.getAttribute("srcover");this.oldmouseup();}

	}
	else{newmouseup=function(){mouseisdown=0;this.src=this.getAttribute("srcover");}}
	t.onmouseup=newmouseup;
}

function mouseup2(t){
	var newmouseup;
	if(t.onmouseup){
		t.oldmouseup=t.onmouseup;
		newmouseup=function(){mouseisdown=0;this.src=this.getAttribute("oldsrc");this.oldmouseup();}
		}
	else{newmouseup=function(){mouseisdown=0;this.src=this.getAttribute("oldsrc");}}
	t.onmouseup = newmouseup;
}

function mousedown(t){
	var newmousedown;
	if(t.onmousedown){
		t.oldmousedown=t.onmousedown;
		newmousedown=function(){if(mouseisdown==0){this.src=this.getAttribute("srcdown");this.oldmousedown();}}
	}
	else{newmousedown=function(){if(mouseisdown==0){this.src=this.getAttribute("srcdown");}}}
	t.onmousedown=newmousedown;
}

function mouseover(t){
	var newmouseover;
	if(t.onmouseover){
		t.oldmouseover=t.onmouseover;
		newmouseover=function(){this.src=this.getAttribute("srcover");this.oldmouseover();}
	}
	else{newmouseover=function(){this.src=this.getAttribute("srcover");}}
	t.onmouseover=newmouseover;
}

function mouseout(t){
	var newmouseout;
	if(t.onmouseout){
		t.oldmouseout=t.onmouseout;
		newmouseout=function(){this.src=this.getAttribute("oldsrc");this.oldmouseout();}
	}
	else{newmouseout=function(){this.src=this.getAttribute("oldsrc");}}
	t.onmouseout=newmouseout;
}

function storeimages(t){
	var s=(t.getAttribute('src'))?t.getAttribute('src'):'';
	var d=(t.getAttribute('srcdown'))?t.getAttribute('srcdown'):'';
	var o=(t.getAttribute('srcover'))?t.getAttribute('srcover'):'';
	ih.store(s,d,o);
}

function preloadimgsrc(){
	if(!document.getElementById) return;
	var it=document.getElementsByTagName('IMG');
	var it2=document.getElementsByTagName('INPUT');
	preloader(it);
	preloader(it2);
}

if(window.addEventListener){window.addEventListener("load", preloadimgsrc, false);} 
else{
	if(window.attachEvent){window.attachEvent("onload", preloadimgsrc);}
	else{if(document.getElementById){window.onload=preloadimgsrc;}}
}