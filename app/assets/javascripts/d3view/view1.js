$.number_format = function(number, decimals, dec_point, thousands_sep) {
		// Formats a number with grouped thousands  
		// http://phpjs.org/functions/number_format
		number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
		var n = !isFinite(+number) ? 0 : +number,
			prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
			sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
			dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
			s = '',
			toFixedFix = function (n, prec) {
				var k = Math.pow(10, prec);
				return '' + Math.round(n * k) / k;
			};
		// Fix for IE parseFloat(0.55).toFixed(0) = 0;
		s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
		if (s[0].length > 3) {
			s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
		}
		if ((s[1] || '').length < prec) {
			s[1] = s[1] || '';
			s[1] += new Array(prec - s[1].length + 1).join('0');
		}
		return s.join(dec);
}


var margin = {top: 40, right: 10, bottom: 10, left: 10},
    width = $(document).width() - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;

var color = d3.scale.category20c();

var treemap = d3.layout.treemap()
    .size([width, height])
    .sticky(true)
    .value(function(d) { return d.size; });


function position() {
  this.style("left", function(d) { return d.x + "px"; })
      .style("top", function(d) { return d.y + "px"; })
      .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
      .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
}


function show_d3(val_year,val_type,val_name){
    var div = d3.select("#d3graph").append("div")
    .style("position", "relative")
    .style("width", (width + margin.left + margin.right) + "px")
    .style("height", (height + margin.top + margin.bottom) + "px")
    .style("left", margin.left + "px")
    .style("top", margin.top + "px");


	d3.json("/search.json", function(error, root) {
	  var node = div.datum(root).selectAll(".node")
	      .data(treemap.nodes)
          .enter().append("div")
	      .attr("class", "node")
	      .call(position)
	      .style("background", function(d) { return d.children ? color(d.name) : null; })
	      .html(function(d) { return d.children ? '<p>'+d.name+'</p>' : '<p style="position:absolute;bottom:0">'+d.name+'<br>'+$.number_format(d.size)+"</p>"; });
	
	});
}
