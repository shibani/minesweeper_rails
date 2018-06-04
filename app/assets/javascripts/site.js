// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var boardObj = {
  processFlagClick: function(event) {
    var result = boardObj.detectRightClick(event);
    id = boardObj.getClickedCellId(result);
    boardObj.updateForm(id);
    boardObj.submitForm(id);
  },

  detectRightClick: function(ev){
    ev.preventDefault();
    ev.stopPropagation();
    return ev.target.id;
  },

  getClickedCellId: function(id){
    var form_id = parseInt(id.replace('submit_',''));
    return form_id;
  },

  updateForm: function(id){
    var form = document.forms[id];
    form['content'].value = 'F'
  },

  submitForm: function(id){
    var form = document.forms[id];
    form.submit();
  }
}

document.addEventListener('DOMContentLoaded', function() {
  var formContainer = document.querySelector("body.new .form-container") || document.querySelector("body.update .form-container");

  if(formContainer){
    formContainer.addEventListener('contextmenu', boardObj.processFlagClick, false);
  }
});
