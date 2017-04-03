// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

//= require foundation.core
//= require foundation.reveal
//= require foundation.tabs
//= require foundation.util.timerAndImageLoader
//= require foundation.util.box
//= require foundation.util.keyboard
//= require foundation.util.mediaQuery
//= require foundation.util.triggers
//= require foundation.tooltip
//= require foundation.equalizer
//= require foundation.toggler
//= require material-foundation/material-foundation
//= require material-foundation/ripple
//= require material-foundation/switches

//= require json2

$(function() {
  $(document).foundation();
});

$(function(){ $(document).foundation(); });
