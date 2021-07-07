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
                { title: "Hospitalized"},
                { title: "Hospitalized per 100k inhabitants"},
                { title: "Cases"},
                {title: "Cases per 100K inhabitants"}
            ]
        } );
        }    
            });
      });
