<%@ page import="carm.ModuleDeploymentTestState" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'moduleDeploymentTestState.label', default: 'ModuleDeploymentTestState')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="body">
    <g:header domain="${moduleDeploymentTestStateInstanceList}" pageName="${message(code: 'default.list.label', args: [entityName])}" />

    <sec:ifAllGranted roles="ROLE_ADMIN">
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
        </div>
    </sec:ifAllGranted>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <div class="list">
        <table>
            <thead>
            <tr>
                <g:sortableColumn property="name" title="${message(code: 'moduleDeploymentTestState.name.label', default: 'Name')}"/>
                <g:sortableColumn property="description" title="${message(code: 'moduleDeploymentTestState.description.label', default: 'Description')}"/>
            </tr>
            </thead>
            <tbody>
            <g:each in="${moduleDeploymentTestStateInstanceList}" status="i" var="moduleDeploymentTestStateInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td><g:link action="show" id="${moduleDeploymentTestStateInstance.id}">${fieldValue(bean: moduleDeploymentTestStateInstance, field: "name")}</g:link></td>
                    <td>${fieldValue(bean: moduleDeploymentTestStateInstance, field: "description")}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <div class="paginateButtons">
        <g:paginate total="${moduleDeploymentTestStateInstanceTotal}"/>
    </div>
</div>
</body>
</html>