 $(document).ready(function() {
    
      var data_for_table;
          $.ajax({
            type: "GET",  
            url: "www/new_cases.csv",
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
                { title: "Hospitalization"},
                { title: "Deaths"},
                {title: "Cases per 100K"},
                {title: "Hospitalization per 100K"},
                {title: "Deaths per 100K"}
            ]
        } );
        }    
            });
      });
