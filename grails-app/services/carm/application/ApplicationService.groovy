package carm.application

import static carm.security.CarmPermission.APPLICATION_DEVELOPER
import static carm.security.CarmPermission.APPLICATION_TEAM_LEADER

import org.springframework.transaction.annotation.Transactional
import org.springframework.security.access.prepost.PreAuthorize
import carm.notification.NotificationScheme
import carm.project.Project
import carm.security.UserGroup
import carm.security.User
import carm.system.SystemEnvironment
import org.springframework.context.ApplicationContextAware
import org.springframework.context.ApplicationContext

class ApplicationService implements ApplicationContextAware {

    static transactional = false

    ApplicationContext applicationContext
    def aclService
    def activityTraceService
    def applicationDeploymentService
    def favoriteService
    def grailsApplication
    def systemEnvironmentService
    def watchService

    /**
     * Determines if the application is deployable. An application must be associated with a system that can be
     * deployed to.
     *
     * @param application Application to test
     * @return True if the application can be deployed
     */
    boolean isDeployable(Application application) {
        return systemEnvironmentService.canBeDeployedTo(application?.sysEnvironment)
    }

    /**
     * Returns a count of all Application objects.
     *
     * @return Total number of Application objects.
     */
    int count() {
        Application.count()
    }

    /**
     * Creates and saves a new Application instance.
     *
     * @param project Parent project used for security
     * @param params Application properties
     * @return newly created Module object
     */
    @Transactional
    @PreAuthorize("hasPermission(#project, 'PROJECT_ADMINISTRATOR')")
    Application create(Project project, Map params) {
        def prefix = "create() :"

        log.debug "$prefix entered"

        Application application = new Application(params)
        application.description = application.description?.trim()
        application.save()

        log.debug "$prefix returning $application"

        application
    }

    /**
     * Deletes the provided Application object.
     *
     * @param project Parent project used for security
     * @param application Application object to delete
     */
    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(#project, 'PROJECT_ADMINISTRATOR'))")
    void delete(Project project, Application application) {
        def prefix = "delete() :"

        log.debug "$prefix entered, application=$application"

        Application.withTransaction {
            def applicationId = application.id

            // Delete associated ACLs
            aclService.deleteAllAclsByDomain(application, APPLICATION_DEVELOPER)
            aclService.deleteAllAclsByDomain(application, APPLICATION_TEAM_LEADER)

            application.delete()

            // Delete favorites and watches
            favoriteService.deleteAllForApplicationId(applicationId)
            watchService.deleteAllForApplicationId(applicationId)
        }

        log.debug "$prefix leaving"
    }

    /**
     * Gets the Application object with the provided ID.
     *
     * @param id ID of Application object
     * @return Matching Application object
     */
    Application get(Serializable id) {
        Application.get(id)
    }

    /**
     * Lists out the most active applications.
     *
     * @param params Query parameters
     * @return List of Application objects
     */
    List<Application> findMostActiveApplications(Map params) {
        def queryParams = [
                max: grailsApplication.config.ui.application.listMax,
                offset: params?.offset,
                sort: params?.sort,
                order: params?.order
        ]

        def activeIds = activityTraceService.getMostActiveApplicationIds([max: queryParams.max])

        Application.findAllByIdInList(activeIds, queryParams)
    }

    /**
     * Gets a list of all Application objects.
     *
     * @param params Query parameters
     * @return List of Application objects
     */
    List<Application> list(Map params) {
        Application.list([
                max: params?.max ?: grailsApplication.config.ui.application.listMax,
                offset: params?.offset,
                sort: params?.sort,
                order: params?.order
        ])
    }

    /**
     * Updates the provided Application object with the new properties.
     *
     * @param project Parent project used for security
     * @param application Application to update
     * @param params New property values
     */
    @Transactional
    @PreAuthorize("hasPermission(#project, 'PROJECT_ADMINISTRATOR')")
    void update(Project project, Application application, Map params) {
        def prefix = "update() :"

        log.debug "$prefix entered"

        application.properties = params
        application.description = application.description?.trim()

        log.debug "$prefix leaving"
    }

    /**
     * Moves the provided Application object with the new properties.
     *
     * @param project Parent project used for security
     * @param application Application to update
     * @param params New property values
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void move(Application application, Project project) {
        def prefix = "move() :"

        log.debug "$prefix entered"

        if (application.project == project) {
            application.errors.rejectValue("project", "application.error.move.project.cannotbesame")
        }
        else {
            Project oldProject = application.project
            application.project = project

            if (application.validate()) {
                activityTraceService.applicationMoved(application, oldProject)
            }
        }

        log.debug "$prefix leaving"
    }

    /**
     * Finds all Application objects, grouped by ApplicationType using the provided SystemEnvironment.
     *
     * @param systemEnvironment SystemEnvironment used for querying
     * @return Map with key of ApplicationType and value of List of Application objects
     */
    SortedMap<ApplicationType, List<Application>> findAllBySystemEnvironmentGroupedByType(SystemEnvironment systemEnvironment) {
        def applications = Application.createCriteria().list {
            eq('sysEnvironment', systemEnvironment)
            and {
                order('type', 'asc')
                order('name', 'asc')
            }
        }

        SortedMap<ApplicationType, List<Application>> applicationsGrouped = new TreeMap<ApplicationType, List<Application>>()
        applications.each {
            List<Application> group = applicationsGrouped[it.type]
            if (!group) {
                group = []
                applicationsGrouped[it.type] = group
            }

            group.add(it)
        }

        return applicationsGrouped
    }

    /**
     * Finds all application developer groups for the provided Application instance.
     *
     * @param application Application used for querying
     * @return List of UserGroup objects
     */
    List<UserGroup> findAllApplicationDeveloperGroups(Application application) {
        aclService.findAllGroupsByDomainAndPermission(application, APPLICATION_DEVELOPER)
    }

    /**
     * Finds all application developer users for the provided Application instance.
     *
     * @param application Application used for querying
     * @return List of User objects
     */
    List<User> findAllApplicationDeveloperUsers(Application application) {
        aclService.findAllUsersByDomainAndPermission(application, APPLICATION_DEVELOPER)
    }

    /**
     * Finds all application team leader groups for the provided Application instance.
     *
     * @param application Application used for querying
     * @return List of UserGroup objects
     */
    List<UserGroup> findAllApplicationTeamLeaderGroups(Application application) {
        aclService.findAllGroupsByDomainAndPermission(application, APPLICATION_TEAM_LEADER)
    }

    /**
     * Finds all application team leader users for the provided Application instance.
     *
     * @param application Application used for querying
     * @return List of User objects
     */
    List<User> findAllApplicationTeamLeaderUsers(Application application) {
        aclService.findAllUsersByDomainAndPermission(application, APPLICATION_TEAM_LEADER)
    }

    /**
     * Finds all Applications filtered by notification scheme
     *
     * @param notificationSchemeInstance NotificationScheme used for filtering
     * @return List of Application objects
     */
    List<Application> findAllByNotificationScheme(NotificationScheme notificationSchemeInstance) {
        Application.findAllByNotificationScheme(notificationSchemeInstance)
    }

    /**
     * Finds all Application Objects, grouped by Application type using the provided Project.
     *
     * @param project Project used for querying
     * @return Map with key of ApplicationType and value of List of Application objects
     */
    SortedMap<ApplicationType, List<Application>> findAllByProjectGroupedByType(Project project) {
        def applications = Application.createCriteria().list {
            eq('project', project)
            and {
                order('type', 'asc')
                order('name', 'asc')
            }
        }

        SortedMap<ApplicationType, List<Application>> applicationsGrouped = new TreeMap<ApplicationType, List<Application>>()
        applications.each {
            List<Application> group = applicationsGrouped[it.type]
            if (!group) {
                group = []
                applicationsGrouped[it.type] = group
            }

            group.add(it)
        }

        return applicationsGrouped
    }

    /**
     * Finds all pending deployments and releases for the provided Application.
     *
     * @param application Application used for filtering
     * @return List of ApplicationDeployment and ApplicationRelease objects ordered by dateCreated ascending
     */
    List findAllPendingTasks(Application application) {
        def applicationReleaseService = applicationContext.getBean("applicationReleaseService")

        def pendingTasks = []
        pendingTasks.addAll applicationDeploymentService.findAllPendingDeploymentsByApplication(application)
        pendingTasks.addAll applicationReleaseService.findAllPendingReleasesByApplication(application)

        pendingTasks.sort { it.dateCreated }
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void addApplicationDeveloperGroup(Application application, UserGroup userGroup) {
        aclService.addUserGroupPermission(application, userGroup, APPLICATION_DEVELOPER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void addApplicationDeveloperUser(Application application, User user) {
        aclService.addUserPermission(application, user, APPLICATION_DEVELOPER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void addTeamLeaderGroup(Application application, UserGroup userGroup) {
        aclService.addUserGroupPermission(application, userGroup, APPLICATION_TEAM_LEADER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void addTeamLeaderUser(Application application, User user) {
        aclService.addUserPermission(application, user, APPLICATION_TEAM_LEADER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void removeApplicationDeveloperGroup(Application application, UserGroup userGroup) {
        aclService.removeUserGroupPermission(application, userGroup, APPLICATION_DEVELOPER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void removeApplicationDeveloperUser(Application application, User user) {
        aclService.removeUserPermission(application, user, APPLICATION_DEVELOPER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void removeTeamLeaderGroup(Application application, UserGroup userGroup) {
        aclService.removeUserGroupPermission(application, userGroup, APPLICATION_TEAM_LEADER)
    }

    @Transactional
    @PreAuthorize("isAuthenticated() and (hasRole('ROLE_ADMIN') or hasPermission(filterObject, 'PROJECT_ADMINISTRATOR') )")
    void removeTeamLeaderUser(Application application, User user) {
        aclService.removeUserPermission(application, user, APPLICATION_TEAM_LEADER)
    }
}
