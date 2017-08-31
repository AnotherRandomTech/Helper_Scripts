$(document).ready(function(){
	$.ajax({
		url : "http://10.0.2.1/data/charts/LM-VH02-timespan.json",
		type : "GET",
		success : function(data){
			console.log(data);

			var H1 = [];
			var H2 = [];

			for(var i in data) {
				H1.push(data[i].H1);
				H2.push(data[i].H2);
			}

			var chartdata = {
				labels: H1,
				datasets: [
					{
						label: "CPU Temp",
						fill: false,
						lineTension: 0.1,
						backgroundColor: "rgba(59, 89, 152, 0.75)",
						borderColor: "rgba(59, 89, 152, 1)",
						pointHoverBackgroundColor: "rgba(59, 89, 152, 1)",
						pointHoverBorderColor: "rgba(59, 89, 152, 1)",
						data: H2
					}
				]
			};

			var ctx = $("#CPU-Temp");

			var LineGraph = new Chart(ctx, {
				type: 'line',
				data: chartdata
			});
		},
		error : function(data) {

		},	
	});
});