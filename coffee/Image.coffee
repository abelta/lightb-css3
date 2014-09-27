class Image
    
    constructor: (@dom, @list) ->
        console.log 'Image#constructor'
        self = this
        clickHandler = ->
            console.log 'Image#constructor#clickHandler'
            ###
            try
                window.LightB.display self
            catch error
                console.log 'error', error
            ###
            window.LightB.display this
            return false
        console.log 'DOM', @dom
        @href = jQuery(@dom).attr('href')
        
        jQuery(@dom).click clickHandler

    href: @href
    list: @list
        
