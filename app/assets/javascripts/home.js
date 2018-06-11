var settingsObj = {

  processUserInput: function(cellClickEvent){
    var val = settingsObj.getRowSize(cellClickEvent);
    var max = settingsObj.updateForm(val)
    settingsObj.updatePlaceholder(val, max);
  },

  getRowSize: function(cellClickEvent){
    return cellClickEvent.target.value;
  },

  updateForm: function(val){
    var bomb_count = parseInt(val * val * 0.75).toString();
    document.getElementById('bomb_count').max = bomb_count;
    return bomb_count;
  },

  updatePlaceholder: function(val, max){
    if( val >= 4 ){
      document.getElementById('bomb_count').placeholder='enter a bomb count ( between 4 and ' + max + ' )';
    } else {
      document.getElementById('bomb_count').placeholder='enter a bomb count';
    }
  }
}
