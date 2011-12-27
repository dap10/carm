package carm

import carm.security.User

class SourceControlUser {
    String name
    String description

    Date dateCreated
    Date lastUpdated

    static constraints = {
        name(minSize: 2, maxSize: 50, blank: false, unique: true)
        description(maxSize: 4000, nullable: true)
        server(nullable: true)
        user(nullable: true)
    }

    static belongsTo = [server: SourceControlServer, user: User]

    static hasMany = [applicationRoles: ApplicationRole]

    public String toString() {
        return name
    }
}
