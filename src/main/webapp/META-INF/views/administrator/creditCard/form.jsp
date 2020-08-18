<%--
- form.jsp
-
- Copyright (c) 2019 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non- use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@page language="java"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>

<acme:form readonly="${command == 'show'}">
	<acme:form-textbox code="administrator.creditCard.label.holder" path="holderName" />
	<acme:form-textbox code="administrator.creditCard.label.number" path="number" />
	<acme:form-textbox code="administrator.creditCard.label.brand" path="brand" />
	<acme:form-textbox code="administrator.creditCard.label.cvv" path="cvv" />
	<acme:form-textbox code="administrator.creditCard.label.expMonth" path="expMonth" />
	<acme:form-textbox code="administrator.creditCard.label.expYear" path="expYear" />
	
	<!-- Botones -->
	<acme:form-submit method="post" test="${command == 'create'}" code="administrator.creditCard.button.create" action="/administrator/credit-card/create" />
	<acme:form-submit test="${command == 'update'}" code="administrator.creditCard.button.update" action="/administrator/credit-card/update" />
	<acme:form-submit test="${command == 'show'}" code="administrator.creditCard.button.delete"
		action="/administrator/credit-card/delete"/>
	<acme:form-submit test="${command == 'delete'}" code="administrator.creditCard.button.delete"
	action="/administrator/credit-card/delete"/>
	
	<input id="banner" name="bannerId" value="${bannerId}" type="hidden" />
	<input id="creditCard" name="creditCard" value="${creditCard}" type="hidden" />
	<acme:form-return code="administrator.creditCard.button.return" />
</acme:form>