Export Plugin
=============

#### Instantiate and boot the module, if injected as an Apage plugin

If all three expected Apage arrays are in scope, assume that this module has 
been injected into an Apage-built page. 

    if (ªA == ªtype arts) and (ªA == ªtype resolvers) and (ªA == ªtype updaters)
      main = new Main
        $cssTarget:  $ 'style'   # append to the first `<STYLE>` element
        $htmlTarget: $ 'article' # append to the first `<ARTICLE>` element


