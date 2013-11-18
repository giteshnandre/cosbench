<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="resources/cosbench.css" />
  <title>Workload Metrics Configuration</title>
</head>
<body>
<#include "header.ftl">
<div id="main">
<div class="top"><br /></div>
<div class="content">
  <h3>Workload Metrics Configuration</h3>
    <h5>(You can configure workload metric file from here. You can also create and submit generated workload configs.)</h5>
  <div>
    <form action="config-workload.do" method="post" class="content" >
	  <#if error?? >
        <p><span class="error"><strong>Note</strong>: ${error}!</span></p>
      </#if>
      	<h3>Workload Metrics</h3>
		<div id="workload" class="a1">
				
			
			<input type="checkbox" name="workload.metric.checked" checked="checked" onClick="toggleDiv(this.nextElementSibling);" style="float:left">
			<div id="workload.metric" class="a2" >
					<table class="info-table">
						<thead>
							<tr>
								<th>Object sizes </th>
								<th>Objects per container </th>
                                <th>Containers </th>
                                <th>Read </th>
                                <th>Write </th>
                                <th>Delete </th>
                                <th>Workers </th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>
									<input name="object-sizes" type="text" style="width:150px" value="4KB,128KB,512KB" />
								</td>								
								<td>
									<input name="num-of-objects" type="text" style="width:100px" value="1000" />
								</td>
                                <td>
									<input name="num-of-containers" type="text" style="width:100px" value="1,100" />
								</td>
                                <td>
									<input name="read-ratio" type="text" style="width:100px" value="80" />
								</td>
                                <td>
									<input name="write-ratio" type="text" style="width:100px" value="15" />
								</td>
                                <td>
									<input name="delete-ratio" type="text" style="width:100px" value="5" />
								</td>
                                <td>
									<input name="workers" type="text" style="width:100px" value="1,2,4,16,32,64" />
								</td>
                                
							</tr>
						
						</tbody>
					</table>
					<a  href="javascript:void(0);" onclick="deleteMetricRow(this.parentNode.parentNode);"> delete </a>
					
			</div>
		</div>
    </form>
    <div>
			<input type="button" id="addMetricRow" value="Add Metric Row" onClick="addMetricRow();" />
	</div>
  </div>
<p><a href="index.html">go back to index</a></p>
</div> <#-- end of content -->
<div class="bottom"><br /></div>
</div> <#-- end of main -->
<#include "footer.ftl">
<script>
	var previousDiv=document.getElementById('workload');
	var firstCloneDiv = previousDiv.cloneNode(true);
	
	function deleteMetricRow(divElement) 
	{
    	previousDiv = divElement.previousElementSibling;
        divElement.parentNode.removeChild(divElement);
	}

	function addMetricRow()
	{
	    var cloneDiv = firstCloneDiv.cloneNode(true);
	    previousDiv.parentNode.insertBefore(cloneDiv, previousDiv.nextElementSibling);
	    previousDiv = cloneDiv;
	}
	 function toggleDiv(divElement)
	{
        if(divElement.style.display == 'none'){
        divElement.style.display = '';
        }else {
        divElement.style.display = 'none';
        }
        return false;
	}
</script>
</body>
</html>  