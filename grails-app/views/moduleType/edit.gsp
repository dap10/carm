<%@ page import="carm.ModuleType" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'moduleType.label', default: 'ModuleType')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<div class="body">
    <g:header domain="${moduleTypeInstance}" pageName="${message(code: 'default.edit.label', args: [entityName])}" />

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${moduleTypeInstance}">
        <div class="errors">
            <g:renderErrors bean="${moduleTypeInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form method="post" >
        <g:hiddenField name="id" value="${moduleTypeInstance?.id}" />
        <g:hiddenField name="version" value="${moduleTypeInstance?.version}" />
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                      <label for="name"><g:message code="moduleType.name.label" default="Name" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: moduleTypeInstance, field: 'name', 'errors')}">
                        <g:textField name="name" maxlength="50" value="${moduleTypeInstance?.name}" />
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                      <label for="description"><g:message code="moduleType.description.label" default="Description" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: moduleTypeInstance, field: 'description', 'errors')}">
                        <g:textArea name="description" cols="40" rows="5" value="${moduleTypeInstance?.description}" />
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
        </div>
    </g:form>
</div>
</body>
</html>
