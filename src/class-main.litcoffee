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


#### `ookonsole <Ookonsole|null>`
The command-line functionality is instantiated after the HTML is injected. 

        @ookonsole = null


#### `oo3d <Oo3d|null>`
The 3D functionality is instantiated after the HTML is injected. 

        @oo3d = null


#### `oo3d <HTMLCollection|null>`
@todo describe. 

        @$$presets = null


#### `focus <integer|undefined>`
Index of the buffer which has focus. The camera has focus if `undefined`. 

        @focus = undefined




Init
----

If `config.$cssTarget` was passed a `<STYLE>` element, inject Magnubbin’s CSS. 

        if @$cssTarget then injectCSS @$cssTarget, "Injected by #{ªC} #{ªV}"

If `config.$htmlTarget` was passed an element, inject Magnubbin’s HTML. 

        if @$htmlTarget then injectHTML @$htmlTarget, "Injected by #{ªC} #{ªV}"

Enable preset buttons. 

        @$$presets = $$ '.magnubbin-presets >li'
        for $preset in @$$presets
          $preset.addEventListener 'click', (event) =>
            @ookonsole.execute event.target.getAttribute 'data-command'

        try

Instantiate, configure and start the command-line functionality. 

          @ookonsole = new Ookonsole
            $display: $ '#ookonsole-display'
            $command: $ '#ookonsole-command'
            context: @ # tasks act on this `main` instance
          @initTasks()
          @ookonsole.show()
          @ookonsole.start()


Instantiate, configure and render the 3D functionality. 

          @oo3d = new Oo3d
            $main: $ '#oo3d-main'
          @oo3d.render()

Deal with init errors. 

        catch error
          $('#magnubbin-error').innerHTML = error
          $('#magnubbin-error').className = '' # remove '.hidden'



      initTasks: ->

Add the `add` task. 

        @ookonsole.addTask 'add',
          summary: "Add a new magnubbin to the scene"
          completions: ['add ocrex','add slyce','add betr'] #@todo more of these
          details: """
    add
    ---
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            oo3d = context.oo3d
            switch options[0]
              when 'ocrex'
                index = oo3d.addBuffer
                  positions: [
                    # 4:5:5 triangle
                    -2.0,  0.3,    -1.84,
                     2.0,  0.3,    -1.84,
                     0.0,  0.0,     2.742566667,
                    # first 3:4:5 triangle
                     0.0,  0.0,     2.742566667,
                     0.0,  2.2678,  0.77866667,
                    -2.0,  0.3,    -1.84,
                    # 4:4:4 triangle
                    -2.0,  0.3,    -1.84,
                     0.0,  2.2678,  0.77866667,
                     2.0,  0.3,    -1.84,
                    # second 3:4:5 triangle
                     2.0,  0.3,    -1.84,
                     0.0,  2.2678,  0.77866667,
                     0.0,  0.0,     2.742566667,
                  ]
                  colors: [
                    # 4:5:5 triangle
                     1.0,  0.0,  0.0,  1.0, # red
                     1.0,  0.0,  1.0,  1.0, # magenta
                     1.0,  0.0,  0.5,  1.0  # red/mag
                    # first 3:4:5 triangle
                     1.0,  0.0,  0.0,  1.0, # red
                     1.0,  0.0,  1.0,  1.0, # magenta
                     1.0,  0.0,  0.5,  1.0  # red/mag
                    # 4:4:4 triangle
                     1.0,  0.0,  0.0,  1.0, # red
                     1.0,  0.0,  1.0,  1.0, # magenta
                     1.0,  0.0,  0.5,  1.0  # red/mag
                    # second 3:4:5 triangle
                     1.0,  0.0,  0.0,  1.0, # red
                     1.0,  0.0,  1.0,  1.0, # magenta
                     1.0,  0.0,  0.5,  1.0  # red/mag
                  ]
                context.focus = index
                oo3d.render() #@todo remove when animation loop is done
                "Added slyce. Focused on index #{index}"
              when 'slyce'
                index = oo3d.addBuffer
                  positions: [
                     0.0,  0.3,  1.0,
                    -0.4, -0.5,  1.0,
                     0.8, -0.3,  1.0
                  ]
                  colors: [
                     1.0,  0.0,  0.0,  1.0, # red
                     0.0,  1.0,  0.0,  1.0, # green
                     0.0,  0.0,  1.0,  1.0  # blue
                  ]
                context.focus = index
                oo3d.render() #@todo remove when animation loop is done
                "Added slyce. Focused on index #{index}"
              when 'betr'
                index = oo3d.addBuffer
                  positions: [
                     1.0,  0.3, -1.0,
                    -0.4, -0.5,  0.0,
                     0.8,  0.3, -1.0
                  ]
                  colors: [
                     1.0,  0.0,  0.0,  1.0, # red
                     0.0,  1.0,  0.0,  1.0, # green
                     0.0,  0.0,  1.0,  1.0  # blue
                  ]
                context.focus = index
                oo3d.render() #@todo remove when animation loop is done
                "Added betr. Focused on index #{index}"
              else
                "'#{options[0]}' not recognised"

Add the `focus` task. 

        @ookonsole.addTask 'focus',
          summary: "Focus on one of the magnubbins"
          completions: ['focus '] #@todo needed?
          details: """
    focus
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            index = options[0]
            if ! /^\d+$/.test index
              "'#{index}' is not a valid index - must be an integer"
            else if ! (target = context.oo3d.buffers[+index])
              "Index '#{index}' does not exist"
            else
              context.focus = +index
              "Focused on index '#{index}'"

Add the `blur` task. 

        @ookonsole.addTask 'blur',
          summary: "Focus on the camera"
          completions: ['blur'] #@todo needed?
          details: """
    blur
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            context.focus = undefined
            "Focused on the camera"

Add the `move` task. 

        @ookonsole.addTask 'move',
          summary: "Move the Focused magnubbin"
          completions: ['move ','move x ','move y ','move z ']
          details: """
    move
    ----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            axis     = options[0]
            distance = options[1]
            if ! /^[xyz]$/.test axis
              "Axis #{axis} is not valid - use x, y, or z"
            else if ! /^-?\d+(.\d+)?$/.test distance #@todo make numeric
              "Distance #{distance} is not valid - must be numeric"
            else
              config =
                target: context.focus
                type:   'translate'
              config[axis] = +distance

              context.oo3d.transform config
              context.oo3d.render() #@todo remove when animation loop is done

              if ªN == ªtype context.focus #@todo make the camera `0`, and change oo3d’s render loop to avoid rendering it
                "Moved index '#{context.focus}'"
              else
                "Moved the camera"

Add the `rotate` task. 

        @ookonsole.addTask 'rotate',
          summary: "Move the Focused magnubbin"
          completions: ['rotate ','rotate x ','rotate y ','rotate z ']
          details: """
    rotate
    ----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            axis    = options[0]
            degrees = options[1]
            if ! /^[xyz]$/.test axis
              "Axis #{axis} is not valid - use x, y, or z"
            else if ! /^-?\d+(.\d+)?$/.test degrees #@todo make numeric
              "Degrees #{degrees} is not valid - must be numeric"
            else
              config =
                target: context.focus
                type:   'rotate' + axis.toUpperCase()
                rad:    degrees * Math.PI / 180

              context.oo3d.transform config
              context.oo3d.render() #@todo remove when animation loop is done

              if ªN == ªtype context.focus #@todo make the camera `0`, and change oo3d’s render loop to avoid rendering it
                "Rotated index '#{context.focus}' #{degrees}º on axis #{axis}"
              else
                "Rotated the camera #{degrees}º on axis #{axis}"




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
          display: flex;
          flex-direction: column;
          justify-content: flex-end;
          right:  0;
          width:  25%;
          height: 100%;
          min-width: 35rem; /* usual maximum ookonsole-display lines */
          background: rgba(30,30,30,0.7);
        }
        .magnubbin-control >* {
          flex-basis: 0%; /* log is '100%', so expands to fill */
        }
        .magnubbin-control h4 { /* @todo remove if not used */
          margin: 0;
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


        /* 3D CONTEXT */
        #oo3d-main {
          position: absolute;
          top:     0;
          left:    0;
          width:   100%;
          height:  100%;
          z-index: -1;
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
          display: block;
          height: 3em;
          margin: 0 0 0.3em 0;
        }
        .magnubbin-icon-info {
          display: block;
          float: left;
          margin: -0.2em 0 0.2em 0;
          padding: 0;
          width:      1em;
          height:     1em;
          max-width:  1em;
          max-height: 1em;
          border: 2px solid; /* same as text color */
          border-radius: 2em;
          font: bold italic 2em serif;
        }
        .magnubbin-icon-info:before {
          content: "i";
          display: inline-block;
          margin-left: 0.35em;
        }
        .magnubbin-logo {
          font: bold 1.5em Podkova;
        }
        .magnubbin-control .magnubbin-logo {
          float: right;
        }


        /* PRESETS */
        ul.magnubbin-presets {
          clear: both;
          margin: 0 0 0.2em 0;
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
        .magnubbin-control #ookonsole-display {
          flex-basis: 100%; /* override 1px */
          margin: 0;
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


        /* ERROR */
        #magnubbin-error {
          position: absolute;
          box-sizing: border-box;
          bottom:  0;
          left:    5%;
          width:  90%;
          padding: 1rem;
          font-family: monaco, monospace;
          background-color: #933;
          color: #fff;
          transition: all 0.5s;
          opacity: 1;
        }
        #magnubbin-error.hidden {
          padding-bottom: 0;
          opacity: 0;
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
            <canvas id="oo3d-main" width="600" height="450"></canvas><!-- @todo resize with window -->
            <a href="http://loop.coop/" title="Created by Loop.Coop" class="magnubbin-logo">Loop.Coop</a>
            <div id="magnubbin-error" class="hidden"></div>
          </section>
          <section class="magnubbin-control">
            <a href="#/" title="Toggle info" class="magnubbin-toggle-preexisting">
              <span class="magnubbin-icon-info"></span>
              <span class="magnubbin-logo">Magnubbin</span>
            </a>
            <ul class="magnubbin-presets">
              <li data-command="clear">Clear</li>
              <li data-command="add ocrex">Add Ocrex</li>
              <li data-command="add slyce">Add Slyce</li>
              <li data-command="add betr">Add Betr</li>
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="move x -0.2">x-</li>
              <li data-command="move x 0.2" >x+</li>
              <li data-command="move y -0.2">y-</li>
              <li data-command="move y 0.2" >y+</li>
              <li data-command="move z -0.2">z-</li>
              <li data-command="move z 0.2" >z+</li>
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="rotate x -20">rx-</li>
              <li data-command="rotate x 20" >rx+</li>
              <li data-command="rotate y -20">ry-</li>
              <li data-command="rotate y 20" >ry+</li>
              <li data-command="rotate z -20">rz-</li>
              <li data-command="rotate z 20" >rz+</li>
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="blur">Focus Camera</li>
              <li data-command="focus 0">0</li>
              <li data-command="focus 1">1</li>
              <li data-command="focus 2">2</li>
              <li data-command="focus 3">3</li>
              <li data-command="focus 4">4</li>
            </ul>
            <pre id="ookonsole-display"></pre>
            <div><input id="ookonsole-command"></div>
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


