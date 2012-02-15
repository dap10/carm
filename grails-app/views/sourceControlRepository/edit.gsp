<%@ page import="carm.SourceControlRepository" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'sourceControlRepository.label', default: 'Source Control Repository')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="body">
    <carm:header domain="${sourceControlRepositoryInstance}"/>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${sourceControlRepositoryInstance}">
        <div class="errors">
            <g:renderErrors bean="${sourceControlRepositoryInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="update" method="post">
        <g:hiddenField name="id" value="${sourceControlRepositoryInstance?.id}"/>
        <g:hiddenField name="version" value="${sourceControlRepositoryInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <carm:label for="server.id">
                            <g:message code="sourceControlRepository.server.label" default="Source Control Server"/>
                        </carm:label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlRepositoryInstance, field: 'server', 'errors')}">
                        <g:link controller="sourceControlServer" action="show"
                                id="${sourceControlRepositoryInstance?.server?.id}">
                            ${sourceControlRepositoryInstance?.server?.name?.encodeAsHTML()}
                        </g:link>
                        <g:hiddenField name="server.id" value="${sourceControlRepositoryInstance?.server?.id}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <carm:label for="name" required="true">
                            <g:message code="sourceControlRepository.name.label" default="Name"/>
                        </carm:label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlRepositoryInstance, field: 'name', 'errors')}">
                        <g:textField name="name" maxlength="50" size="50"
                                     value="${sourceControlRepositoryInstance?.name}"
                                     required="required"
                                     title="${message(code: 'sourceControlRepository.name.help')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <carm:label for="description">
                            <g:message code="sourceControlRepository.description.label" default="Description"/>
                        </carm:label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlRepositoryInstance, field: 'description', 'errors')}">
                        <g:textArea name="description"
                                    cols="${grailsApplication.config.ui.textarea.cols}"
                                    rows="${grailsApplication.config.ui.textarea.rows}"
                                    value="${sourceControlRepositoryInstance?.description}"
                                    title="${message(code: 'sourceControlRepository.description.help')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <carm:label for="path" required="true">
                            <g:message code="sourceControlRepository.path.label" default="Path"/>
                        </carm:label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: sourceControlRepositoryInstance, field: 'path', 'errors')}">
                        <g:textField name="path" maxlength="200" size="50"
                                     value="${sourceControlRepositoryInstance?.path}"
                                     required="required"
                                     title="${message(code: 'sourceControlRepository.path.help')}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <carm:requiredLabelMessage/>

        <div class="buttons">
            <span class="button">
                <g:link class="show" action="show" id="${sourceControlRepositoryInstance.id}">
                    <g:message code="default.button.cancel.label" default="Cancel"/>
                </g:link>
            </span>
            <span class="button">
                <g:submitButton name="save" class="save"
                                value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            </span>
        </div>
    </g:form>
</div>
</body>
</html>
