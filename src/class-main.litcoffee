Main
====

#### The main class for Magnubbin

    class Main
      C: ªC
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


#### `ookonsole <Ookonsole>`
The command-line functionality is instantiated after the HTML is injected. 

        @ookonsole = null




Init
----

If `config.$cssTarget` was passed a `<STYLE>` element, inject Magnubbin’s CSS. 

        if @$cssTarget then injectCSS @$cssTarget, "Injected by #{ªC} #{ªV}"

If `config.$htmlTarget` was passed an element, inject Magnubbin’s HTML. 

        if @$htmlTarget then injectHTML @$htmlTarget, "Injected by #{ªC} #{ªV}"


Instantiate, configure and start the command-line functionality. 

        @ookonsole = new Ookonsole
          $display: $ '#ookonsole-display'
          $command: $ '#ookonsole-command'
        @ookonsole.show()
        @ookonsole.start()




Methods
-------


#### `yy()`
- `xx <xx>`  Xx 

Xx. @todo describe

      yy: (xx) ->




Functions
---------


#### `injectCSS()`
- `$cssTarget <HTMLStyleElement>`  A `<STYLE>` element to inject the CSS into
- `$title <string>`                Text to add at the top of the injected CSS

Xx. @todo describe

    injectCSS = ($cssTarget, title) ->
      $cssTarget.innerHTML = """
        /* `@import` must go first */
        @import url(http://fonts.googleapis.com/css?family=Podkova);

        #{$cssTarget.innerHTML}
        
        /* #{title} */


        /* MAIN SECTIONS */
        .magnubbin-main {
          color: #acb;
        }
        .magnubbin-main >* {
          position: absolute;
          box-sizing: border-box;
          top:    0;
          bottom: 0;
          padding: 1rem;
        }
        .magnubbin-view {
          left:   0;
          right:  0;
          background: rgba(30,50,40,0.7);
        }
        .magnubbin-control {
          display: table;
          right:  0;
          width:  25%;
          height: 100%;
          min-width: 35rem; /* usual maximum ookonsole-display lines */
          background: rgba(30,30,30,0.7);
        }
        .magnubbin-control >* {
          display: table-row;
        }
        .magnubbin-control >* >* {
          display: table-cell;
          height: 1px; /* log is 'auto', so expands to fill */
        }
        .magnubbin-control h4 {
          padding: 0.3em 0;
        }
        .magnubbin-control ul,
        .magnubbin-control pre {
          margin-top: 0.5em;
        }
        .magnubbin-main a {
          color: #eee;
          text-decoration: none;
          transition: all 0.5s;
        }
        .magnubbin-main a:hover {
          color: #0f3;
        }


        /* INFO PANEL */
        .magnubbin-preexisting {
          left:   -76%;
          width:  75%;
          background: rgba(10,10,10,0);
          transition: all 1s;
        }
        .magnubbin-preexisting.active {
          left:   0;
          background: rgba(10,10,10,1);
        }


        /* TOGGLE */
        .magnubbin-toggle-preexisting {
          height: 3em;
        }
        .magnubbin-logo {
          float: left;
          font: bold 1.5em Podkova;
        }
        .magnubbin-icon-info {
          display: block;
          float: right;
          width:      1em;
          height:     1em;
          max-width:  1em;
          max-height: 1em;
          padding: 0;
          border: 2px solid; /* same as text color */
          border-radius: 2em;
          font: bold italic 2em serif;
        }
        .magnubbin-icon-info:before {
          content: "i";
          display: inline-block;
          margin-left: 0.35em;
        }


        /* PRESETS */
        .magnubbin-presets {
          clear: both;
          padding: 0;
        }
        .magnubbin-presets >li {
          display: inline-block;
          padding: 0.5em 0.8em;
          margin: 0 0.2em 0.5em 0;
          list-style-type: none;
          border: 2px solid;
          border-radius: 0.2em;
          color: #eee;
          cursor: pointer;
          transition: all 0.5s;
        }
        .magnubbin-presets >li:hover {
          color: #0f3;
        }


        /* DISPLAY AND COMMAND */
        .magnubbin-control >* #ookonsole-display {
          height: auto; /* override 1px */
          padding: 0.75em 0.8em;
          border: 2px solid;
          border-radius: 0.4em 0.4em 0 0;
          font: 0.75rem "monaco", monospace;
        }
        #ookonsole-command {
          display: block;
          box-sizing: border-box;
          padding: 0.5em;
          width: 100%;
          border: 2px solid #acb;
          border-radius: 0 0 0.4em 0.4em;
          font: 1em "monaco", monospace;
          color: #eee;
          background: transparent;
        }

      """




#### `injectHTML()`
- `$htmlTarget <HTMLStyleElement>`  An element to inject the HTML into
- `$title <string>`                 Text to add at the top of the injected HTML

Xx. @todo describe

    injectHTML = ($htmlTarget, title) ->

Mark the `$htmlTarget` as a wrapper for the Magnubbin HTML elements. 

      $htmlTarget.className += ' magnubbin-wrap'

Inject HTML elements for the basic Magnubbin framework. 

      $htmlTarget.innerHTML = """\n\n
        <!-- #{title} -->

        <!-- The main Magnubbin elements -->
        <main class="magnubbin-main">
          <section class="magnubbin-view">
            <a href="http://loop.coop/" title="Created by Loop.Coop" class="magnubbin-logo">Loop.Coop</a>
          </section>
          <section class="magnubbin-control">
            <div>
              <a href="#/" title="Toggle info" class="magnubbin-toggle-preexisting">
                <span class="magnubbin-logo">Magnubbin</span>
                <span class="magnubbin-icon-info"></span>
              </a>
            </div>
            <div>
              <h4>Presets:</h4>
            </div>
            <div>
              <ul class="magnubbin-presets">
                <li>Preset 1</li>
                <li>Preset 2</li>
                <li>Preset 3</li>
              </ul>
            </div>
            <div>
              <h4>Command Line:</h4>
            </div>
            <div>
              <pre id="ookonsole-display"></pre>
            </div>
            <div>
              <div><input id="ookonsole-command"></div>
            </div>
          </section>
          <section class="magnubbin-preexisting">
            #{$htmlTarget.innerHTML}
          </section>
        </main>

      """

The title at the top of the Control toggles display of the preexisting HTML. 

      $('.magnubbin-toggle-preexisting').addEventListener 'click', ->
        $preexisting = $ '.magnubbin-preexisting'
        if /active/.test $preexisting.className
          $preexisting.className = 'magnubbin-preexisting'
        else
          $preexisting.className = 'magnubbin-preexisting active'


