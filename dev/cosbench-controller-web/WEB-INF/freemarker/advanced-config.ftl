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
    <form action="advanced-config-workload.do" method="post" class="content" >
	  <#if error?? >
        <p><span class="error"><strong>Note</strong>: ${error}!</span></p>
      </#if>
      	<h3>Workload Metrics</h3>
      	
      	<div id="workload.as" class="a2">
					<table class="info-table">
						<thead>
							<tr>
								<th ></th>
								<th >Type</th>
								<th >Configuration</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td >Authentication</td>
								<td >
									<select name="auth.type">
									  <option value="swauth" selected="true">swauth</option>
									  <option value="keystone">keystone</option>
									  <option value="mock">mock</option>
									  <option value="none">none</option>
									</select>
								</td>
								<td >
									<input name="auth.config" type="text" style="width:500px" value="username=test:tester;password=testing;url=http://192.168.10.1:8080/auth/v1.0" 
					title="different auth system has different parameters: &#10;[swauth]: username=<account:username>;password=<password>;url=<url> &#10;[keystone]: username=<account:username>;password=<password>;url=<url> &#10;[mock]: delay=<time> &#10;[none]: " /> 
								</td>
							</tr>
							
							<tr>
								<td >Storage</td>
								<td >
									<select name="storage.type">
									  <option value="swift" selected="true">swift</option>
									  <option value="ampli">amplistor</option>
									  <option value="mock">mock</option>
									  <option value="none">none</option>
									</select>
								</td>
								<td >
									<input name="storage.config" type="text" style="width:500px" value=""
					title="different storage system has different parameters: &#10 [swift]:  &#10 [ampli]: host=<host>;port=<port>;nsroot=<namespace root>;policy=<policy id> &#10; [mock]: delay=<time>;&#10 [none]: " /> 
								</td>
							</tr>
						</tbody>
					</table>
			</div>
		</div>
      	
      	<div id="workload-parameters" class="a2">
      		<table class="info-table">
						<thead>
							<tr>
								<th>Runtime(seconds)</th>
								<th>Rampup(seconds)</th>
								<th>Delay(seconds)</th>
								<th>Number of drivers</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>
									<input name="runtime" type="text" style="width:50px" value="300" />
								</td>								
								<td>
									<input name="rampup" type="text" style="width:100px" value="50" />
								</td>
                                <td>
									<input name="delay" type="text" style="width:100px" value="30" />
								</td>
                                <td>
									<input name="num_of_drivers" type="text" style="width:100px" value="1" />
								</td>
                                
							</tr>
						
						</tbody>
					</table>
      	</div>
      	
		<div id="workload" class="a1">
				
			
			<input type="checkbox" name="workload.metric.checked" checked="checked" onClick="toggleDiv(this.nextElementSibling);" style="float:left">
			<div name="workload.metric" id="workload.metric" class="a2" >
					<table class="info-table">
						<thead>
							<tr>
								<th>Object sizes </th>
								<th>Object size unit </th>
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
									<input name="object-sizes" type="text" style="width:150px" value="4,128,512" />
								</td>
								<td>
									<select name="object-size-unit">
										  <option value="B">Byte</option>
										  <option value="KB" selected="true">KB</option>
										  <option value="MB">MB</option>
										  <option value="GB">GB</option>
									</select>
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
					<a  href="javascript:void(0);" onclick="deleteMetricRow(this.parentNode.parentNode);"> remove metric row </a>
					
			</div>
			
		</div>
		
		<div class="a2">
			<input type="button" id="addMetricLine" value="Add Metric Row" onClick="addMetricRow();" />
		</div>
		
		<div class="a1">
			<br><br><br><br>
			<input name='submit-workload' type="submit" value="Submit Workload" style="width=500px">
			<input name='generate-workload' type="submit" value="Generate Workload Files">
			<input name="config" type="file" id="config" style="width:500px" />
		</div>
		
    </form>
    <p><a href="index.html">go back to index</a></p>    
  </div>

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