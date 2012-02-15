<%@ page import="carm.ModuleDeploymentTestState" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'moduleDeploymentTestState.label', default: 'Module Deployment Test State')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="body">
    <carm:header domain="${moduleDeploymentTestStateInstance}"
              pageName="${message(code: 'default.create.label', args: [entityName])}"/>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${moduleDeploymentTestStateInstance}">
        <div class="errors">
            <g:renderErrors bean="${moduleDeploymentTestStateInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">
                            <g:message code="moduleDeploymentTestState.name.label" default="Name"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: moduleDeploymentTestStateInstance, field: 'name', 'errors')}">
                        <g:textField name="name" maxlength="50" value="${moduleDeploymentTestStateInstance?.name}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description">
                            <g:message code="moduleDeploymentTestState.description.label" default="Description"/>
                        </label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: moduleDeploymentTestStateInstance, field: 'description', 'errors')}">
                        <g:textArea name="description" cols="40" rows="5"
                                    value="${moduleDeploymentTestStateInstance?.description}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button">
                <g:link class="list" action="list">
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
