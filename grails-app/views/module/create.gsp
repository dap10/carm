

<%@ page import="net.lmxm.carm.Module" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'module.label', default: 'Module')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${moduleInstance}">
            <div class="errors">
                <g:renderErrors bean="${moduleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="module.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="50" value="${moduleInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="module.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${moduleInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="module.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'type', 'errors')}">
                                    <g:select name="type.id" from="${net.lmxm.carm.ModuleType.list()}" optionKey="id" value="${moduleInstance?.type?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="project"><g:message code="module.project.label" default="Project" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'project', 'errors')}">
                                    <g:select name="project.id" from="${net.lmxm.carm.Project.list()}" optionKey="id" value="${moduleInstance?.project?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sourceControlServer"><g:message code="module.sourceControlServer.label" default="Source Control Server" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'sourceControlServer', 'errors')}">
                                    <g:select name="sourceControlServer.id" from="${net.lmxm.carm.SourceControlServer.list()}" optionKey="id" value="${moduleInstance?.sourceControlServer?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sourceControlPath"><g:message code="module.sourceControlPath.label" default="Source Control Path" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleInstance, field: 'sourceControlPath', 'errors')}">
                                    <g:textField name="sourceControlPath" value="${moduleInstance?.sourceControlPath}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>