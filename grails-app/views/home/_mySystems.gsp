<div class="sectionHeader">
    <div class="text">
        <g:message code="myEnvironments.label" default="My Environments"/>
    </div>

    <div class="actions">
        <g:link controller="systemEnvironment" action="list">
            <g:message code="allSystems.label" default="All Systems"/>
        </g:link>
    </div>
</div>

<g:if test="${mySystemEnvironments.size()}">
    <g:each in="${mySystemEnvironments}" var="systemInstance" status="systemIndex">
        <div style="margin: 0.5em 0;">
            <h3>
                <g:link controller="systemEnvironment" action="show" id="${systemInstance.id}">
                    ${systemInstance.encodeAsHTML()}
                </g:link>
            </h3>

            <div style="margin-left: 1.5em;">
                <g:each in="${systemInstance.environments}" var="systemDeploymentEnvironment" status="i">
                    <g:link controller="systemDeploymentEnvironment" action="show"
                            id="${systemDeploymentEnvironment.id}">${systemDeploymentEnvironment.encodeAsHTML()}</g:link><g:if
                        test="${(i + 1) < systemInstance.environments.size()}">,</g:if>
                </g:each>
            </div>

            <div style="margin: 0.5em 0;">
                <div style="float:left; padding-right: 1em;">
                    <g:link controller="systemEnvironment" action="completedDeployments" id="${systemInstance.id}">
                        <g:message code="completedDeployments.label" default="Completed Deployments"/>
                    </g:link>
                </div>

                <div style="float:left; padding-right: 1em;">
                    <g:link controller="systemEnvironment" action="upcomingDeployments" id="${systemInstance.id}">
                        <g:message code="upcomingDeployments.label" default="Upcoming Deployments"/>
                    </g:link>
                </div>

                <div class="clearing"></div>
            </div>
        </div>

        <g:if test="${(systemIndex + 1) < mySystemEnvironments.size()}">
            <hr class="divider"/>
        </g:if>
    </g:each>
</g:if>
<g:else>
    <p class="emphasis">
        <g:message code="youDontWorkOnAnyProjectsAssociatedWithAnEnvironment.message"
                   default="You don't work on any projects associated with an environment."/>
    </p>
</g:else>