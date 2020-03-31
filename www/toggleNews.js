function showRIVMnews(){
      console.log("NIce to see you here dev")
      var RIVM= document.getElementById("newsContentRIVM");
      var Government = document.getElementById("NewsContentGovernment");
      RIVM.className = RIVM.className.replace(" w3-hide", " w3-show")
      Government.className = Government.className.replace(" w3-show", " w3-hide")
      
    }
function showGovernment(){
      console.log("button clicked yes")
      var RIVM= document.getElementById("newsContentRIVM");
      var Government = document.getElementById("NewsContentGovernment");
      RIVM.className = RIVM.className.replace(" w3-show", " w3-hide")
      Government.className = Government.className.replace(" w3-hide", " w3-show")
      
    }
