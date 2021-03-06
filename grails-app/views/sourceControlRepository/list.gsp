<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <r:require modules="common"/>
    <g:set var="entityName"
           value="${message(code: 'sourceControlRepository.label', default: 'Source Control Repository')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<carm:header domain="${sourceControlRepositoryInstanceList}"/>

<g:render template="/common/messages"/>

<table class="table table-striped">
    <thead>
    <tr>
        <g:sortableColumn property="name"
                          title="${message(code: 'sourceControlRepository.name.label', default: 'Name')}"/>
        <g:sortableColumn property="description"
                          title="${message(code: 'sourceControlRepository.description.label', default: 'Description')}"/>
        <th>
            <g:message code="sourceControlRepository.server.label" default="Server"/>
        </th>
        <g:sortableColumn property="path"
                          title="${message(code: 'sourceControlRepository.path.label', default: 'Path')}"/>
    </tr>
    </thead>
    <tbody>
    <g:each in="${sourceControlRepositoryInstanceList}" status="i" var="sourceControlRepositoryInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td>
                <g:link action="show" id="${sourceControlRepositoryInstance.id}">
                    ${fieldValue(bean: sourceControlRepositoryInstance, field: "name")}
                </g:link>
            </td>
            <td>
                <div class="expander">
                    <carm:plainText value="${sourceControlRepositoryInstance.description}"/>
                </div>
            </td>
            <td>
                <g:link controller="sourceControlServer" action="show"
                        id="${sourceControlRepositoryInstance.server.id}">
                    ${fieldValue(bean: sourceControlRepositoryInstance, field: "server")}
                </g:link>
            </td>
            <td>
                ${fieldValue(bean: sourceControlRepositoryInstance, field: "path")}
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<carm:paginate total="${sourceControlRepositoryInstanceTotal}"
               max="${grailsApplication.config.ui.sourceControlRepository.listMax}"/>

</body>
</html>
