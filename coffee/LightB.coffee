class window.LightB

    constructor: ->
        console.log 'LightB#constructor'
        @box = new Box
        do @initialize

    initialize: ->
        console.log 'LightB#initialize'
        jQuery(document).on 'keyup', LightBKeyHandler
        jQuery('[data-lightbox]').each (i, elem) ->
            console.log 'elem', elem
            if jQuery(elem).is 'a'
                new Image(elem)
            else
                images = jQuery(elem).find('a:has(>img)').toArray()
                new ImageList(images...)

    LightBKeyHandler = (e) =>
        console.log 'LightBKeyHandler'
        do window.LightB.box.hide if e.which is 27 # Hide when esc key is pressed.

    display: (image) ->
        console.log 'LightB#display'
        @box.display image


#window.LightB = new LightB
