// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var testObj = {
  processFlagClick: function(event) {
    console.log(event);
    var result = testObj.detectRightClick(event);
    id = testObj.getClickedCellId(result);
    testObj.updateForm(id);
    testObj.submitForm(id);
  },

  detectRightClick: function(ev){
    ev.preventDefault();
    ev.stopPropagation();
    alert(ev.target.id);
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
  var formContainer = document.querySelector(".form-container");

  formContainer.addEventListener('contextmenu', testObj.processFlagClick, false);

});
