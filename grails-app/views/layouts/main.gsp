<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="jquery" plugin="jquery" />
        <jqui:resources />
        <script type="text/javascript" src="${resource(dir:'js',file:'jquery.multi-ddm.min.js')}" ></script>
        <script type='text/javascript'>
        $(document).ready(function(){
            $('#multi-ddm').dropDownMenu({timer: 500, parentMO: 'parent-hover', childMO: 'child-hover1'});
        });
        </script>
    </head>
    <body>
        <g:render template="/common/menu" />
        <g:layoutBody />
        <div class="clearing"></div>
        <div class="footer">
            <hr style="margin: 0 1em;" />
            Change And Release Management 2011
        </div>
    </body>
</html>