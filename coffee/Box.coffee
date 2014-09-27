class Box

    constructor: ->
        console.log 'Box#constructor'
        @dom = jQuery('<div class="lightb-target off"><a class="lightb-close" href="#"></a></div>')
        jQuery('body').append @dom
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
        jQuery(@dom).append("<div class='lightb-content'><img class='lightb-image' src='#{image.href}' /></div>")
        
        if image.list
            console.log 'It is part of a list.'
        else
            console.log 'It is NOT part of a list.'
        
        do @show

    next: ->
        console.log 'Box#next'

    prev: ->
        console.log 'Box#prev'