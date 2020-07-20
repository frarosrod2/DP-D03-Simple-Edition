<%@page language="java" %>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="acme" tagdir="/WEB-INF/tags" %>

<acme:form>
	<acme:form-textbox code="administrator.overture.form.label.title" path="title"/>
	<acme:form-textbox code="administrator.overture.form.label.creation" path="creation"/>
	<acme:form-textbox code="administrator.overture.form.label.deadline" path="deadline"/>
	<acme:form-textarea code="administrator.overture.form.label.description" path="description"/>
	<acme:form-textbox code="administrator.overture.form.label.range" path="range"/>
	<acme:form-textbox code="administrator.overture.form.label.email" path="email"/>

	<acme:form-submit test="${command=='show'}"
		action="/administrator/overture/update"
		code="administrator.overture.form.button.update"/>
	
	<acme:form-submit test="${command=='show'}"
		action="/administrator/overture/delete"
		code="administrator.overture.form.button.delete"/>
	
	<acme:form-submit test="${command=='create'}"
		action="/administrator/overture/create"
		code="administrator.overture.form.button.create"/>
	
	<acme:form-submit test="${command=='update'}"
		action="/administrator/overture/update"
		code="administrator.overture.form.button.update"/>
	
	<acme:form-submit test="${command=='delete'}"
		action="/administrator/overture/delete"
		code="administrator.overture.form.button.delete"/>
	


	<acme:form-return code="administrator.overture.form.button.return" />	
</acme:form> 