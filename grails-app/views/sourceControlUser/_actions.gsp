<g:if test="${params.action == 'show'}">
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <div class="header-action delete-user-action">
            <carm:deleteLink id="${sourceControlUserInstance.id}"/>
        </div>

        <div class="header-action edit-user-action">
            <g:link action="edit" id="${sourceControlUserInstance.id}"><g:message
                    code="default.button.edit.label"
                    default="Edit"/></g:link>
        </div>
    </sec:ifAllGranted>
</g:if>