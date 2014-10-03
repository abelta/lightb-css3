LightB-CSS3
===========

Your typical Lightbox library for Javascript, making use of CSS3 for transitions and animations.
Look and CSS inspired by the work of [Jesse Couch](http://www.designcouch.com/home/why/2013/11/01/responsive-css3-lightbox-with-no-javascript/).



Installation and usage
===========
jQuery is a requirement.
Include the js and css files (not the coffee one) like this.
```
<link rel="stylesheet" href="css/lightb.css">
<script src="js/lightb.js"></script>
```
Then proceed to either mark an individual link to an image with _data-lightbox_ like this
```
<a data-lightbox href="img/img01.jpg">
    <img src="img/thumbs/thumb01.jpg" />
</a>
```
or put a set of images in a container like a list or layer and mark only the container like this
```
<ul data-lightbox>
    <li>
        <a href="img/img02.jpg">
            <img src="img/thumbs/thumb02.jpg" />
        </a>
    </li>
    <li>
        <a href="img/img03.jpg">
            <img src="img/thumbs/thumb03.jpg" />
        </a>
    </li>
    <li>
        <a href="img/img04.jpg">
            <img src="img/thumbs/thumb04.jpg" />
        </a>
    </li>
</ul>
```


See it in action
===========

[Here](https://rawgit.com/abelta/lightb-css3/master/index.html)



License
===========


The MIT License (MIT)

Copyright (c) 2014 José Abel Tamayo Pañeda

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.