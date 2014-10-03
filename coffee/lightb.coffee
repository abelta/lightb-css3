###*
# Represents an Image with the intent of it being later diaplayed in a lightbox.
###
class Image
    
    ###*
    # @constructor
    # @param {DOM} The link to an image that originates the Image.
    # @param {ImageList} If the image belongs to a list, the list it belongs to. Or undefined.
    ###
    constructor: (@dom, @list) ->
        self = this
        clickHandler = (event) ->
            window.LightB.display self
            event.preventDefault();
        @href = jQuery(@dom).attr('href')
        
        jQuery(@dom).click clickHandler

    href: @href
    list: @list





###*
# If the DOM originating the Images is a list, an ImageList instead of an Image is created in orter to
# being able to traverse it in order from a navigation menu.
###
class ImageList extends Array
    
    ###*
    # @constructor
    # @param {DOM...} A variable number of splatted DOM links to images.
    ###
    constructor: (args...) ->
        self = this    
        args = (new Image(arg, self) for arg in args)
        @push.apply this, args





###*
# Grafical representation and functionality of a navigation menu to traverse in order the images of a list.
###
class Navigation

    ###*
    # @constructor
    ###
    constructor: ->
        @dom = jQuery("<nav class='lightb-nav' style='display:none'></nav>")
        @prevButton = jQuery("<a class='lightb-prev-extend' href='#'><div class='lightb-prev lightb-button'></div></a>")
        @nextButton = jQuery("<a class='lightb-next-extend' href='#'><div class='lightb-next lightb-button'></div></a>")
        jQuery(@dom)
            .append(@prevButton)
            .append(@nextButton)
            .click (event) -> event.stopPropagation()

    dom: @dom

    ###*
    # Show the navigation menu on screen.
    # Look and function depend on the image being shown.
    # @param {Image} Image that will be shown.
    # @param {DOM} The dom associated with the image.
    ###
    show: (image, imageDom) ->
        do jQuery(@dom).show
        @reset(image, imageDom) if image and imageDom

    ###*
    # Hide the navigation menu.
    ###
    hide: ->
        do jQuery(@dom).hide

    ###*
    # With each different image being shown, the menu must adapt look and functionality.
    # @param {Image} Image that will be shown.
    # @param {DOM} The dom associated with the image.
    ###
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
        
    


###*
# The actual lightbox. A dark layer on which to impose the picture.
###
class Box

    ###*
    # @constructor
    ###
    constructor: ->
        @dom = jQuery('<div class="lightb-target off"><a class="lightb-close lightb-button" href="#"></a></div>')
        @nav = new Navigation
        jQuery('body').append @dom
        jQuery(@dom).append @nav.dom
        #jQuery(@dom).on('click', '.lightb-close', @hide)
        jQuery(@dom).on('click', @hide)

    ###*
    # Show the lightbox.
    ###
    show: =>
        jQuery(@dom).show 0, => jQuery(@dom).removeClass('off').addClass('on')

    ###*
    # Hide the lightbox.
    ###
    hide: =>
        handleHide = =>
            do jQuery(@dom).hide
            do jQuery(@dom).find('.lightb-image').remove
            do @nav.hide

        @nav.hide()
        jQuery(@dom).removeClass('on').addClass('off')
        setTimeout(handleHide, 500)

    ###*
    # Display an image. This is the main method to be used.
    # @param {Image} The image to be displayed.
    ###
    display: (image) =>
        imageDom = jQuery("<img class='lightb-image' src='#{image.href}' />")
        jQuery(imageDom).click (event) -> event.stopPropagation()
        jQuery(@dom).find('.lightb-image').remove()
        jQuery(@dom).append(imageDom)

        do @show
        imageDom.one 'load', =>
            @nav.show(image, imageDom) if image.list





###*
# The main class of it all.
# Uses all other classes, initializes the DOM to be used with the lightbox.
# Attaches behavior to all link-images marked with data-lightbox.
# Attaches behavior to all elements containing  link-images marked with data-box as well such as lists, layers...
###
class LightB

    ###*
    # @constructor
    ###
    constructor: ->
        @box = new Box
        do @initialize

    ###*
    # Sets up the DOM, attaching events to all elements marked with data-lightbox.
    ###
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

    ###*
    # The main method that makes it all work. Displays an image in a lightbox.
    # @param {Image} Image to be displayed.
    ###
    display: (image) ->
        @box.display image





###
# MAIN.
###
window.LightB = new LightB
