class Navigation

    constructor:  ->
        console.log 'Navigation#constructor'
        @dom = jQuery("<nav class='lightb-nav'></nav>")
        @prevButton = jQuery("<a class='lightb-prev'></a>")
        @nextButton = jQuery("<a class='lightb-next'></a>")
        jQuery(nav)
            .append(prevButton)
            .append(nextButton)
        #jQuery(@dom).append nav
        

    dom: @dom

    reset: () ->
        console.log 'Navigation#reset'

