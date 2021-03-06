package carm.sourcecontrol

import grails.plugins.springsecurity.Secured
import carm.exceptions.DomainInUseException
import org.springframework.dao.DataIntegrityViolationException

class SourceControlServerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def sourceControlServerService

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        [
                sourceControlServerInstanceList: sourceControlServerService.list(params),
                sourceControlServerInstanceTotal: sourceControlServerService.count()
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        def sourceControlServerInstance = new SourceControlServer()
        sourceControlServerInstance.properties = params
        return [sourceControlServerInstance: sourceControlServerInstance]
    }

    @Secured(['ROLE_ADMIN'])
    def save() {
        def sourceControlServerInstance = sourceControlServerService.create(params)
        if (!sourceControlServerInstance.hasErrors()) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), sourceControlServerInstance.name])}"
            redirect(action: "show", id: sourceControlServerInstance.id)
        }
        else {
            render(view: "create", model: [sourceControlServerInstance: sourceControlServerInstance])
        }
    }

    def show() {
        def sourceControlServerInstance = sourceControlServerService.get(params.id)
        if (!sourceControlServerInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sourceControlServerInstance: sourceControlServerInstance]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def edit() {
        def sourceControlServerInstance = sourceControlServerService.get(params.id)
        if (!sourceControlServerInstance) {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sourceControlServerInstance: sourceControlServerInstance]
        }
    }

    @Secured(['ROLE_ADMIN'])
    def update() {
        def sourceControlServerInstance = sourceControlServerService.get(params.id)
        if (sourceControlServerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sourceControlServerInstance.version > version) {
                    sourceControlServerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sourceControlServer.label', default: 'SourceControlServer')] as Object[], "Another user has updated this SourceControlServer while you were editing")
                    render(view: "edit", model: [sourceControlServerInstance: sourceControlServerInstance])
                    return
                }
            }
            sourceControlServerService.update(sourceControlServerInstance, params)
            if (!sourceControlServerInstance.hasErrors() && sourceControlServerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), sourceControlServerInstance.name])}"
                redirect(action: "show", id: sourceControlServerInstance.id)
            }
            else {
                render(view: "edit", model: [sourceControlServerInstance: sourceControlServerInstance])
            }
        }
        else {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN'])
    def delete() {
        def sourceControlServerInstance = sourceControlServerService.get(params.id)
        if (sourceControlServerInstance) {
            def name = sourceControlServerInstance.name

            try {
                sourceControlServerService.delete(sourceControlServerInstance)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), name])}"
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException e) {
                flash.error = "${message(code: 'default.not.deleted.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), name])}"
                redirect(action: "show", id: params.id)
            }
            catch (DomainInUseException e) {
                flash.error = "${message(code: 'default.not.deleted.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), name])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.error = "${message(code: 'default.not.found.message', args: [message(code: 'sourceControlServer.label', default: 'SourceControlServer'), params.id])}"
            redirect(action: "list")
        }
    }
}
