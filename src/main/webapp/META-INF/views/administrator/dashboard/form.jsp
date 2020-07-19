<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 
    prefix="fn" %> 
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags" %>

<acme:form readonly="true">
	<acme:form-panel code="administrator.dashboard.form.label.quantities">
		<div class="row">
			<div class="col-md-4">
				<acme:form-integer code="administrator.dashboard.form.label.numberOfNotices" path="numberOfNotices"/>
			</div>
			<div class="col-md-4">
				<acme:form-integer code="administrator.dashboard.form.label.numberOfTechnologyRecords" path="numberOfTechnologyRecords"/>
			</div>
			<div class="col-md-4">
				<acme:form-integer code="administrator.dashboard.form.label.numberOfToolRecords" path="numberOfToolRecords"/>
			</div>
		</div>
	</acme:form-panel>
	
	<acme:form-panel code="administrator.dashboard.form.label.inquiries">
		<div class="row">
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.minimumMoneyActiveInquiries" path="minimumMoneyActiveInquiries"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.maximumMoneyActiveInquiries" path="maximumMoneyActiveInquiries"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.averageMoneyActiveInquiries" path="averageMoneyActiveInquiries"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.standardDeviationMoneyActiveInquiries" path="standardDeviationMoneyActiveInquiries"/>
			</div>
		</div>
	</acme:form-panel>

	<acme:form-panel code="administrator.dashboard.form.label.overtures">
		<div class="row">
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.minimumMoneyActiveOvertures" path="minimumMoneyActiveOvertures"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.maximumMoneyActiveOvertures" path="maximumMoneyActiveOvertures"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.averageMoneyActiveOvertures" path="averageMoneyActiveOvertures"/>
			</div>
			<div class="col-md-3">
				<acme:form-integer code="administrator.dashboard.form.label.standardDeviationMoneyActiveOvertures" path="standardDeviationMoneyActiveOvertures"/>
			</div>
		</div>
	</acme:form-panel>	
	
	<acme:form-panel code="administrator.dashboard.chart.label.technologyRecordsBySectors">
		<div class="row">
			<div class="col-md-6">
				<canvas id="graph1"></canvas>
			</div>
			<div class="col-md-6">
				<canvas id="graph2"></canvas>
			</div>
		</div>	
	</acme:form-panel>
	
	<acme:form-panel code="administrator.dashboard.chart.label.toolRecordsBySectors">
		<div class="row">
			<div class="col-md-6">
				<canvas id="graph3"></canvas>
			</div>
			<div class="col-md-6">
				<canvas id="graph4"></canvas>
			</div>
		</div>	
	</acme:form-panel>
	
	<div class="row">
		<div class="col-md-6">
			<acme:form-panel code="administrator.dashboard.chart.label.ratioOpenVsClosedTechnologies">
				<canvas id="graph5"></canvas>
			</acme:form-panel>
		</div>
		
		<div class="col-md-6">
			<acme:form-panel code="administrator.dashboard.chart.label.ratioOpenVsClosedTools">
				<canvas id="graph6"></canvas>
			</acme:form-panel>
		</div>
	</div>


</acme:form>

<script type="text/javascript">
	function getRandomColor() {
	    var letters = '0123456789ABCDEF'.split('');
	    var color = '#';
	    for (var i = 0; i < 6; i++ ) {
	        color += letters[Math.floor(Math.random() * 16)];
	    }
	    return color;
	}
	
	function getNRandomColors(num){
		var colors = [];
		var i = 0;
		while (i<num){
			colors.push(getRandomColor());
			i=i+1;
		}
		return colors
	}
	
	function formatDate(date){
	    var dd = date.getDate();
	    var mm = date.getMonth()+1;
	    var yyyy = date.getFullYear();
	    
	    if(dd<10) {
	    	dd='0'+dd;
	    }
	    if(mm<10) {
	    	mm='0'+mm;
	    }
	    
	    return dd+'/'+mm+'/'+yyyy;
	 }

	function getDaysLast4Weeks () {
	    var result = [];
	    
	    for (var i=0; i<28; i++) {
	        var date = new Date();
	        date.setDate(date.getDate() - i);
	        result.push(formatDate(date))
	    }

	    return result.reverse();
	 }

	$(document).ready(function(){
		
		var technologyRecordsSectors = [
			<c:forEach items="${technologyRecordsSectors}" var="activitySector">"<c:out value='${activitySector}'></c:out>",</c:forEach>
		];
		
		var numberOfTechnologyRecordsBySector = [
			<c:forEach items="${numberOfTechnologyRecordsBySector}" var="number"><c:out value='${number}'></c:out>,</c:forEach>
		];
		
		var toolRecordsSectors = [
			<c:forEach items="${toolRecordsSectors}" var="activitySector">"<c:out value='${activitySector}'></c:out>",</c:forEach>
		];

		var numberOfToolRecordsBySector = [
			<c:forEach items="${numberOfToolRecordsBySector}" var="number"><c:out value='${number}'></c:out>,</c:forEach>
		]
		
		var ratioTechnologiesLabels = [
			"<acme:message code='administrator.dashboard.chart.label.open'/>",
			"<acme:message code='administrator.dashboard.chart.label.closed'/>"
		]
		
		var ratioTechnologiesData = [
			<c:out value='${ratioOpenTechnologies}'></c:out>,
			<c:out value='${ratioClosedTechnologies}'></c:out>
		]
		
		var ratioToolsData = [
			<c:out value='${ratioOpenTools}'></c:out>,
			<c:out value='${ratioClosedTools}'></c:out>
		]
		
		var ratioToolsLabels = [
			"<acme:message code='administrator.dashboard.chart.label.open'/>",
			"<acme:message code='administrator.dashboard.chart.label.closed'/>"
		]

		var barGraph1 = {
				labels: technologyRecordsSectors,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.technologyRecords'/>",
					backgroundColor: "rgba(54, 162, 235, 0.5)",
					borderColor: "rgb(54, 162, 235)",
					borderWidth: 1,
					data: numberOfTechnologyRecordsBySector,
				},]
		}
		
		var pieGraph2 = {
				labels: technologyRecordsSectors,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.technologyRecords'/>",
					backgroundColor: getNRandomColors(<c:out value='${fn:length(technologyRecordsSectors)}' />),
					borderWidth: 1,
					data: numberOfTechnologyRecordsBySector,
				},]
		}
		
		var barGraph3 = {
				labels: toolRecordsSectors,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.toolRecords'/>",
					backgroundColor: "rgba(54, 162, 235, 0.5)",
					borderColor: "rgb(54, 162, 235)",
					borderWidth: 1,
					data: numberOfToolRecordsBySector,
				},]
		}
		
		var pieGraph4 = {
				labels: toolRecordsSectors,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.toolRecords'/>",
					backgroundColor: getNRandomColors(<c:out value='${fn:length(toolRecordsSectors)}' />),
					borderWidth: 1,
					data: numberOfToolRecordsBySector,
				},]
		}
		
		var pieGraph5 = {
				labels: ratioTechnologiesLabels,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.ratioOpenVsClosedTechnologies'/>",
					backgroundColor: ["#999999", "#4BC0C0"],
					borderWidth: 1,
					data: ratioTechnologiesData,
				},]
		}
		
		var pieGraph6 = {
				labels: ratioToolsLabels,
				datasets: [{
					label: "<acme:message code='administrator.dashboard.chart.label.ratioOpenVsClosedTools'/>",
					backgroundColor: ["#FFCD56", "#4BC0C0", "#FF6384"],
					borderWidth: 1,
					data: ratioToolsData,
				},]
		}
		

			window.onload = function() {
			var ctxGraph1 = document.getElementById('graph1').getContext('2d');
			var ctxGraph2 = document.getElementById('graph2').getContext('2d');
			var ctxGraph3 = document.getElementById('graph3').getContext('2d');
			var ctxGraph4 = document.getElementById('graph4').getContext('2d');
			var ctxGraph5 = document.getElementById('graph5').getContext('2d'); 
			var ctxGraph6 = document.getElementById('graph6').getContext('2d'); 
			
			window.graph1 = new Chart(ctxGraph1, {
				type: 'bar',
				data: barGraph1,
				options: {
			        scales: {
			            yAxes: [{
			                ticks: {
			                	beginAtZero: true,
			                	stepSize: 1,
			                }
			            }]
			        }
			    }
			});
			
			window.graph2 = new Chart(ctxGraph2, {
				type: 'pie',
				data: pieGraph2,
			});
			
			window.graph3 = new Chart(ctxGraph3, {
				type: 'bar',
				data: barGraph3,
				options: {
			        scales: {
			            yAxes: [{
			                ticks: {
			                	beginAtZero: true,
			                	stepSize: 1,
			                }
			            }]
			        }
			    }
			});
			
			window.graph4 = new Chart(ctxGraph4, {
				type: 'pie',
				data: pieGraph4,
			});
			
			window.graph5 = new Chart(ctxGraph5, {
				type: 'pie',
				data: pieGraph5,
			});
			
			window.graph6 = new Chart(ctxGraph6, {
				type: 'pie',
				data: pieGraph6,
			});

		};
	});
	
</script>

<style>
	.form-control {
	    margin-top: 5px;
	    background-color: #00000026!important;
	    color: white;
	    font-weight: bold;
	    font-size: 2rem;
	    height: auto;
	}
	
	.form-group {
		margin-bottom: 1rem;
	    background: gray;
	    border-radius: 3px;
	    padding: 10px;
	    color: white;
	}
	
	fieldset {
		background-color: #ededed;
		padding: 0 20px;	
	}
</style>