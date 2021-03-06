package carm.security

import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.transaction.annotation.Transactional
import carm.exceptions.DomainInUseException

class UserGroupService {

    static transactional = false

    def grailsApplication

    /**
     * Add a user with the provided ID to the UserGroup.
     *
     * @param userGroup UserGroup to which to add the user
     * @param userId ID of user to add
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void addUserToGroup(UserGroup userGroup, User user) {
        if (user) {
            userGroup.addToUsers(user)
            userGroup.save()
        }
    }

    List<UserGroup> findAllByUser(User user) {
        UserGroup.createCriteria().list() {
            createAlias("users", "user")
            eq("user.id", user.id)
            order("name")
        }
    }

    List<User> findAllUsersByGroup(UserGroup userGroup) {
        (List<User>)UserGroup.executeQuery("""
            select
                user
            from
                UserGroup userGroup
                join userGroup.users user
            where
                userGroup.id = :userGroupId
            order by
                user.fullName
        """, [userGroupId: userGroup.id])
    }

    /**
     * Removes a user from user groups
     *
     * @param user User to remove from all groups
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void removeUserFromAllGroups(User user) {
        findAllByUser(user).each { UserGroup userGroup ->
            userGroup.removeFromUsers(user)
            userGroup.save()
        }
    }

    /**
     * Removes a user with the provided ID from the UserGroup.
     *
     * @param userGroup UserGroup from which to remove the user
     * @param userId ID of user to remove
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void removeUserFromGroup(UserGroup userGroup, Serializable userId) {
        User user = User.get(userId)
        if (user) {
            userGroup.removeFromUsers(user)
            userGroup
        }
    }

    /**
     * Returns a count of all UserGroup objects.
     *
     * @return Total number of UserGroup objects.
     */
    int count() {
        UserGroup.count()
    }

    /**
     * Creates and saves a new UserGroup instance.
     *
     * @param params UserGroup properties
     * @return newly created UserGroup object
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    UserGroup create(Map params) {
        def prefix = "create() :"

        log.debug "$prefix entered"

        UserGroup userGroup = new UserGroup(params)
        userGroup.save()

        log.debug "$prefix returning $userGroup"

        userGroup
    }

    /**
     * Deletes the provided SystemEnvironment object.
     *
     * @param userGroup SystemEnvironment object to delete
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void delete(UserGroup userGroup) {
        def prefix = "delete() :"

        log.debug "$prefix entered, system=$userGroup"

        if (isInUse(userGroup)) {
            log.error "$prefix SystemEnvironment is in use and cannot be deleted"
            throw new DomainInUseException()
        }

        userGroup.delete()

        log.debug "$prefix leaving"
    }

    /**
     * Gets the UserGroup object with the provided ID.
     *
     * @param id ID of UserGroup object
     * @return Matching UserGroup object
     */
    UserGroup get(Serializable id) {
        UserGroup.get(id)
    }

    /**
     * Determines if the provided UserGroup is in use.
     *
     * @param userGroup UserGroup to test
     * @return True if the UserGroup is in use
     */
    boolean isInUse(UserGroup userGroup) {
        AclGroupEntry.countByUserGroup(userGroup) > 0
    }

    /**
     * Gets a list of all UserGroup objects.
     *
     * @param params Query parameters
     * @return List of UserGroup objects
     */
    List<UserGroup> list(Map params) {
        UserGroup.list([
                max: grailsApplication.config.ui.userGroup.listMax,
                offset: params?.offset,
                sort: params?.sort,
                order: params?.order
        ])
    }

    /**
     * Gets a list of all UserGroup objects.
     *
     * @param params Query parameters
     * @return List of UserGroup objects
     */
    List<UserGroup> listAll() {
        UserGroup.list()
    }

    /**
     * Updates the provided UserGroup object with the new properties.
     *
     * @param system UserGroup to update
     * @param params New property values
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void update(UserGroup userGroup, Map params) {
        def prefix = "update() :"

        log.debug "$prefix entered"

        userGroup.properties = params

        log.debug "$prefix leaving"
    }
}
