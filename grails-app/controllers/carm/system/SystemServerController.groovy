package carm.system

import grails.plugins.springsecurity.Secured
import carm.exceptions.DomainInUseException
import org.springframework.dao.DataIntegrityViolationException

class SystemServerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def activityTraceService
    def systemServerService
    def systemEnvironmentService

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        [
                systemServerInstanceList: systemServerService.list(params),
                systemServerInstanceTotal: systemServerService.count()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        def systemInstance = systemEnvironmentService.get(params.sysEnvironment?.id)
        if (!systemInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemEnvironment.label', default: 'SystemEnvironment'), params.sysEnvironment?.id])}"
            redirect(action: "list")
        }
        else {
            def systemServerInstance = new SystemServer()
            systemServerInstance.properties = params
            return [systemServerInstance: systemServerInstance]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def save() {
        def systemServerInstance = systemServerService.create(params)
        if (!systemServerInstance.hasErrors()) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), systemServerInstance.name])}"
            redirect(controller: "systemEnvironment", action: "show", id: systemServerInstance.sysEnvironment.id)
        }
        else {
            render(view: "create", model: [systemServerInstance: systemServerInstance])
        }
    }

    def show() {
        def systemServerInstance = systemServerService.get(params.id)
        if (!systemServerInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [
                    activityList: activityTraceService.listActivityBySystemServer(systemServerInstance, [:]),
                    activityCount: activityTraceService.countActivityBySystemServer(systemServerInstance),
                    systemServerInstance: systemServerInstance
            ]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def edit() {
        def systemServerInstance = systemServerService.get(params.id)
        if (!systemServerInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [systemServerInstance: systemServerInstance]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def update() {
        def systemServerInstance = systemServerService.get(params.id)
        if (systemServerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (systemServerInstance.version > version) {
                    systemServerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'systemServer.label', default: 'SystemServer')] as Object[], "Another user has updated this SystemServer while you were editing")
                    render(view: "edit", model: [systemServerInstance: systemServerInstance])
                    return
                }
            }
            systemServerService.update(systemServerInstance, params)
            if (!systemServerInstance.hasErrors() && systemServerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), systemServerInstance.name])}"
                redirect(action: "show", id: systemServerInstance.id)
            }
            else {
                render(view: "edit", model: [systemServerInstance: systemServerInstance])
            }
        }
        else {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN'])
    def delete() {
        def systemServerInstance = systemServerService.get(params.id)
        if (systemServerInstance) {
            def systemId = systemServerInstance.sysEnvironment.id
            def name = systemServerInstance.name

            try {
                systemServerService.delete(systemServerInstance)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), name])}"
                redirect(controller: "systemEnvironment", action: "show", id: systemId)
            }
            catch (DataIntegrityViolationException e) {
                flash.error = "${message(code: 'default.not.deleted.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), name])}"
                redirect(action: "show", id: params.id)
            }
            catch (DomainInUseException e) {
                flash.error = "${message(code: 'default.not.deleted.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), name])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), params.id])}"
            redirect(action: "list")
        }
    }

    def listActivity() {
        def systemServerInstance = systemServerService.get(params.id)
        if (!systemServerInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'systemServer.label', default: 'SystemServer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [
                    domainInstance: systemServerInstance,
                    activityList: activityTraceService.listActivityBySystemServer(systemServerInstance, params),
                    activityTotal: activityTraceService.countActivityBySystemServer(systemServerInstance)
            ]
        }
    }

    def ajaxShowMoreActivity() {
        def systemServerInstance = systemServerService.get(params.id)
        def activityList = []

        if (systemServerInstance) {
            activityList = activityTraceService.listActivityBySystemServer(systemServerInstance, params)
        }

        render(template: "/common/activityBlock", model: [activityList: activityList])
    }
}
