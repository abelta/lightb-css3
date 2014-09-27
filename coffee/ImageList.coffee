class ImageList extends Array
    
    constructor: (args...) ->
        console.log 'ImageList#constructor'
        self = this
        args = (new Image(arg, self) for arg in args)
        @push.apply this, args