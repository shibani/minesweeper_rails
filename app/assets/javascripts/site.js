// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('DOMContentLoaded', function() {
  var formContainer = document.querySelector('body.new .form-container') || document.querySelector('body.update .form-container');

  var rowSizeField = document.querySelector('body.home .settings-container #row_size');

  if(formContainer){
    formContainer.addEventListener('contextmenu', boardObj.processFlagClick, false);
  }

  if(rowSizeField){
    rowSizeField.addEventListener('blur', settingsObj.processUserInput, false)
  }
});
