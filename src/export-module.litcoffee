Export Module
=============

#### The module’s only entry-point is the `Main` class

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if ªF == typeof define and define.amd
      define -> Main

Next, try exporting for CommonJS, eg for [Node](http://goo.gl/Lf84YI):  
`var foo = require('foo');`

    else if ªO == typeof module and module and module.exports
      module.exports = Main

Otherwise, add the `Main` class to global scope. Browser usage would be:  
`var foo = new window.Foo();`

    else @[ªC] = Main




