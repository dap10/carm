<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <r:require modules="common"/>
    <g:set var="entityName" value="${message(code: 'sourceControlUser.label', default: 'Source Control User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<carm:header domain="${sourceControlUserInstance}"/>

<g:render template="/common/messages"/>
<g:hasErrors bean="${sourceControlUserInstance}">
    <div class="alert alert-error">
        <h4><g:message code="sourceControlUser.error.update"/></h4>
        <g:renderErrors bean="${sourceControlUserInstance}" as="list"/>
    </div>
</g:hasErrors>

<g:form action="update" method="post" class="offset1 span8">
    <g:hiddenField name="id" value="${sourceControlUserInstance?.id}"/>
    <g:hiddenField name="version" value="${sourceControlUserInstance?.version}"/>
    <g:hiddenField name="server.id" value="${sourceControlUserInstance?.server?.id}"/>

    <div class="control-group ${hasErrors(bean: sourceControlUserInstance, field: 'name', 'error')}">
        <carm:label class="control-label" for="name" required="true">
            <g:message code="sourceControlUser.name.label" default="Name"/>
        </carm:label>
        <div class="controls">
            <g:textField name="name" maxlength="50" size="50"
                         required="required"
                         value="${sourceControlUserInstance?.name}"
                         title="${message(code: 'sourceControlUser.name.help')}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: sourceControlUserInstance, field: 'description', 'error')}">
        <carm:label class="control-label" for="description">
            <g:message code="sourceControlUser.description.label" default="Description"/>
        </carm:label>
        <div class="controls">
            <g:textArea name="description"
                        cols="${grailsApplication.config.ui.textarea.cols}"
                        rows="${grailsApplication.config.ui.textarea.rows}"
                        value="${sourceControlUserInstance?.description}"
                        title="${message(code: 'sourceControlUser.description.help')}"/>
        </div>
    </div>

    <div class="control-group ${hasErrors(bean: sourceControlUserInstance, field: 'description', 'error')}">
        <carm:label class="control-label" for="user.id">
            <g:message code="sourceControlUser.user.label" default="User"/>
        </carm:label>
        <div class="controls">
            <g:select name="user.id" from="${userList}" optionKey="id"
                      value="${sourceControlUserInstance?.user?.id}" noSelection="['null': '']"
                      title="${message(code: 'sourceControlUser.user.help')}"/>
        </div>
    </div>

    <carm:formButtons>
        <g:submitButton class="btn btn-primary" name="save"
                        value="${message(code: 'default.button.update.label', default: 'Update')}"/>
        <g:link class="btn" action="show" id="${sourceControlUserInstance.id}">
            <g:message code="default.button.cancel.label" default="Cancel"/>
        </g:link>
    </carm:formButtons>
</g:form>
</body>
</html>
