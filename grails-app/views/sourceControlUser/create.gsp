<%@ page import="carm.SourceControlUser" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'sourceControlUser.label', default: 'Source Control User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="body">
    <carm:header domain="${sourceControlUserInstance}"/>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${sourceControlUserInstance}">
        <div class="errors">
            <g:renderErrors bean="${sourceControlUserInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="server.id">
                            <g:message code="sourceControlUser.server.label" default="Source Control Server"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlUserInstance, field: 'server', 'errors')}">
                        ${sourceControlUserInstance?.server?.name?.encodeAsHTML()}
                        <g:hiddenField name="server.id" value="${sourceControlUserInstance?.server?.id}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">
                            <g:message code="sourceControlUser.name.label" default="Name"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlUserInstance, field: 'name', 'errors')}">
                        <g:textField name="name" maxlength="50" value="${sourceControlUserInstance?.name}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description">
                            <g:message code="sourceControlUser.description.label" default="Description"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlUserInstance, field: 'description', 'errors')}">
                        <g:textArea name="description" cols="40" rows="5"
                                    value="${sourceControlUserInstance?.description}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="user.id">
                            <g:message code="sourceControlUser.user.label" default="User"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlUserInstance, field: 'user', 'errors')}">
                        <g:select name="user.id" from="${carm.security.User.list().sort { it.username }}" optionKey="id"
                                  value="${sourceControlUserInstance?.user?.id}" noSelection="['null': '']"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button">
                <g:link class="show" controller="sourceControlServer" action="show"
                        id="${sourceControlUserInstance?.server?.id}">
                    <g:message code="default.button.cancel.label" default="Cancel"/>
                </g:link>
            </span>
            <span class="button">
                <g:submitButton name="create" class="save"
                                value="${message(code: 'default.button.create.label', default: 'Create')}"/>
            </span>
        </div>
    </g:form>
</div>
</body>
</html>
