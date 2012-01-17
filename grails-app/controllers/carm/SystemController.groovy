package carm

import grails.plugins.springsecurity.Secured

class SystemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def applicationService
    def systemService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [systemInstanceList: systemService.list(params), systemInstanceTotal: systemService.count()]
    }

    @Secured(['ROLE_ADMIN'])
    def create = {
        def systemInstance = new System()
        systemInstance.properties = params
        return [systemInstance: systemInstance]
    }

    @Secured(['ROLE_ADMIN'])
    def save = {
        def systemInstance = systemService.create(params)
        if (!systemInstance.hasErrors()) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'system.label', default: 'System'), systemInstance.name])}"
            redirect(action: "show", id: systemInstance.id)
        }
        else {
            render(view: "create", model: [systemInstance: systemInstance])
        }
    }

    def show = {
        def systemInstance = systemService.get(params.id?.toLong())
        if (!systemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
        else {
            [systemInstance: systemInstance, applicationsGrouped: applicationService.findAllBySystemGroupedByType(systemInstance)]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def moveEnvDown = {
        def systemInstance = systemService.get(params.systemId?.toLong())
        if (!systemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
        else {
            systemService.moveEnvironmentDown(systemInstance, params.index?.toInteger())

            redirect(action: "show", id: systemInstance.id)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def moveEnvUp = {
        def systemInstance = systemService.get(params.systemId?.toLong())
        if (!systemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
        else {
            systemService.moveEnvironmentUp(systemInstance, params.index?.toInteger())

            redirect(action: "show", id: systemInstance.id)
        }
    }

    @Secured(['ROLE_ADMIN'])
    def edit = {
        def systemInstance = systemService.get(params.id?.toLong())
        if (!systemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [systemInstance: systemInstance]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def update = {
        def systemInstance = systemService.get(params.id?.toLong())
        if (systemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (systemInstance.version > version) {

                    systemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'system.label', default: 'System')] as Object[], "Another user has updated this System while you were editing")
                    render(view: "edit", model: [systemInstance: systemInstance])
                    return
                }
            }
            systemService.update(systemInstance, params)
            if (!systemInstance.hasErrors() && systemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'system.label', default: 'System'), systemInstance.name])}"
                redirect(action: "show", id: systemInstance.id)
            }
            else {
                render(view: "edit", model: [systemInstance: systemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN'])
    def delete = {
        def systemInstance = systemService.get(params.id?.toLong())
        if (systemInstance) {
            try {
                def name = systemInstance.name
                systemService.delete(systemInstance)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'system.label', default: 'System'), name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'system.label', default: 'System'), params.id])}"
            redirect(action: "list")
        }
    }
}
