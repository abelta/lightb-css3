class Image
    
    constructor: (@dom, @list) ->
        self = this
        clickHandler = ->
            window.LightB.display self
            return false
        @href = jQuery(@dom).attr('href')
        
        jQuery(@dom).click clickHandler

    href: @href
    list: @list





class ImageList extends Array
    
    constructor: (args...) ->
        self = this    
        args = (new Image(arg, self) for arg in args)
        @push.apply this, args





class Navigation

    constructor: ->
        @dom = jQuery("<nav class='lightb-nav' style='display:none'></nav>")
        @prevButton = jQuery("<a class='lightb-prev-extend' href='#'><div class='lightb-prev lightb-button'></div></a>")
        @nextButton = jQuery("<a class='lightb-next-extend' href='#'><div class='lightb-next lightb-button'></div></a>")
        jQuery(@dom)
            .append(@prevButton)
            .append(@nextButton)

    dom: @dom

    show: (image, imageDom) ->
        do jQuery(@dom).show
        @reset(image, imageDom) if image and imageDom

    hide: ->
        do jQuery(@dom).hide

    reset: (image, imageDom) ->
        list = image.list
        jQuery(@dom)
            .width( jQuery(imageDom).width() )
            .find('.off').removeClass('off')
            .find('a').off('click')
        
        if list.indexOf(image) == 0
            jQuery('.lightb-button', @prevButton).addClass('off')
        else
            jQuery(@prevButton).on 'click', => window.LightB.display(list[list.indexOf(image)-1])

        if list.indexOf(image) == list.length-1
            jQuery('.lightb-button', @nextButton).addClass('off')
        else
            jQuery(@nextButton).on 'click', => window.LightB.display(list[list.indexOf(image)+1])
        
    


class Box

    constructor: ->
        @dom = jQuery('<div class="lightb-target off"><a class="lightb-close lightb-button" href="#"></a></div>')
        @nav = new Navigation
        jQuery('body').append @dom
        jQuery(@dom).append @nav.dom
        jQuery(@dom).on('click', '.lightb-close', @hide)

    show: =>
        jQuery(@dom).show 0, => jQuery(@dom).removeClass('off').addClass('on')

    hide: =>
        handleHide = =>
            do jQuery(@dom).hide
            do jQuery(@dom).find('.lightb-image').remove
            do @nav.hide
        @nav.hide()
        jQuery(@dom).removeClass('on').addClass('off')
        setTimeout(handleHide, 500)

    display: (image) =>
        imageDom = jQuery("<img class='lightb-image' src='#{image.href}' />")
        jQuery(@dom).find('.lightb-image').remove()
        jQuery(@dom).append(imageDom)

        do @show
        imageDom.one 'load', =>
            @nav.show(image, imageDom) if image.list





class LightB

    constructor: ->
        @box = new Box
        do @initialize

    initialize: ->
        jQuery(document).on 'keyup', LightBKeyHandler
        jQuery('[data-lightbox]').each (i, elem) ->
            if jQuery(elem).is 'a'
                new Image(elem)
            else
                images = jQuery(elem).find('a:has(>img)').toArray()
                new ImageList(images...)

    LightBKeyHandler = (e) =>
        do window.LightB.box.hide if e.which is 27 # Hide when esc key is pressed.

    display: (image) ->
        @box.display image






# MAIN.
window.LightB = new LightB
