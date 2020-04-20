$(document).ready(function(){
    var svg = d3.select("#testSvg");

    // to get the axis labels date right
    var parseTime = d3.timeParse("%d/%m/%Y");
    // To draw the line
    var valueline = d3.line()
        .x(function(d) { return x(d.dateRep); })
        .y(function(d) { return y(d.cases);  });

    var valueline2=d3.line()
    .x(function(d) { return x(d.dateRep); })
    .y(function(d) { return y(d.deaths);  });

    // add some margins or the yticks will fall off
    var margin={top: 100, right: 130, bottom: 130, left: 150}
    var width=600 - margin.left - margin.right;
    var height=500- margin.top - margin.bottom;

    // Set the axis
    var x = d3.scaleTime().range([0, width]);
    var y = d3.scaleLinear().range([height, 0]);
    // margins of the image are not set but will be done in CCS of the HTML
    var g =svg.append("g").attr("width",width).attr("height",height);

    // Read the data with the dates and cases
    d3.csv("www/daily_rise.csv",function(error,data){
        if (error) throw error;
        // parse the numbers to integers
        data.forEach(function(d){
            d.dateRep=parseTime(d.dateRep);
            d.deaths=+d.deaths;
            d.cases=+d.cases;
        })
        // add the domain to the axis
        x.domain(d3.extent(data, function(d) { return d.dateRep; }));
        y.domain([0, d3.max(data, function(d) { return d.cases; })]);


       // add the line to plot
        svg.append("path")
           .data([data])
           .attr("fill", "none")
           .attr("stroke","blue")
           .attr("class","linegraph")
           .attr("transform", "translate(50,10)")
           .attr("d", valueline);
        
           svg.append("path")
           .data([data])
           .attr("fill", "none")
           .attr("stroke","red")
           .attr("class","linegraph")
           .attr("transform", "translate(50,10)")
           .attr("d", valueline2);
        
        // add the axis
        svg.append("g").attr("transform", "translate(50,10)").call(d3.axisLeft(y));
        var heightAxis=height+10;
        svg.append("g")
        .attr("transform", "translate(50," + heightAxis + ")")
        .call(d3.axisBottom(x).tickFormat(d3.timeFormat("%d-%m-%Y")))
        .selectAll("text")	
          .style("text-anchor", "end")
          .attr("dx", "-.8em")
          .attr("dy", ".15em")
          .attr("transform", "rotate(-65)");
    


       
        // Handmade legend
        svg.append("circle").attr("cx",400).attr("cy",130).attr("r", 6).style("fill", "blue")
        svg.append("circle").attr("cx",400).attr("cy",160).attr("r", 6).style("fill", "red")
        svg.append("text").attr("x", 410).attr("y", 135).text("Cases").style("font-size", "15px").attr("alignment-baseline","middle")
        svg.append("text").attr("x", 410).attr("y", 165).text("Deaths").style("font-size", "15px").attr("alignment-baseline","middle")

    })



    
})