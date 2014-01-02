google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

function drawChart() {

  var query = new google.visualization.Query(
'https://docs.google.com/spreadsheet/ccc?key=0AuC8Jc9vPbledDBVYWFQc2FLOFFWQ1luSTVJM0ZqT1E&usp=sharing');

  query.send(handleQueryResponse);

}

function handleQueryResponse(response) {
  if (response.isError()) {
    alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
    return;
  }

  var data = response.getDataTable();

  var dateFormatter = new google.visualization.DateFormat({pattern: "h:mm a on M/d/y"});

  dateFormatter.format(data, 0);


  var lastRow = 21; // The last row that represents the most current readings

  var outdoorTemp = data.getValue(lastRow,1);
  var indoorTemp = data.getValue(lastRow,2);

  var chart = new google.visualization.ScatterChart(document.getElementById('temperature_log'));

  var options = {
    fontName: 'Roboto Slab',
    colors:['#00CCFF','#FF0000'],
    chartArea:{left:0,top:0,width:"100%",height:"100%"},
    curveType: 'function',
    legend: { position: 'bottom' },
    hAxis: { format: 'h:mm a M/d', baselineColor: 'white', viewWindowMode: 'maximized' },
    vAxis: { baselineColor: 'white', viewWindowMode: 'pretty', baseline: 0 },
    lineWidth: 1
  };

  chart.draw(data, options);

  if (outdoorTemp > 0) {
    var outdoorTemp = outdoorTemp + "&deg;";
  }else{
    var outdoorTemp = "N/A";
  }

  if (indoorTemp > 0) {
    var indoorTemp = indoorTemp + "&deg;";
  }else{
    var indoorTemp = "N/A";
  }

  currentOutsideTemp(outdoorTemp);
  currentInsideTemp(indoorTemp);

}