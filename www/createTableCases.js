 $(document).ready(function() {
    
      var data_for_table;
          $.ajax({
            type: "GET",  
            url: "www/cases.csv",
            dataType: "text",       
            success: function(response)  
            {
              data_for_table = $.csv.toArrays(response);
            },
          complete: function () {
            $('#casesPerMunicipality').DataTable( {
            data: data_for_table,
            columns: [
                { title: "Municipality" },
                { title: "Cases"},
                { title: "Cases per 100k inhabitants"}
            ]
        } );
        }    
            });
      });