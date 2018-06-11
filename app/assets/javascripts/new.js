var boardObj = {
  processFlagClick: function(evt) {
    var result = boardObj.detectRightClick(evt);
    id = boardObj.getClickedCellId(result);
    boardObj.updateForm(id);
    boardObj.submitForm(id);
  },

  detectRightClick: function(evt){
    evt.preventDefault();
    evt.stopPropagation();
    return evt.target.id;
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
