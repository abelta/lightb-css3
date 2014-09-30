class Image
    
    constructor: (@dom, @list) ->
        console.log 'Image#constructor'
        self = this
        clickHandler = ->
            console.log 'Image#constructor#clickHandler'
            try
                window.LightB.display this
            catch ex
                console.log ex
            return false
        console.log 'DOM', @dom
        @href = jQuery(@dom).attr('href')
        
        jQuery(@dom).click clickHandler

    href: @href
    list: @list





class ImageList extends Array
    
    constructor: (args...) ->
        console.log 'ImageList#constructor'
        self = this
        args = (new Image(arg, self) for arg in args)
        @push.apply this, args





class Navigation

    constructor:  ->
        console.log 'Navigation#constructor'
        @dom = jQuery("<nav class='lightb-nav'></nav>")
        @prevButton = jQuery("<a class='lightb-prev'></a>")
        @nextButton = jQuery("<a class='lightb-next'></a>")
        jQuery(@dom)
            .append(@prevButton)
            .append(@nextButton)

    reset: () =>
        console.log 'Navigation#reset'

    dom: @dom





class Box

    constructor: ->
        console.log 'Box#constructor'
        @dom = jQuery('<div class="lightb-target off"><a class="lightb-close" href="#"></a></div>')
        @nav = new Navigation
        jQuery('body').append @dom
        jQuery(@dom).append @nav.dom
        jQuery(@dom).on('click', '.lightb-close', @hide)

    show: =>
        console.log 'Box#show'
        jQuery(@dom).show 0, => jQuery(@dom).removeClass('off').addClass('on')

    hide: =>
        console.log 'Box#hide'
        handleHide = =>
            console.log 'Box#hide#handleHide'
            do jQuery(@dom).hide
            do jQuery(@dom).find('.lightb-image').remove
        jQuery(@dom).removeClass('on').addClass('off')
        setTimeout(handleHide, 500)

    display: (image) =>
        console.log 'Box#display'
        
        displayNavigation = (image, imageDom) ->
            console.log 'Box#display#displayNavigation'
            console.log 'image', image            

        imageDom = jQuery("<img class='lightb-image' src='#{image.href}' />")
        jQuery(@dom).append imageDom
        
        
        if image.list
            console.log 'It is part of a list.'
            #displayNavigation(imageDom)
        else
            console.log 'It is NOT part of a list.'
        
        do @show

    next: ->
        console.log 'Box#next'

    prev: ->
        console.log 'Box#prev'





class LightB

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






# MAIN.
window.LightB = new LightB