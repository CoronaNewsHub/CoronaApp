function myFunctionNews(){
        var x = document.getElementById("News");
        var y = document.getElementById("GeneralInfo");
        var z = document.getElementById("Precautions")
        var q = document.getElementById("Facts")
        if (x.className.indexOf("w3-show") == -1) {
          x.className += " w3-show";
          y.className = y.className.replace(" w3-show", " w3-hide")
          z.className = z.className.replace(" w3-show", " w3-hide")
          q.className = q.className.replace(" w3-show", " w3-hide")
    
        } else {
          x.className = x.className.replace(" w3-show", " w3-hide");
          y.className = y.className.replace(" w3-hide", " w3-show")
          q.className = q.className.replace(" w3-show", " w3-hide");
          z.className = z.className.replace(" w3-show", " w3-hide");
      }
    }
function myFunctionPrecautions(){
        var x = document.getElementById("News");
        var y = document.getElementById("GeneralInfo");
        var z = document.getElementById("Precautions")
        var q = document.getElementById("Facts")
        if (z.className.indexOf("w3-show") == -1) {
          x.className = x.className.replace(" w3-show", " w3-hide")
          y.className = y.className.replace(" w3-show", " w3-hide")
          z.className = z.className.replace(" w3-hide", " w3-show")
          q.className = q.className.replace(" w3-show", " w3-hide")
          
        } else {
          x.className = x.className.replace(" w3-show", " w3-hide");
          z.className = z.className.replace(" w3-show", " w3-hide");
          y.className = y.className.replace(" w3-hide", " w3-show");
          q.className = q.className.replace(" w3-show", " w3-hide");
      }
    }
function myFunctionNumbers(){
    var x = document.getElementById("News");
        var y = document.getElementById("GeneralInfo");
        var z = document.getElementById("Precautions")
        var q = document.getElementById("Facts")
        if (q.className.indexOf("w3-show") == -1) {
          x.className = x.className.replace(" w3-show", " w3-hide")
          y.className = y.className.replace(" w3-show", " w3-hide")
          z.className = z.className.replace(" w3-show", " w3-hide")
          q.className = q.className.replace(" w3-hide", " w3-show")
          
        } else {
          x.className = x.className.replace(" w3-show", " w3-hide");
          z.className = z.className.replace(" w3-show", " w3-hide");
          y.className = y.className.replace(" w3-hide", " w3-show");
          q.className = q.className.replace(" w3-show", " w3-hide");
      }
    }
