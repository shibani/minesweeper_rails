var boardObj = {
  processFlagClick: function(rightClickEvent) {
    var result = boardObj.detectRightClick(rightClick);
    id = boardObj.getClickedCellId(result);
    boardObj.updateForm(id);
    boardObj.submitForm(id);
  },

  detectRightClick: function(rightClickEvent){
    rightClickEvent.preventDefault();
    rightClickEvent.stopPropagation();
    return rightClickEvent.target.id;
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
