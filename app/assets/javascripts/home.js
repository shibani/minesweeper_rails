var settingsObj = {

  processUserInput: function(event){
    var val = settingsObj.getRowSize(event);
    var max = settingsObj.updateForm(val)
    settingsObj.updatePlaceholder(val, max);
  },

  getRowSize: function(ev){
    return ev.target.value;
  },

  updateForm: function(val){
    var bc = parseInt(val * val * 0.75).toString();
    document.getElementById('bomb_count').max = bc;
    return bc;
  },

  updatePlaceholder: function(val, max){
    if( val >= 4 ){
      document.getElementById('bomb_count').placeholder='enter a bomb count ( min: 1, max: ' + max + ' )';
    } else {
      document.getElementById('bomb_count').placeholder='enter a bomb count';
    }
  }
}
