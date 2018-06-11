var settingsObj = {

  processUserInput: function(evt){
    var val = settingsObj.getRowSize(evt);
    var max = settingsObj.updateForm(val)
    settingsObj.updatePlaceholder(val, max);
  },

  getRowSize: function(evt){
    return evt.target.value;
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
