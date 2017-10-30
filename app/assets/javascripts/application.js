// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's 
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

window.onload = function () {
	reset_find_bookmark_btn = document.getElementById('reset_find_bookmark_form')

	reset_find_bookmark_btn.onclick = function() {
		document.getElementById('search').value ='';
		document.getElementById('find_bookmark_submit').click();
	}

	new_bookmark_btn = document.getElementById('add_new_bookmark_btn')
	hidden_bookmark_btn = document.getElementById('hidden_new_bookmark_form')
	new_bookmark_btn.onclick = function() {
		if (hidden_bookmark_btn.className == "visible"){
    		hidden_bookmark_btn.className = "unvisible"
		}
		else {
			hidden_bookmark_btn.className = "visible"
		}
	}


	error_close_btn = document.getElementById("error_close_btn")
	hide_error_messages = document.getElementById("hide_error_messages")
	error_close_btn.onclick = function() {
		hide_error_messages.style.display = "none"
	}
};
