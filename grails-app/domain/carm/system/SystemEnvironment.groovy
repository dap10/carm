package carm.system

import org.apache.commons.lang.builder.HashCodeBuilder

class SystemEnvironment {
    String name
    String description

    Date dateCreated
    Date lastUpdated

    static constraints = {
        name(minSize: 2, maxSize: 50, blank: false)
        description(maxSize: 4000, nullable: true)
        system(nullable: false)
    }

    static belongsTo = [system: System]

    static mapping = {
        sort "name"
    }

    public String toString() {
        return name
    }

    boolean equals(other) {
        if (!(other instanceof SystemEnvironment)) {
            return false
        }

        other.name == name && other.system == system
    }

    int hashCode() {
        new HashCodeBuilder().append(name).append(system).toHashCode()
    }
}
