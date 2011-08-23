package net.lmxm.carm.domains

import net.lmxm.carm.enums.SourceControlServerType

class SourceControlServer {
    String name
    String description
    SourceControlServerType type
    String url

    static constraints = {
        name(minSize: 2, maxSize: 50, blank: false, unique: true)
        description(maxSize: 4000, nullable: true)
        type(null: false)
        url(maxSize: 200, nullable:true, url:true)
    }

    public String toString() {
        return "SourceControlServer [name='$name', type='$type']";
    }
}
