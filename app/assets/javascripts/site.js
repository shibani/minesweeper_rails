// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window.onload = function(){
  document.querySelector(".form-container").onmousedown = function (e) {
    console.log(e.which);
    switch (e.which) {
      case 1:
        console.log('Left');
        //submit form here
        break;
      case 3:
        console.log('Right');
        //also submit form here but with flag params
        break;
    }
  }
}
