package carm.application

import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.transaction.annotation.Transactional

class ApplicationTypeService {

    static transactional = false

    /**
     * Determines if the provided type is in use.
     *
     * @param type Type to test
     * @return True if the type is in use
     */
    boolean isInUse(ApplicationType type) {
        Application.findAllByType(type).size() > 0
    }

    /**
     * Returns a count of all ApplicationType objects.
     *
     * @return Total number of ApplicationType objects.
     */
    int count() {
        ApplicationType.count()
    }

    /**
     * Creates and saves a new ApplicationType instance.
     *
     * @param params ApplicationType properties
     * @return newly created Module object
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    ApplicationType create(Map params) {
        def prefix = "create() :"

        log.debug "$prefix entered"

        ApplicationType applicationType = new ApplicationType(params)
        applicationType.save()

        log.debug "$prefix returning $applicationType"

        applicationType
    }

    /**
     * Deletes the provided ApplicationType object.
     *
     * @param applicationType ApplicationType object to delete
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void delete(ApplicationType applicationType) {
        applicationType.delete()
    }

    /**
     * Gets the ApplicationType object with the provided ID.
     *
     * @param id ID of ApplicationType object
     * @return Matching ApplicationType object
     */
    ApplicationType get(long id) {
        ApplicationType.get(id)
    }

    /**
     * Gets a list of all ApplicationType objects.
     *
     * @param params Query parameters
     * @return List of ApplicationType objects
     */
    List<ApplicationType> list(Map params) {
        ApplicationType.list(params)
    }

    /**
     * Updates the provided ApplicationType object with the new properties.
     *
     * @param applicationType ApplicationType to update
     * @param params New property values
     */
    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void update(ApplicationType applicationType, Map params) {
        def prefix = "update() :"

        log.debug "$prefix entered"

        applicationType.properties = params

        log.debug "$prefix leaving"
    }
}
