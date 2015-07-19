Import Modules
==============

#### Dependencies are imported differently for different runtime environments

First, try importing as AMD modules, eg [RequireJS](http://requirejs.org/). 

    if ªF == typeof define and define.amd
      #@todo

Next, try importing via CommonJS, eg [Node](http://goo.gl/Lf84YI). 

    else if ªO == typeof module and module and module.exports
      Ookonsole = require 'ookonsole'

Next, try importing from `this`. 

    else if @Ookonsole
      Ookonsole = @Ookonsole

Otherwise, try importing from global scope. 

    else
      Ookonsole = window.Ookonsole




