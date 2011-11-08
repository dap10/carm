<%@ page import="net.lmxm.carm.System" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'system.label', default: 'System')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
</div>
<div class="body">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.name.label" default="Name"/></td>
                <td valign="top" class="value">${fieldValue(bean: systemInstance, field: "name")}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.description.label" default="Description"/></td>
                <td valign="top" class="value">${fieldValue(bean: systemInstance, field: "description")}</td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.components.label" default="Components"/></td>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${systemInstance.components}" var="c">
                            <li><g:link controller="systemComponent" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                    <g:link controller="systemComponent" action="create" params="['system.id': systemInstance?.id]">Add Component</g:link>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.environments.label" default="Environments"/></td>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${systemInstance.environments}" var="e">
                            <li><g:link controller="systemEnvironment" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                    <g:link controller="systemEnvironment" action="create" params="['system.id': systemInstance?.id]">Add Environment</g:link>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.dateCreated.label" default="Date Created"/></td>
                <td valign="top" class="value"><g:formatDate date="${systemInstance?.dateCreated}"/></td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="system.lastUpdated.label" default="Last Updated"/></td>
                <td valign="top" class="value"><g:formatDate date="${systemInstance?.lastUpdated}"/></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="buttons">
        <g:form>
            <g:hiddenField name="id" value="${systemInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </g:form>
    </div>
</div>
</body>
</html>
