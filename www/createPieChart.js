$(document).ready(function(){
    
    // basic settings
    var width=800;
    var height=200;
    var svg = d3.select("#testSvgPie");
    var radius=80;
    
    var arc=d3.arc().innerRadius(0).outerRadius(radius);

    var pie = d3.pie()
                .sort(null)
                .value(function(d) { return d.Value; });

    var svg = d3.select("#testSvgPie")
                .attr("width", width)
                .attr("height", height)
                .append("g")
                .attr("transform", "translate(" + width / 8 + "," + height / 2 + ")");
    

    // colors for the pie chart
    d3.csv("www/numbers.csv",function(error,data){
        if (error) throw error;
        var color = d3.scaleOrdinal(['#4daf4a','#377eb8','#ff7f00']);
        
        data.forEach(function(d){
            d.Attribute=d.Attribute;
            d.Value=+d.Value;
        })

        var g = svg.selectAll(".arc")
            .data(pie(data))
            .enter().append("g")
            .attr("class", "arc");
        
        var tots = d3.sum(data, function(d) { 
                return d.Value; 
            
            });    
        console.log(tots)
        g.append("path")
            .attr("d", arc)
            .attr("data-legend",function(d) { return d.Attribute})
            .style("fill", function(d) { return color(d.data.Attribute); })
            .on("mouseover", function (d) {
                d3.select("#tooltip")
                    .style("left", d3.event.pageX+30 + "px")
                    .style("top", d3.event.pageY + "px")
                    .style("opacity", 1)
                    .text("percentage of "+d.data.Attribute.toLowerCase()+": "+Math.round((d.data.Value/tots)*100)+"%");
            })
                .on("mouseout", function () {
                // Hide the tooltip
                d3.select("#tooltip")
                    .style("opacity", 0);
            });
        
        var legend = svg.append("g")
	    .attr("class", "legend")
	    .attr("height", 100)
	    .attr("width", 100)
        .attr('transform', 'translate(-20,50)')    
      
        legend.selectAll('arc')
        .data(pie(data))
        .enter()
        .append("rect")
        .attr("x", 120)
        .attr("y", function(d, i){ return i *  20 -60;})
        .attr("width", 10)
        .attr("height", 10)
        .style("fill", function(d) { 
            return color(d.data.Attribute);
        })
        legend.selectAll('text')
        .data(pie(data))
        .enter()
        .append("text")
        .attr("x", 140)
        .attr("y", function(d, i){ return i *  20 + -51;})
        .text(function(d) {
          return d.data.Attribute + " ("+ d.data.Value+" cases)"
        });
        


    })
})