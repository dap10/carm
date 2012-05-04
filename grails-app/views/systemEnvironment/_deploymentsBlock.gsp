<g:each in="${applicationDeploymentsGrouped.entrySet()}" var="requestedDeploymentDateEntry">
    <div class="sectionHeader">
        <div class="text">
            <g:formatDate date="${requestedDeploymentDateEntry.key}" type="date" dateStyle="FULL"/>
        </div>
    </div>

    <div style="margin-bottom: 2em;">
        <g:if test="${requestedDeploymentDateEntry.value.size()}">
            <g:each in="${requestedDeploymentDateEntry.value.entrySet()}" var="deploymentEnvironmentEntry">
                <h3>${deploymentEnvironmentEntry.key}</h3>

                <g:each in="${deploymentEnvironmentEntry.value.entrySet()}" var="applicationTypeEntry">
                    <div style="margin-left: 2em;">
                        <h4>${applicationTypeEntry.key}</h4>

                        <ul style="margin-left: 1em;">
                            <g:each in="${applicationTypeEntry.value}" var="applicationDeployment">
                                <li>
                                    <g:link controller="application" action="show"
                                            id="${applicationDeployment.applicationRelease.application.id}"
                                            title="${message(code: 'showApplication.label')}">${applicationDeployment.applicationRelease.application.name}</g:link>

                                    (<g:link controller="applicationRelease" action="show"
                                             id="${applicationDeployment.applicationRelease.id}"
                                             title="${message(code: 'showApplicationRelease.label')}">${applicationDeployment.applicationRelease.releaseNumber}</g:link>) -

                                    <g:link controller="applicationDeployment" action="show"
                                            id="${applicationDeployment.id}"
                                            title="${message(code: 'showApplicationDeployment.label')}">
                                        <g:message code="viewDeployment.label" default="View Deployment"/>
                                    </g:link>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </g:each>
            </g:each>
        </g:if>
        <g:else>
            <p class="emphasis">
                <g:message code="noDeploymentsForThisDate.message"
                           default="There are no deployments for this date."/>
            </p>
        </g:else>
    </div>
</g:each>