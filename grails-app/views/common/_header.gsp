<%@ page import="carm.Application; carm.ApplicationType; carm.Module; carm.ModuleType; carm.Project; carm.ProjectCategory; carm.SystemComponent; carm.SystemEnvironment; carm.SourceControlRepository; carm.SourceControlServer" %>

<g:set var="action" value="${params.action}"/>
<g:set var="controller" value="${params.controller}"/>

<g:if test="${controller == 'administration'}">
    <g:pageHeaderLabel action="show" beanName="${pageName}"/>
</g:if>
<g:elseif test="${controller == 'application'}">
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listApplications isFirst="true"/>
        </g:if>
        <g:else>
            <bc:listProjects isFirst="true"/>
            <bc:showProject project="${domain.project}"/>

            <g:if test="${action == 'show'}">
                <bc:showApplication application="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showApplication application="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'applicationDeployment'}">
    <g:set var="entityName" value="${message(code: 'applicationDeployment.label', default: 'Application Deployment')}"/>

    <g:pageHeaderLabel action="${action}"
                       beanName="${domain?.applicationRelease?.application?.name} - Release ${domain?.applicationRelease?.releaseNumber}"
                       entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listApplicationDeployments isFirst="true"/>
        </g:if>
        <g:else>
            <bc:listProjects isFirst="true"/>
            <bc:showProject project="${domain.applicationRelease.application.project}"/>
            <bc:showApplication application="${domain.applicationRelease.application}"/>

            <g:if test="${action == 'show'}">
                <bc:showApplicationDeployment applicationDeployment="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showApplicationDeployment applicationDeployment="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'applicationRelease'}">
    <g:set var="entityName" value="${message(code: 'applicationRelease.label', default: 'Application Release')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.application?.name} - Release ${domain?.releaseNumber}"
                       entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listApplicationReleases isFirst="true"/>
        </g:if>
        <g:else>
            <bc:listProjects isFirst="true"/>
            <bc:showProject project="${domain.application.project}"/>
            <bc:showApplication application="${domain.application}"/>

            <g:if test="${action == 'show'}">
                <bc:showApplicationRelease applicationRelease="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showApplicationRelease applicationRelease="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'applicationReleaseTestState'}">
    <g:set var="entityName"
           value="${message(code: 'applicationReleaseTestState.label', default: 'Application Release Test State')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listApplicationReleaseTestStates/>

        <g:if test="${action == 'show'}">
            <bc:link controller="applicationReleaseTestState" action="show"
                     title="Show Application Release Test State" text="${domain.name}" id="${domain.id}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:link controller="applicationReleaseTestState" action="show"
                     title="Show Application Release Test State" text="${domain.name}" id="${domain.id}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'applicationType'}">
    <g:set var="entityName" value="${message(code: 'applicationType.label', default: 'Application Type')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listApplicationTypes/>

        <g:if test="${action == 'show'}">
            <bc:showApplicationType applicationType="${domain}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:showApplicationType applicationType="${domain}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller ==~ /.*home/}">
    <g:pageHeaderLabel action="show" beanName="${pageName}"/>
</g:elseif>
<g:elseif test="${controller == 'module'}">
    <g:set var="entityName" value="${message(code: 'module.label', default: 'Module')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listModules isFirst="true"/>
        </g:if>
        <g:else>
            <bc:showProject project="${domain.application.project}" isFirst="true"/>
            <bc:showApplication application="${domain.application}"/>

            <g:if test="${action == 'show'}">
                <bc:showModule module="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showModule module="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'moduleType'}">
    <g:set var="entityName" value="${message(code: 'moduleType.label', default: 'Module Type')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listModuleTypes/>

        <g:if test="${action == 'show'}">
            <bc:showModuleType moduleType="${domain}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:showModuleType moduleType="${domain}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'project'}">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action != 'list'}">
            <bc:listProjects isFirst="true"/>

            <g:if test="${action == 'show'}">
                <bc:showProject project="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showProject project="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>

        </g:if>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'projectCategory'}">
    <g:set var="entityName" value="${message(code: 'projectCategory.label', default: 'Project Category')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listProjectCategories/>

        <g:if test="${action == 'show'}">
            <bc:showProjectCategory projectCategory="${domain}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:showProjectCategory projectCategory="${domain}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'sourceControlRepository'}">
    <g:set var="entityName"
           value="${message(code: 'sourceControlRepository.label', default: 'Source Control Repository')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>

        <g:if test="${action == 'list'}">
            <bc:listSourceControlRepositories/>
        </g:if>
        <g:else>
            <bc:showSourceControlServer sourceControlServer="${domain}"/>

            <g:if test="${action == 'show'}">
                <bc:showSourceControlRepository sourceControlRepository="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showSourceControlRepository sourceControlRepository="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'sourceControlRole'}">
    <g:set var="entityName" value="${message(code: 'sourceControlRole.label', default: 'Source Control Role')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listSourceControlRoles/>

        <g:if test="${action == 'show'}">
            <bc:showSourceControlRole sourceControlRole="${domain}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:showSourceControlRole sourceControlRole="${domain}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'sourceControlServer'}">
    <g:set var="entityName" value="${message(code: 'sourceControlServer.label', default: 'Source Control Server')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>
        <bc:listSourceControlServers/>

        <g:if test="${action == 'show'}">
            <bc:showSourceControlServer sourceControlServer="${domain}"/>
        </g:if>
        <g:elseif test="${action == 'create' || action == 'save'}">
            <bc:createLabel entityName="${entityName}"/>
        </g:elseif>
        <g:elseif test="${action == 'edit' || action == 'update'}">
            <bc:showSourceControlServer sourceControlServer="${domain}"/>
            <bc:editLabel entityName="${entityName}"/>
        </g:elseif>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'sourceControlUser'}">
    <g:set var="entityName" value="${message(code: 'sourceControlUser.label', default: 'Source Control User')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <bc:administration isFirst="true"/>

        <g:if test="${action == 'list'}">
            <bc:listSourceControlUsers/>
        </g:if>
        <g:else>
            <bc:showSourceControlServer sourceControlServer="${domain.server}"/>

            <g:if test="${action == 'show'}">
                <bc:showSourceControlUser sourceControlUser="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showSourceControlUser sourceControlUser="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'system'}">
    <g:set var="entityName" value="${message(code: 'system.label', default: 'System')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action != 'list'}">
            <bc:listSystems isFirst="true"/>

            <g:if test="${action == 'show'}">
                <bc:showSystem system="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showSystem system="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:if>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'systemComponent'}">
    <g:set var="entityName" value="${message(code: 'systemComponent.label', default: 'System Component')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listSystemComponents/>
        </g:if>
        <g:else>
            <bc:listSystems isFirst="true"/>
            <bc:showSystem system="${domain.system}"/>

            <g:if test="${action == 'show'}">
                <bc:showSystemComponent systemComponent="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showSystemComponent systemComponent="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>
<g:elseif test="${controller == 'systemEnvironment'}">
    <g:set var="entityName" value="${message(code: 'systemEnvironment.label', default: 'System Environment')}"/>

    <g:pageHeaderLabel action="${action}" beanName="${domain?.name}" entityName="${entityName}"/>

    <bc:breadcrumbs>
        <g:if test="${action == 'list'}">
            <bc:listSystemEnvironments/>
        </g:if>
        <g:else>
            <bc:listSystems isFirst="true"/>
            <bc:showSystem system="${domain.system}"/>

            <g:if test="${action == 'show'}">
                <bc:showSystemEnvironment systemEnvironment="${domain}"/>
            </g:if>
            <g:elseif test="${action == 'create' || action == 'save'}">
                <bc:createLabel entityName="${entityName}"/>
            </g:elseif>
            <g:elseif test="${action == 'edit' || action == 'update'}">
                <bc:showSystemEnvironment systemEnvironment="${domain}"/>
                <bc:editLabel entityName="${entityName}"/>
            </g:elseif>
        </g:else>
    </bc:breadcrumbs>
</g:elseif>