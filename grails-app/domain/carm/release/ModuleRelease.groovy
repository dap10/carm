package carm.release

import carm.module.Module
import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * A module that is part of an application release.
 */
class ModuleRelease {
    Module module

    Date dateCreated
    Date lastUpdated

    static constraints = {
        applicationRelease nullable: false
        module nullable: true
    }

    static belongsTo = [applicationRelease: ApplicationRelease]
    
    String toString() {
        "Module Release : $applicationRelease - $module"
    }

    boolean equals(other) {
        if (!(other instanceof ApplicationReleaseHistory)) {
            return false
        }

        other.module == module && other.applicationRelease == applicationRelease
    }

    int hashCode() {
        new HashCodeBuilder().append(module).append(applicationRelease).toHashCode()
    }
}
