var settingsObj = {

  bomb_percent: 0.75,

  processUserInput: function(cellClickEvent){
    var rowsize = settingsObj.getRowSize(cellClickEvent);
    var max_bomb_count = settingsObj.updateForm(rowsize)
    settingsObj.updatePlaceholder(rowsize, max_bomb_count);
  },

  getRowSize: function(cellClickEvent){
    return cellClickEvent.target.value;
  },

  updateForm: function(rowsize){
    var bomb_count = parseInt(rowsize * rowsize * this.bomb_percent).toString();
    document.getElementById('bomb_count').max = bomb_count;
    return bomb_count;
  },

  updatePlaceholder: function(rowsize, max_bomb_count){
    if( max_bomb_count >= 4 ){
      document.getElementById('bomb_count').placeholder='enter a bomb count ( between 4 and ' + max_bomb_count + ' )';
    } else {
      document.getElementById('bomb_count').placeholder='enter a bomb count';
    }
  }
}
