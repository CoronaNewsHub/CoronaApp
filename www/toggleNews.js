function showRIVMnews(){
      var RIVM= document.getElementById("newsContentRIVM");
      var Government = document.getElementById("NewsContentGovernment");
      var Dutch=document.getElementById("DutchNews")
      RIVM.className = RIVM.className.replace(" w3-hide", " w3-show")
      Government.className = Government.className.replace(" w3-show", " w3-hide")
      Dutch.className=Dutch.className.replace(" w-3 show"," w3-hide")
    }
function showGovernment(){
      var RIVM= document.getElementById("newsContentRIVM");
      var Government = document.getElementById("NewsContentGovernment");
      var Dutch=document.getElementById("DutchNews");
      RIVM.className = RIVM.className.replace(" w3-show", " w3-hide")
      Government.className = Government.className.replace(" w3-hide", " w3-show")
      Dutch.className=Dutch.className.replace(" w-3 show"," w3-hide")
    }

    function showDutchNews(){
      console.log('clicked for dutch')
      var RIVM= document.getElementById("newsContentRIVM");
      var Government = document.getElementById("NewsContentGovernment");
      var Dutch=document.getElementById("DutchNews");
      RIVM.className = RIVM.className.replace(" w3-show", " w3-hide")
      Government.className = Government.className.replace(" w3-show", " w3-hide")
      Dutch.className=Dutch.className.replace(" w3-hide"," w3-show")
    }