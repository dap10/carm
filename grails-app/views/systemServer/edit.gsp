<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <r:require modules="common"/>
    <g:set var="entityName" value="${message(code: 'systemServer.label', default: 'SystemEnvironment Server')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<carm:header domain="${systemServerInstance}"/>

<g:render template="/common/messages"/>
<g:hasErrors bean="${systemServerInstance}">
    <div class="alert alert-error">
        <h4><g:message code="systemServer.error.update"/></h4>
        <g:renderErrors bean="${systemServerInstance}" as="list"/>
    </div>
</g:hasErrors>

<g:form action="update" method="post" class="offset1 span8">
    <g:hiddenField name="id" value="${systemServerInstance?.id}"/>
    <g:hiddenField name="version" value="${systemServerInstance?.version}"/>

    <div class="control-group ${hasErrors(bean: systemServerInstance, field: 'name', 'error')}">
        <carm:label class="control-label" for="name" required="true">
            <g:message code="systemServer.name.label" default="Name"/>
        </carm:label>
        <div class="controls">
            <g:textField name="name" maxlength="50" size="50"
                         value="${systemServerInstance?.name}"
                         required="required"
                         title="${message(code: 'systemServer.name.help')}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: systemServerInstance, field: 'description', 'error')}">
        <carm:label class="control-label" for="description">
            <g:message code="systemServer.description.label" default="Description"/>
        </carm:label>
        <div class="controls">
            <g:textArea name="description"
                        cols="${grailsApplication.config.ui.textarea.cols}"
                        rows="${grailsApplication.config.ui.textarea.rows}"
                        value="${systemServerInstance?.description}"
                        title="${message(code: 'systemServer.description.help')}"/>
        </div>
    </div>

    <carm:formButtons>
        <g:submitButton class="btn btn-primary" name="save"
                        value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        <g:link class="btn" action="show" id="${systemServerInstance.id}">
            <g:message code="default.button.cancel.label" default="Cancel"/>
        </g:link>
    </carm:formButtons>
</g:form>
</body>
</html>
