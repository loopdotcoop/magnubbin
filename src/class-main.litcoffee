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


#### `focusIndex <integer|undefined>`
Index of the shape which has focus. The camera has focus if `undefined`. 

        @focusIndex = undefined




Init
----


If `config.$cssTarget` was passed a `<STYLE>` element, inject Magnubbin’s CSS.  
If `config.$htmlTarget` was passed an element, inject Magnubbin’s HTML. 

        if @$cssTarget  then injectCSS  @$cssTarget,  "Injected by #{ªC} #{ªV}"
        if @$htmlTarget then injectHTML @$htmlTarget, "Injected by #{ªC} #{ªV}"


##### Command-line

        try

Instantiate, configure and start the command-line functionality. 

          @ookonsole = new Ookonsole
            $display: $ '#ookonsole-display'
            $command: $ '#ookonsole-command'
            context: @ # tasks act on this `main` instance
          @initTasks()
          @ookonsole.show()
          @ookonsole.start()

Deal with command-line init errors. 

        catch error
          $('#magnubbin-error').innerHTML = error
          $('#magnubbin-error').className = '' # remove '.hidden'
          return


##### 3D engine

        try

Instantiate and configure the 3D engine. 

          @$main = $ '#oo3d-main'
          @oo3d = new Oo3d
            $main: @$main
            bkgnd: new Float32Array([1,1,1,1]) # opaque white

Load position and color Buffers. 

          @pyramidPositionI = @oo3d.add('Buffer.Position', { data:[
            # front face
             0.0,  1.0,  0.0,
            -1.0, -1.0,  1.0,
             1.0, -1.0,  1.0,
            # right face
             0.0,  1.0,  0.0,
             1.0, -1.0,  1.0,
             1.0, -1.0, -1.0,
            # back face
             0.0,  1.0,  0.0,
             1.0, -1.0, -1.0,
            -1.0, -1.0, -1.0,
            # left face
             0.0,  1.0,  0.0,
            -1.0, -1.0, -1.0,
            -1.0, -1.0,  1.0
          ]})

          @pyramidColorI = @oo3d.add('Buffer.Color', { data:[
            # Front face
             0.3,   0.0,  0.0,  0.95, # near-opaque dark red
             0.3,   0.0,  0.0,  0.95, # near-opaque dark red
             0.3,   0.0,  0.0,  0.95, # near-opaque dark red
            # Right face
             0.0,  0.25,  0.0,  0.75, # translucent lime
             0.0,  0.25,  0.0,  0.75, # translucent lime
             0.0,  0.25,  0.0,  0.75, # translucent lime
            # Back face
             1.0,  0.25,  0.0,  0.10, # translucent orange
             1.0,  0.25,  0.0,  0.10, # translucent orange
             1.0,  0.25,  0.0,  0.10, # translucent orange
            # Left face
             0.25,  0.5,  1.0,  0.05, # translucent light cyan
             0.25,  0.5,  1.0,  0.05, # translucent light cyan
             0.25,  0.5,  1.0,  0.05  # translucent light cyan
          ]})

Create camera, program, renderer and layer. 

          @cameraI = @oo3d.add('Item.Camera',
            fovy:   0.785398163 # 45º
            aspect: @$main.width / @$main.height
          )

          @flatItemProgramI = @oo3d.add('Program.FlatItem',
            subclass: 'Flat'
          )

          @rendererI = @oo3d.add('Renderer.Wireframe',
            cameraI:  @cameraI
            programI: @flatItemProgramI
            meshIs:   []
          )

          @layerI = @oo3d.add('Layer.Simple',
            rendererIs: [@rendererI]
            scissor:    [0,0,1,1]
          )


Render the initial scene. 

          @oo3d.render()

Deal with 3d engine init errors. 

        catch error
          $('#magnubbin-error').innerHTML = error
          $('#magnubbin-error').className = '' # remove '.hidden'
          return


#### Enable preset buttons and click/drag on the 3d scene. 

        @initPresets()
        @initSceneUI()



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
                index = oo3d.add('Item.Mesh',
                  positionI:  context.pyramidPositionI
                  colorI:     context.pyramidColorI
                )
                oo3d._all[context.rendererI].meshes.push(
                  oo3d._all[index]
                )
                context.changeFocus index
                oo3d.render() #@todo remove when animation loop is done
                $('.magnubbin-focus-presets').innerHTML += """
                  <li id="magnubbin-focus-preset-#{index}" 
                  data-command="focus #{index}">Ocrex##{index}</li>"""
                context.initPresets()
                "Added ocrex. Focused on index #{index}"
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
            else if 'Item.Mesh' != context.oo3d._all[+index]?.C
              "'#{index}' is not the index of an Item.Mesh"
            else
              context.changeFocus +index
              context.oo3d.render() #@todo remove when animation loop is done
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
            context.changeFocus() # `focusIndex` argument is undefined
            context.oo3d.render() #@todo remove when animation loop is done
            "Focused on the camera"




Add the `edit` task. 

        @ookonsole.addTask 'edit',
          summary: "Edit the focused Item.Mesh, or the camera"
          completions: ['edit ']
          details: """
    edit
    ----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            set   = {}
            delta = {}
            i = 0; l = options.length
            while i < l
              option =  options[i++]
              value  = +options[i++]
              if ! /^d?[rst][xyz]$/.test option then return "
                `options[#{i-2}]` is invalid, use 'dtx', 'sz', etc"
              if isNaN value then return "
                `options[#{i-1}]` is invalid, must be numeric"
              if 'd' != option.charAt 0
                set[   option[0] + option[1].toUpperCase() ] = value
              else
                delta[ option[1] + option[2].toUpperCase() ] = value

            if ªN == ªtype context.focusIndex #@todo make the camera `0`, and change oo3d’s render loop to avoid rendering it
              context.oo3d.edit context.focusIndex, set, delta
              context.oo3d.render() #@todo remove when animation loop is done
              "Edited index '#{context.focusIndex}'"
            else
              context.oo3d.edit context.cameraI, set, delta
              context.oo3d._all[context.cameraI].updateCamera() #@todo remove when Item.Camera updates itself after an `edit()`
              context.oo3d.render() #@todo remove when animation loop is done
              "Edited the camera"




Methods
-------


#### `initPresets()`

Xx. @todo describe

      initPresets: ->
        @$$presets = $$ '.magnubbin-presets >li'
        for $preset in @$$presets
          $preset.removeEventListener 'click', onPresetClick #@todo is this needed?
          $preset.addEventListener    'click', onPresetClick




#### `initSceneUI()`

Xx. @todo describe

      initSceneUI: ->
        $('.magnubbin-view').addEventListener 'mousedown', (event) =>
          wh     = vpSize()
          w      = wh[0]
          h      = wh[1]
          wRatio = @$main.width  / w
          hRatio = @$main.height / h
          x      = Math.round(wRatio * event.clientX)
          y      = Math.round(hRatio * event.clientY)

          color = @oo3d.getColorAt x, @$main.height - y
          meshI = @oo3d.getMeshIByColor color

          if 16777215 == meshI # `16777215` is the background
            @ookonsole.execute 'blur'
          else
            @ookonsole.execute 'focus ' + meshI




#### `changeFocus()`
- `focusIndex <integer>`  Index of the shape to focus on 

Xx. @todo describe

      changeFocus: (focusIndex) ->

Update the `focusIndex` property. 

        @focusIndex = focusIndex

Set all Item.Mesh render modes to solid-color. @todo quicker than this?

        for instance in @oo3d._all
          if 'Item.Mesh' == instance.C
            @oo3d.setRenderMode 'TRIANGLES', instance.index

Set the newly focused shape’s render mode to wireframe. 

        if ªN == typeof focusIndex
          @oo3d.setRenderMode 'LINE_LOOP', focusIndex




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
          padding: 0;
          background: transparent; /* was rgba(30,50,40,0.7) */
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
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="edit drx -20">rx-</li>
              <li data-command="edit drx 20" >rx+</li>
              <li data-command="edit dry -20">ry-</li>
              <li data-command="edit dry 20" >ry+</li>
              <li data-command="edit drz -20">rz-</li>
              <li data-command="edit drz 20" >rz+</li>
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="edit dsx 2.0 dsy 2.0 dsz 2.0">&times;2</li>
              <li data-command="edit dsx 0.5 dsy 0.5 dsz 0.5" >&divide2</li>
              <li data-command="edit dsx -1">fx</li>
              <li data-command="edit dsy -1">fy</li>
              <li data-command="edit dsz -1">fz</li>
            </ul>
            <ul class="magnubbin-presets">
              <li data-command="edit dtx -0.2">x-</li>
              <li data-command="edit dtx 0.2" >x+</li>
              <li data-command="edit dty -0.2">y-</li>
              <li data-command="edit dty 0.2" >y+</li>
              <li data-command="edit dtz -0.2">z-</li>
              <li data-command="edit dtz 0.2" >z+</li>
            </ul>
            <ul class="magnubbin-presets magnubbin-focus-presets">
              <li data-command="blur">Focus Camera</li>
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




#### `onPresetClick()`

Xx. @todo describe

    onPresetClick = (event) ->
      try
        window.magnubbin.ookonsole.execute event.target.getAttribute 'data-command'
      catch error
        $('#magnubbin-error').innerHTML = error
        $('#magnubbin-error').className = '' # remove '.hidden'




#### `vpSize()`

Returns an array with two elements, the viewport width and the viewport height. 
Based on [this Stack Overflow answer. ](http://stackoverflow.com/a/11744120)  
@todo test on iOS and Android  
@todo improve performance

    vpSize = (event) ->
      d = document
      e = d.documentElement
      b = d.getElementsByTagName('body')[0]
      w = window.innerWidth  || e.clientWidth  || b.clientWidth
      h = window.innerHeight || e.clientHeight || b.clientHeight
      [w,h]






