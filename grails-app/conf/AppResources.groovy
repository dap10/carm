modules = {
    common {
        dependsOn "jquery, jquery-ui, bootstrap"

        resource url: 'css/main.css'

        resource url: 'js/jquery.cookie.js'
        resource url: 'js/jquery.expander.min.js', exclude: 'minify'

        resource url: 'css/tipsy.css'
        resource url: 'js/jquery.tipsy.js'
    }

    application {

    }

    // Define reference to custom jQuery UI theme
    overrides {
        'jquery-theme' {
            resource id: 'theme', url: '/jquery-ui/themes/smoothness/jquery-ui-1.8.15.custom.css'
        }
    }
}