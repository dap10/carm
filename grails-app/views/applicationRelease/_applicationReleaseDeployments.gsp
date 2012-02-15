<h2 class="sectionHeader">
    <g:message code="deployments.label" default="Deployments"/>
</h2>

<g:if test="${applicationReleaseInstance?.deployments?.size()}">
    <div class="list">
        <table style="width: 100%;">
            <thead>
            <tr>
                <th>
                    <g:message code="applicationDeployment.deploymentState.label" default="Deployment State"/>
                </th>
                <th>
                    <g:message code="applicationDeployment.environment.label" default="Environment"/>
                </th>
                <th>
                    <g:message code="applicationDeployment.requestedDeploymentDate.label"
                               default="Requested Deployment Date"/>
                </th>
                <th>
                    <g:message code="applicationDeployment.completedDeploymentDate.label"
                               default="Completed Deployment Date"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${applicationReleaseInstance?.deployments?.sort { it.completedDeploymentDate }?.reverse()}"
                    var="deploymentInstance" status="i">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>
                        <g:link controller="applicationDeployment" action="show" id="${deploymentInstance.id}">
                            ${deploymentInstance.deploymentState?.encodeAsHTML()}
                        </g:link>
                    </td>
                    <td>
                        <g:link controller="systemEnvironment" action="show" id="${deploymentInstance.environment.id}">
                            ${deploymentInstance.environment?.encodeAsHTML()}
                        </g:link>
                    </td>
                    <td>
                        <carm:formatDateOnly date="${deploymentInstance.requestedDeploymentDate}"/>
                    </td>
                    <td>
                        <carm:formatDateOnly date="${deploymentInstance.completedDeploymentDate}"/>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</g:if>
<g:else>
    <p class="emphasis">
        <g:message code="applicationReleaseDoesNotHaveAnyDeployments.message"
                   default="This application release does not have any deployments."/>
    </p>
</g:else>