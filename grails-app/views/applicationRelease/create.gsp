<%@ page import="carm.ApplicationRelease" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'applicationRelease.label', default: 'ApplicationRelease')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <resource:richTextEditor type="${grailsApplication.config.ui.richTextEditor.type}" />
</head>
<body>
<div class="body">
    <g:header domain="${applicationReleaseInstance}" />

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <g:hasErrors bean="${applicationReleaseInstance}">
        <div class="errors">
            <g:renderErrors bean="${applicationReleaseInstance}" as="list" />
        </div>
    </g:hasErrors>

    <g:form action="save" >
        <div class="dialog">
            <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="application"><g:message code="applicationRelease.application.label" default="Application" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: applicationReleaseInstance, field: 'application', 'errors')}">
                    ${applicationReleaseInstance?.application?.encodeAsHTML()}
                    <g:hiddenField name="application.id" value="${applicationReleaseInstance?.application?.id}" />
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="releaseNumber"><g:message code="applicationRelease.releaseNumber.label" default="Release Number"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: applicationReleaseInstance, field: 'releaseNumber', 'errors')}">
                    <g:textField name="releaseNumber" maxlength="20" value="${applicationReleaseInstance?.releaseNumber}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="buildPath"><g:message code="applicationRelease.buildPath.label" default="Build Path"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: applicationReleaseInstance, field: 'buildPath', 'errors')}">
                    <g:textField name="buildPath" maxlength="20" value="${applicationReleaseInstance?.buildPath}"/>
                    <br/>
                    <g:formatSourceControl application="${applicationReleaseInstance.application}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="changeLog"><g:message code="applicationRelease.changeLog.label" default="Change Log" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: applicationReleaseInstance, field: 'changeLog', 'errors')}">
                    <richui:richTextEditor name="changeLog" value="${applicationReleaseInstance?.changeLog}"
                                           height="${grailsApplication.config.ui.richTextEditor.height}"
                                           width="${grailsApplication.config.ui.richTextEditor.width}" />
                </td>
            </tr>
            </tbody>
            </table>
        </div>
        <div class="buttons">
            <span class="button">
                <g:link class="show" controller="application" action="show" id="${applicationReleaseInstance?.application?.id}">
                    <g:message code="default.button.cancel.label" default="Cancel"/>
                </g:link>
            </span>
            <span class="button">
                <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </span>
        </div>
    </g:form>
</div>
</body>
</html>
