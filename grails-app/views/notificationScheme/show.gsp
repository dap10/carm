<%@ page import="carm.notification.NotificationEvent" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <r:require modules="common"/>
    <g:set var="entityName" value="${message(code: 'notificationScheme.label', default: 'Notification Scheme')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<carm:header domain="${notificationSchemeInstance}"/>

<g:render template="/common/messages"/>

<g:if test="${notificationSchemeInstance?.description}">
    <carm:plainText value="${notificationSchemeInstance?.description}"/>
</g:if>

<table class="table table-striped" style="margin-top: 2em;">
    <thead>
    <tr>
        <th><g:message code="event.label" default="Event"/></th>
        <th><g:message code="notifications.label" default="Notifications"/></th>
        <th><g:message code="actions.label" default="Actions"/></th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${NotificationEvent.values()}" var="notificationEvent">
        <g:set var="notifications" value="${notificationsGroupsByEvent.get(notificationEvent)}"/>

        <tr>
            <td class="span4">
                <strong><carm:formatNotificationEvent notificationEvent="${notificationEvent}"/></strong>
            </td>
            <td class="span6">
                <g:if test="${notifications?.size()}">
                    <ul>
                        <g:each in="${notifications}" var="notification">
                            <li>
                                <carm:formatNotification notification="${notification}"/>

                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    <carm:deleteLink action="deleteNotification" id="${notification.id}"
                                                     showText="false"
                                                     title="${message(code: 'deleteNotification.label')}">
                                        <img align="top" src='${fam.icon(name: 'delete')}' alt="Delete"/>
                                    </carm:deleteLink>
                                </sec:ifAllGranted>
                            </li>
                        </g:each>
                    </ul>
                </g:if>
            </td>
            <td class="span2">
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <img align="top" src='${fam.icon(name: 'add')}' alt="Add"/>
                    <g:link action="addNotification" id="${notificationSchemeInstance.id}"
                            params="[notificationEvent: notificationEvent]"><g:message
                            code="addNotification.label"/>
                    </g:link>
                </sec:ifAllGranted>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

</body>
</html>
