describe('testObj', function() {

  beforeEach(function () {
    this.fixture = fixture.load("game_fixture.html", true)
    spyOn(testObj, 'processFlagClick').and.callThrough();
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

  it("returns the id of the cell that was clicked on", function(){
    event = {
      target: {id: 'submit_6'},
      preventDefault: jasmine.createSpy(),
      stopPropagation: jasmine.createSpy()
    };
    
    result = testObj.detectRightClick(event);

    expect(event.preventDefault).toHaveBeenCalled
    expect(event.stopPropagation).toHaveBeenCalled
    expect(result).toContain("submit");
  });

  it("parses the id of the cell and returns an integer", function(){
    var result = testObj.getClickedCellId('submit_24');
    expect(result).toEqual(jasmine.any(Number));
  });

  it("updates the right-clicked form to submit flag content", function(){
    var form = document.forms[24];
    testObj.updateForm(24);
    var field = form['content'].value;
    expect(field).toEqual('F');
  });

  it("submits the form", function(){
    var form = document.forms[32];
    spyOn(form, 'submit').and.callThrough();
    testObj.submitForm(32);
    expect(form.submit).toHaveBeenCalled();
  });

});
