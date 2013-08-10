//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/alert
//= require bootstrap-datepicker.js
//= require d3.v3
//= require_tree ./d3view
//= require_self

$(function(){
  $('input[data-toggle="datepicker"]').datepicker({format:'yyyy/mm/dd'})
})
