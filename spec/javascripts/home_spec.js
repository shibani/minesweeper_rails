describe('settingsObj', function() {
  beforeEach(function () {
    this.fixture = fixture.load("form_fixture.html", true)
    spyOn(settingsObj, 'processUserInput').and.callThrough();
  });

  afterEach(function () {
    fixture.cleanup();
  });

  it("contains spec with an expectation", function() {
    expect(true).toBe(true);
  });

  it("loads fixtures", function() {
    expect(this.fixture[0]).toBe(fixture.el);
  });

  it("returns the value of the cell when it is updated", function(){
    event = {
      target: {value: '4'}
    };

    result = settingsObj.getRowSize(event);

    expect(result).toContain(4);
  });

  it("updates the form's bomb count max value when a user sets the row size", function(){
    var val = 9;
    settingsObj.updateForm(val);
    var bc = parseInt(val * val * 0.75).toString();
    var max = document.getElementById('bomb_count').max

    expect(max).toEqual(bc);
  });

  it("updates the form's bomb count placeholder text when a user sets the row size", function(){

    var val = 9;
    var max = settingsObj.updateForm(val);
    settingsObj.updatePlaceholder(val, max);
    var placeholderText = document.getElementById('bomb_count').placeholder;

    expect(placeholderText).toEqual('enter a bomb count ( min: 1, max: 60 )');
  });

  it("does not display the form's bomb count placeholder text if the row size is less than the minimum", function(){

    var val = 0;
    var max = settingsObj.updateForm(val);
    settingsObj.updatePlaceholder(val, max);
    var placeholderText = document.getElementById('bomb_count').placeholder;

    expect(placeholderText).toEqual('enter a bomb count');
  });
});
