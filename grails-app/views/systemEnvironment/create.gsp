<%@ page import="carm.SystemEnvironment" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'systemEnvironment.label', default: 'System Environment')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="body">
    <carm:header domain="${systemEnvironmentInstance}"/>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${systemEnvironmentInstance}">
        <div class="errors">
            <g:renderErrors bean="${systemEnvironmentInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="system.id">
                            <g:message code="systemEnvironment.system.label" default="System"/>
                        </label>
                    </td>
                    <td valign="top" class="value">
                        ${systemEnvironmentInstance?.system?.encodeAsHTML()}
                        <g:hiddenField name="system.id" value="${systemEnvironmentInstance?.system?.id}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">
                            <g:message code="systemEnvironment.name.label" default="Name"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: systemEnvironmentInstance, field: 'name', 'errors')}">
                        <g:textField name="name" maxlength="50" value="${systemEnvironmentInstance?.name}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description">
                            <g:message code="systemEnvironment.description.label" default="Description"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: systemEnvironmentInstance, field: 'description', 'errors')}">
                        <g:textArea name="description" cols="40" rows="5"
                                    value="${systemEnvironmentInstance?.description}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button">
                <g:link class="show" controller="system" action="show" id="${systemEnvironmentInstance.system.id}">
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
