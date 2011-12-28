package carm

import org.springframework.security.access.prepost.PostFilter
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.acls.domain.BasePermission
import org.springframework.transaction.annotation.Transactional

class SourceControlRoleService {

    static transactional = false

    int count() {
        SourceControlRole.count()
    }

    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    SourceControlRole create(Map params) {
        def prefix = "create() :"

        log.debug "$prefix entered"

        SourceControlRole sourceControlRole = new SourceControlRole(params)
        sourceControlRole.save()

        log.debug "$prefix returning $sourceControlRole"

        sourceControlRole
    }

    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void delete(SourceControlRole sourceControlRole) {
        sourceControlRole.delete()
    }

    SourceControlRole get(long id) {
        SourceControlRole.get id
    }

    List<SourceControlRole> list(Map params) {
        SourceControlRole.list params
    }

    @Transactional
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    void update(SourceControlRole sourceControlRole, Map params) {
        def prefix = "update() :"

        log.debug "$prefix entered"

        sourceControlRole.properties = params

        log.debug "$prefix leaving"
    }
}