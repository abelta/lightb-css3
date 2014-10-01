class Image
    
    constructor: (@dom, @list) ->
        console.log 'Image#constructor'
        self = this
        console.log 'SELF', self
        clickHandler = ->
            console.log 'Image#constructor#clickHandler'
            window.LightB.display self
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
        console.log 'SELF', self
        args = (new Image(arg, self) for arg in args)
        @push.apply this, args





class Navigation

    constructor: ->
        console.log 'Navigation#constructor'
        @dom = jQuery("<nav class='lightb-nav' style='display:none'></nav>")
        @prevButton = jQuery("<a class='lightb-prev lightb-button'></a>")
        @nextButton = jQuery("<a class='lightb-next lightb-button'></a>")
        jQuery(@dom)
            .append(@prevButton)
            .append(@nextButton)

    dom: @dom

    show: (image, imageDom) ->
        console.log 'Navigation#show'
        do jQuery(@dom).show
        @reset(image, imageDom) if image and imageDom

    hide: ->
        console.log 'Navigation#hide'
        do jQuery(@dom).hide

    reset: (image, imageDom) ->
        console.log 'Navigation#reset'
        list = image.list
        console.log 'list', list.length-1
        jQuery(@dom)
            .width( jQuery(imageDom).width() )
            .find('.off').removeClass('off')
            .find('a').off('click')
        if list.indexOf(image) == 0
            jQuery(@prevButton).addClass('off')
        else
            jQuery(@prevButton).on 'click', => window.LightB.display(list[list.indexOf(image)-1])
        if list.indexOf(image) == list.length-1
            jQuery(@nextButton).addClass('off')
        else
            jQuery(@prevButton).on 'click', => window.LightB.display(list[list.indexOf(image)+1])
        
    


class Box

    constructor: ->
        console.log 'Box#constructor'
        @dom = jQuery('<div class="lightb-target off"><a class="lightb-close lightb-button" href="#"></a></div>')
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
            do @nav.hide
        @nav.hide()
        jQuery(@dom).removeClass('on').addClass('off')
        setTimeout(handleHide, 500)

    display: (image) =>
        console.log 'Box#display'
        console.log 'image', image
        imageDom = jQuery("<img class='lightb-image' src='#{image.href}' />")
        jQuery(@dom).append imageDom
        do @show
        imageDom.one 'load', =>
            if image.list
                console.log 'It is part of a list.'
                @nav.show(image, imageDom)
            else
                console.log 'It is NOT part of a list.'

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