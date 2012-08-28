<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Manage Programs" otherwise="/login.htm" redirect="/admin/programs/program.list" />

<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>

<h2><openmrs:message code="Program.manage.title"/></h2>

<a href="program.form"><openmrs:message code="Program.add"/></a>

<br /><br />

<b class="boxHeader"><openmrs:message code="Program.list.title"/></b>
<div class="box">
	<c:if test="${fn:length(programList) == 0}">
		<tr>
			<td colspan="5"><openmrs:message code="general.none"/></td>
		</tr>
	</c:if>
	<c:if test="${fn:length(programList) != 0}">
		<table cellspacing="0" cellpadding="2">
			<tr>
				<th> <openmrs:message code="general.id"/> </th>
				<th> <openmrs:message code="general.name"/> </th>
				<th> <openmrs:message code="general.description"/> </th>
				<th> <openmrs:message code="Concept.name"/> </th>
				<th> <openmrs:message code="Program.workflows"/> </th>
			</tr>
			<c:forEach var="program" items="${programList}">
				<tr>
					<c:if test="${program.retired}">
						<td colspan="5">
							<i><openmrs:message code="general.retired"/><strike>
								<a href="program.form?programId=${program.programId}">${program.name}</a>
							</strike></i>
						</td>
					</c:if>
					<c:if test="${!program.retired}">
						<td valign="top">
							${program.programId}
						</td>
						<td valign="top">
							<a href="program.form?programId=${program.programId}">${program.name}</a>
						</td>
						<td valign="top">
							${program.description}
						</td>
						<openmrs:concept conceptId="${program.concept.conceptId}" var="v" nameVar="n" numericVar="num">
							<td valign="top">
								${n.name}
							</td>
						</openmrs:concept>
						<td>
							<c:forEach var="workflow" items="${program.workflows}">
								<a href="workflow.form?programWorkflowId=${workflow.programWorkflowId}">
									<openmrs_tag:concept conceptId="${workflow.concept.conceptId}"/>
									(${fn:length(workflow.states)})
								</a>
								<br/>
							</c:forEach>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</div>

<%@ include file="/WEB-INF/template/footer.jsp" %>