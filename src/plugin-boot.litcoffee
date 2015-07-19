Plugin Boot
===========

#### Instantiate and boot the module, if injected as an Apage plugin

If all three expected Apage arrays are in scope, assume that this module has 
been injected into an Apage-built page. 

    if (ªU != typeof arts) and (ªU != typeof resolvers) and (ªU != typeof updaters)
      main = new Main
        $cssTarget:  $ 'style'   # append to the first `<STYLE>` element
        $htmlTarget: $ 'article' # append to the first `<ARTICLE>` element


