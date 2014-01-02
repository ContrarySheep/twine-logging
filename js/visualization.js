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

  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

  var options = {
    title: 'Temperature Monitoring',
    curveType: 'function',
    explorer: { actions: ['dragToZoom', 'rightClickToReset']  },
    legend: { position: 'bottom' },
    hAxis: { format: 'h:mm a M/d'}
  };

  chart.draw(data, options);
}