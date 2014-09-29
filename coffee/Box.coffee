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
            displayNavigation(imageDom)
        else
            console.log 'It is NOT part of a list.'
        
        do @show

    next: ->
        console.log 'Box#next'

    prev: ->
        console.log 'Box#prev'