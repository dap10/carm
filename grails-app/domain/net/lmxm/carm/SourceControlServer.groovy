package net.lmxm.carm

import net.lmxm.carm.enums.SourceControlServerType

class SourceControlServer {
    String name
    String description
    SourceControlServerType type
    String url
    Date dateCreated
    Date lastUpdated

    static constraints = {
        name(minSize: 2, maxSize: 50, blank: false, unique: true)
        description(maxSize: 4000, nullable: true)
        type(null: false)
        url(maxSize: 200, nullable:true, url:true)
    }

    public String toString() {
        return name
    }
}