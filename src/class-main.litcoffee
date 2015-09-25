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


#### `focusI <integer|undefined>`
Index of the shape which has focus. The camera has focus if `undefined`. 

        @focusI = undefined


#### `downPos <array|null>`
Xx. 

        @downPos = null


#### `deltaCalc <function>`
Xx. 

        @deltaCalc = (x, y) -> {}


#### `snapshot <object|null>`
Xx. 

        @snapshot = null


#### `delta <object|null>`
Xx. 

        @delta = null




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

          @flatrPositionI = @oo3d.add('Buffer.Position', { data:[
            # flatr tabletop face
             0.000, -0.330,  1.732 # G
            -2.000, -0.330, -1.732 # H
             2.000, -0.330, -1.732 # I
            # flatr distant-left face
             0.000, -0.330,  1.732 # G
            -2.000, -0.330, -1.732 # H
             0.000,  0.660,  1.588 # J
            # flatr distant-right face
             0.000, -0.330,  1.732 # G
             2.000, -0.330, -1.732 # I
             0.000,  0.660,  1.588 # J
            # flatr near face
            -2.000, -0.330, -1.732 # H
             2.000, -0.330, -1.732 # I
             0.000,  0.660,  1.588 # J
          ]})
          @betrPositionI = @oo3d.add('Buffer.Position', { data:[
            # betr tabletop face
             0.000, -0.471,  2.135 # G
            -1.265, -0.471, -1.660 # H
             1.581, -0.471, -2.609 # I
            # betr distant-left face
             0.000, -0.471,  2.135 # G
            -1.265, -0.471, -1.660 # H
            -0.119,  0.942,  0.725 # J
            # betr distant-right face
             0.000, -0.471,  2.135 # G
             1.581, -0.471, -2.609 # I
            -0.119,  0.942,  0.725 # J
            # betr near face
            -1.265, -0.471, -1.660 # H
             1.581, -0.471, -2.609 # I
            -0.119,  0.942,  0.725 # J
          ]})
          @ocrexPositionI = @oo3d.add('Buffer.Position', { data:[
            # ocrex tabletop face
             0.000, -0.756,  2.291 # G
            -2.000, -0.756, -2.291 # H
             2.000, -0.756, -2.291 # I
            # ocrex distant-left face
             0.000, -0.756,  2.291 # G
            -2.000, -0.756, -2.291 # H
             0.000,  1.512,  0.327 # J
            # ocrex distant-right face
             0.000, -0.756,  2.291 # G
             2.000, -0.756, -2.291 # I
             0.000,  1.512,  0.327 # J
            # ocrex near face
            -2.000, -0.756, -2.291 # H
             2.000, -0.756, -2.291 # I
             0.000,  1.512,  0.327 # J
          ]})
          @icosPositionI = @oo3d.add('Buffer.Position', { data:[
            # icos tabletop face
             0.000, -0.744,  2.291 # G
            -2.000, -0.744, -2.291 # H
             2.000, -0.744, -2.291 # I
            # icos distant-left face
             0.000, -0.744,  2.291 # G
            -2.000, -0.744, -2.291 # H
             0.000,  1.489, -2.182 # J
            # icos distant-right face
             0.000, -0.744,  2.291 # G
             2.000, -0.744, -2.291 # I
             0.000,  1.489, -2.182 # J
            # icos near face
            -2.000, -0.744, -2.291 # H
             2.000, -0.744, -2.291 # I
             0.000,  1.489, -2.182 # J
          ]})
          @decrPositionI = @oo3d.add('Buffer.Position', { data:[
            # decr tabletop face
             0.000, -0.634,  3.083 # G
            -1.581, -0.634, -1.660 # H
             2.530, -0.634, -4.506 # I
            # decr distant-left face
             0.000, -0.634,  3.083 # G
            -1.581, -0.634, -1.660 # H
             0.731,  1.269, -1.482 # J
            # decr distant-right face
             0.000, -0.634,  3.083 # G
             2.530, -0.634, -4.506 # I
             0.731,  1.269, -1.482 # J
            # decr near face
            -1.581, -0.634, -1.660 # H
             2.530, -0.634, -4.506 # I
             0.731,  1.269, -1.482 # J
          ]})
          @sqishPositionI = @oo3d.add('Buffer.Position', { data:[
            # sqish tabletop face
             0.000, -0.485,  3.303 # G
            -1.984, -0.485, -2.359 # H
             2.646, -0.485, -4.247 # I
            # sqish distant-left face
             0.000, -0.485,  3.303 # G
            -1.984, -0.485, -2.359 # H
            -0.220,  0.970, -0.417 # J
            # sqish distant-right face
             0.000, -0.485,  3.303 # G
             2.646, -0.485, -4.247 # I
            -0.220,  0.970, -0.417 # J
            # sqish near face
            -1.984, -0.485, -2.359 # H
             2.646, -0.485, -4.247 # I
            -0.220,  0.970, -0.417 # J
          ]})
          @slysPositionI = @oo3d.add('Buffer.Position', { data:[
            # slys tabletop face
             0.000, -0.678,  3.992 # G
            -0.500, -0.678, -3.992 # H
             0.500, -0.678, -3.992 # I
            # slys distant-left face
             0.000, -0.678,  3.992 # G
            -0.500, -0.678, -3.992 # H
             0.000,  1.356,  0.548 # J
            # slys distant-right face
             0.000, -0.678,  3.992 # G
             0.500, -0.678, -3.992 # I
             0.000,  1.356,  0.548 # J
            # slys near face
            -0.500, -0.678, -3.992 # H
             0.500, -0.678, -3.992 # I
             0.000,  1.356,  0.548 # J
          ]})
          @spykPositionI = @oo3d.add('Buffer.Position', { data:[
            # spyk tabletop face
             0.000, -0.288,  3.992 # G
            -0.500, -0.288, -3.992 # H
             0.500, -0.288, -3.992 # I
            # spyk distant-left face
             0.000, -0.288,  3.992 # G
            -0.500, -0.288, -3.992 # H
             0.000,  0.577, -3.961 # J
            # spyk distant-right face
             0.000, -0.288,  3.992 # G
             0.500, -0.288, -3.992 # I
             0.000,  0.577, -3.961 # J
            # spyk near face
            -0.500, -0.288, -3.992 # H
             0.500, -0.288, -3.992 # I
             0.000,  0.577, -3.961 # J
          ]})

          @genericColorI = @oo3d.add('Buffer.Color', { data:[
            # Front face
             0.3,   0.0,  0.0,  0.95 # near-opaque dark red
             0.3,   0.0,  0.0,  0.95 # near-opaque dark red
             0.3,   0.0,  0.0,  0.95 # near-opaque dark red
            # Right face
             0.0,  0.25,  0.0,  0.75 # translucent lime
             0.0,  0.25,  0.0,  0.75 # translucent lime
             0.0,  0.25,  0.0,  0.75 # translucent lime
            # Back face
             1.0,  0.25,  0.0,  0.10 # translucent orange
             1.0,  0.25,  0.0,  0.10 # translucent orange
             1.0,  0.25,  0.0,  0.10 # translucent orange
            # Left face
             0.25,  0.5,  1.0,  0.05 # translucent light cyan
             0.25,  0.5,  1.0,  0.05 # translucent light cyan
             0.25,  0.5,  1.0,  0.05 # translucent light cyan
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


#### Display a scene, if provided by the `scene_v1` query-string. 

        query = parseQuery window.location.search.slice 1
        if query.scene_v1
          @ookonsole.execute 'restore ' + query.scene_v1
        else
          $('.magnubbin-preexisting').className = 'magnubbin-preexisting active'
          $('.magnubbin-icon-info').className   = 'magnubbin-icon-info active'


#### Enable preset buttons and click/drag on the 3d scene. 

        @initPresets()
        @initGrid9()




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
            valid = ['flatr','betr','ocrex','icos','decr','sqish','slys','spyk']
            if -1 == valid.indexOf options[0] then return "
              Buffer.Position '#{options[0]}' not recognised"

            index = oo3d.add('Item.Mesh',
              positionI:  context[options[0] + 'PositionI']
              colorI:     context.genericColorI
            )
            oo3d.edit index, { sX:0.25, sY:0.25, sZ:0.25 }
            oo3d._all[context.rendererI].meshes.push oo3d._all[index]
            context.changeFocus index
            oo3d.render() #@todo remove when animation loop is done
            $('.magnubbin-focus-presets').innerHTML += """
              <li id="magnubbin-focus-preset-#{index}" 
              data-command="focus #{index}">#{options[0]}##{index}</li>"""
            context.initPresets()
            "Added #{options[0]}. Focused on index #{index}"




Add the `delete` task. 

        @ookonsole.addTask 'delete',
          summary: "Remove the focused Item.Mesh from the scene"
          completions: ['delete']
          details: """
    delete
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            if context.focusI
              context.oo3d.delete context.focusI
              context.oo3d.render()
              "Deleted index '#{context.focusI}'"
            else
              "Cannot delete the camera"




Add the `focus` task. 

        @ookonsole.addTask 'focus',
          summary: "Focus on one of the magnubbins"
          completions: ['focus ']
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
          completions: ['blur']
          details: """
    blur
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            context.changeFocus() # `focusI` argument is undefined
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

            if context.focusI
              context.oo3d.edit context.focusI, set, delta
              context.oo3d.render()
              "Edited index '#{context.focusI}'"
            else
              context.oo3d.edit context.cameraI, set, delta
              context.oo3d._all[context.cameraI].updateCamera() #@todo remove when Item.Camera updates itself after an `edit()`
              context.oo3d.render()
              "Edited the camera"




Add the `reset` task. 

        @ookonsole.addTask 'reset',
          summary: "Reset the focused Item.Mesh, or the camera"
          completions: ['reset']
          details: """
    reset
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->
            if context.focusI
              context.oo3d.edit context.focusI, 'reset'
              context.oo3d.edit context.focusI, { sX:0.25, sY:0.25, sZ:0.25 }
              context.oo3d.render()
              "Reset index '#{context.focusI}'"
            else
              context.oo3d.edit context.cameraI, 'reset'
              context.oo3d._all[context.cameraI].updateCamera() #@todo remove when Item.Camera updates itself after an `edit()`
              context.oo3d.render()
              "Reset the camera"




Add the `save` task. 

        @ookonsole.addTask 'save',
          summary: "Convert the scene into an Nwang string"
          completions: ['save ', 'save prefix ']
          details: """
    save
    -----
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->

Generate the save-string. 

            out = ''
            out += context.oo3d.read(context.cameraI, 'nwang').slice(-9) + ';'
            for instance in context.oo3d._all
              if 'Item.Mesh' == instance?.C #@todo `oo3d.each('Item.Mesh', ...)`
                out += context.oo3d.read(instance.index, 'nwang').slice(-11) + ';'
            out = out.slice 0, -1

Add a prefix if required. 

            pos = options.indexOf 'prefix'
            if -1 != pos
              if ! options[pos+1] then return "
                The 'prefix' option must be followed by text"
              else
                out = options[pos+1] + out

Invoke a browser prompt if required. 

            if -1 != options.indexOf 'prompt'
              prompt 'Save:', out

            "Save: #{out}"




Add the `restore` task. 

        @ookonsole.addTask 'restore',
          summary: "Replace the current scene with an Nwang-defined scene"
          completions: ['restore ']
          details: """
    restore
    -------
    @todo describe. 

    @todo usage

    """
          runner: (context, options) ->

Parse the restore-string. 

            if ! options[0] then return "
              no restore-string provided"

            #@todo delete all preexisting meshes

            #sf3 = context.oo3d.nwang.sf3
            oo3d = context.oo3d
            items = options[0].split ';'

            camera = items.shift()
            oo3d.edit context.cameraI, camera
            oo3d._all[context.cameraI].updateCamera()

            for item in items
              index = oo3d.add 'Item.Mesh'
              oo3d.edit index, item
              oo3d._all[context.rendererI].meshes.push oo3d._all[index]
            oo3d.render() #@todo remove when animation loop is done

            "Restored #{items.length} mesh#{if 1 == items.length then '' else 'es'}"




Methods
-------


#### `initPresets()`

Xx. @todo describe

      initPresets: ->
        return #@todo perhaps reinstate presets in a later version?
        @$$presets = $$ '.magnubbin-presets >li'
        for $preset in @$$presets
          $preset.removeEventListener 'click', onPresetClick #@todo is this needed?
          $preset.addEventListener    'click', onPresetClick




#### `initGrid9()`

Xx. @todo describe

      initGrid9: ->


##### Mesh picker

Add a mousedown event listener on the main canvas. 

        $('.magnubbin-view').addEventListener 'mousedown', (event) =>
          wh     = vpSize()
          w      = wh[0]
          h      = wh[1]
          wRatio = @$main.width  / w
          hRatio = @$main.height / h
          x      = Math.round(wRatio * event.clientX)
          y      = Math.round(hRatio * event.clientY)

Get the index of the Item.Mesh under the mouse (or touch-position). 

          color = @oo3d.getColorAt x, @$main.height - y
          meshI = @oo3d.getMeshIByColor color

Focus on the Item.Mesh. Or if the background was clicked, focus on the camera. 

          if 16777215 == meshI # `16777215` is the background
            @ookonsole.execute 'blur'
          else
            @ookonsole.execute 'focus ' + meshI

Hide other panels. 

          $preexisting = $ '.magnubbin-preexisting'
          $icon        = $ '.magnubbin-icon-info'
          $control     = $ '.magnubbin-control'
          $icon        = $ '.magnubbin-icon-control'
          $preexisting.className = 'magnubbin-preexisting'
          $icon.className        = 'magnubbin-icon-info'
          $control.className     = 'magnubbin-control'
          $icon.className        = 'magnubbin-icon-control'


##### Grid9 Scene

Init the scene Add button. 

        $('#grid9-scene-add').addEventListener 'mousedown', (event) ->
          grid9OnlyShow $ '#grid9-add'

Init the scene Save button. 

        $('#grid9-scene-save').addEventListener 'mousedown', (event) =>
          @ookonsole.execute "save prompt prefix
            #{location.protocol}//#{location.host+location.pathname}?scene_v1="

Init the scene Reset button. 

        $('#grid9-scene-reset').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'reset'

Init the scene transform buttons. 

        scenedeltaCalcs =
          'grid9-scene-txy'  : txyDelta
          'grid9-scene-txz'  : txzDelta
          'grid9-scene-rxy'  : rxyDelta
          'grid9-scene-ryz'  : ryzDelta
          'grid9-scene-scale': scaleDelta
        for id,deltaCalc of scenedeltaCalcs
          ((id,deltaCalc)-> # capture each id/deltaCalc pair in a closure
            $('#' + id).addEventListener 'mousedown', (event) ->
              onMousedown  event, $('#grid9-scene'), deltaCalc
            $('#' + id).addEventListener 'touchstart', (event) ->
              onTouchstart event, $('#grid9-scene'), deltaCalc
          )(id,deltaCalc)
          undefined # simplify compiled JS


##### Grid9 Add

Init the add Back button. 

        $('#grid9-add-back').addEventListener 'mousedown', (event) =>
          grid9OnlyShow $ '#grid9-mesh'

Init the add mesh buttons. 

        meshNames =
          'grid9-add-shape-0': 'flatr'
          'grid9-add-shape-1': 'betr'
          'grid9-add-shape-2': 'ocrex'
          'grid9-add-shape-3': 'icos'
          'grid9-add-shape-4': 'decr'
          'grid9-add-shape-5': 'sqish'
          'grid9-add-shape-6': 'slys'
          'grid9-add-shape-7': 'spyk'
        for id,meshName of meshNames
          main = @
          ((id,meshName)-> # capture each id/meshName pair in a closure
            $('#' + id).addEventListener 'mousedown', (event) ->
              main.ookonsole.execute 'add ' + meshName
          )(id,meshName)
          undefined # simplify compiled JS


##### Grid9 Mesh

Init the mesh Delete button. 

        $('#grid9-mesh-delete').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'delete'

Init the scene Flip button. 

        $('#grid9-mesh-flip').addEventListener 'mousedown', (event) ->
          grid9OnlyShow $ '#grid9-flip'

Init the mesh Reset button. 

        $('#grid9-mesh-reset').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'reset'

Init the mesh transform buttons. 

        meshdeltaCalcs =
          'grid9-mesh-txy'  : txyDelta
          'grid9-mesh-txz'  : txzDelta
          'grid9-mesh-rxy'  : rxyDelta
          'grid9-mesh-ryz'  : ryzDelta
          'grid9-mesh-scale': scaleDelta
        for id,deltaCalc of meshdeltaCalcs
          ((id,deltaCalc)-> # capture each id/deltaCalc pair in a closure
            $('#' + id).addEventListener 'mousedown', (event) ->
              onMousedown  event, $('#grid9-mesh'), deltaCalc
            $('#' + id).addEventListener 'touchstart', (event) ->
              onTouchstart event, $('#grid9-mesh'), deltaCalc
          )(id,deltaCalc)
          undefined # simplify compiled JS


##### Grid9 Flip

Init the flip Back button. 

        $('#grid9-flip-back').addEventListener 'mousedown', (event) =>
          grid9OnlyShow $ '#grid9-mesh'

Init the three main flip buttons. 

        $('#grid9-flip-x').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'edit dsx -1'
        $('#grid9-flip-y').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'edit dsy -1'
        $('#grid9-flip-z').addEventListener 'mousedown', (event) =>
          @ookonsole.execute 'edit dsz -1'




#### `changeFocus()`
- `focusI <integer>`  index of the shape to focus on 

Xx. @todo describe

      changeFocus: (focusI) ->

Update the `focusI` property. 

        @focusI = focusI

Set all Item.Mesh render modes to solid-color. @todo quicker than this?

        for instance in @oo3d._all
          if 'Item.Mesh' == instance.C
            @oo3d.setRenderMode 'TRIANGLES', instance.index

Set the newly focused Item.Mesh’s render mode to wireframe. 

        if ªN == typeof focusI
          @oo3d.setRenderMode 'LINE_LOOP', focusI
          grid9OnlyShow $ '#grid9-mesh'

Or for the camera, toggle the Grid9 Scene UI.

        else
          $grid9Mesh = $ '#grid9-scene'
          if 'grid9 active' == $grid9Mesh.getAttribute 'class'
            grid9OnlyShow()
          else
            grid9OnlyShow $grid9Mesh




#### `updateMeshInfo()`

Xx. @todo describe

      updateMeshInfo: -> ª 'do updateMeshInfo!'




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


        /* LAYOUT */
        html, body {
          overflow: hidden;
        }
        a img:active {
          outline: none;
        }


        /* MAIN SECTIONS */
        .magnubbin-main {
          color: #9fc;
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


        /* MIN/MAX BUTTONS */
        .magnubbin-panel-minmax {
          left:    0;
          right:   0;
          padding: 0;
          height:  1px;
          z-index: 20;
        }
        .magnubbin-panel-minmax >a {
          display:    block;
          position:   relative;
          margin:     0.6rem 1rem;
          padding:    0;
          width:      1em;
          height:     1em;
          max-width:  1em;
          max-height: 1em;
          border: 2px solid; /* same as text color */
          border-radius: 2em;
          font: bold italic 2em serif;
        }
        .magnubbin-icon-info:before {
          display: inline-block;
          position: absolute;
          margin-left: 0.35em;
          content: "i";
        }
        .magnubbin-icon-info.active:before {
          content: "×";
          font-style: normal;
          margin: -0.1em 0 0 0.22em;
        }
        .magnubbin-icon-control:before {
          display: inline-block;
          position: absolute;
          margin: -0.1em 0 0 0.25em;
          content: "§";
        }
        .magnubbin-icon-control.active:before {
          content: "×";
          font-style: normal;
          margin: -0.1em 0 0 0.22em;
        }
        .magnubbin-toggle-preexisting {
          float: left;
        }
        .magnubbin-toggle-command {
          float: right;
        }

        .magnubbin-logo {
          display: none; /*@todo perhaps show this again */
          font: bold 1.5em Podkova;
        }
        .magnubbin-control .magnubbin-logo {
          float: right;
        }


        /* XX */
        .magnubbin-main a {
          color: #c69;
          text-decoration: none;
          transition: all 0.5s;
        }
        .magnubbin-main a:hover {
          color: #f6d;
        }

        .magnubbin-control {
          display: flex;
          flex-direction: column;
          justify-content: flex-end;
          padding:    0;
          right:      0;
          width:      0;
          min-width:  0;
          max-width:  0;
          height:   100%;
          background: rgba(0,0,0,0.9);
          opacity:    0;
          transition: all 0.3s;
        }
        .magnubbin-control.active {
          padding:    1rem;
          width:     25%;
          min-width: 35rem; /* usual maximum ookonsole-display lines */
          max-width: 35rem; /* usual maximum ookonsole-display lines */
          opacity:    1;
        }
        .magnubbin-control >* {
          flex-basis: 0%; /* log is '100%', so expands to fill */
        }
        .magnubbin-control h2 {
          margin: 0;
          padding: 0.3em 0;
        }
        .magnubbin-control h2 tt {
          color: #eee;
          font: bold 1em monaco, monospace;
        }
        .magnubbin-control ul,
        .magnubbin-control pre {
          margin-top: 0.5em;
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
          left:      -101%;
          width:      100%;
          background: rgba(0,0,0,0.9) url(build/asset/magnubbin-info-bkgnd.png) center center;
          background-size: cover;
          text-align: center;
          opacity:      0;
          transition:   all 0.3s;
        }
        .magnubbin-preexisting.active {
          left:    0;
          opacity: 1;
        }
        .magnubbin-preexisting h1 {
          display: none;
          margin-top: 2.5rem;
        }
        a[title="Visit the Loop.Coop homepage"] {
          display: block;
          margin-top: 8rem;
        }
        a[title="Refresh Magnubbin"] {
          display: block;
        }
        .magnubbin-preexisting h4 {
          font-size: 1.5em;
          text-shadow: -2px 0 black, 0 2px black, 2px 0 black, 0 -2px black
        }
        .magnubbin-preexisting h5 strong {
          display: inline-block;
          padding: 0.5em 1em 0.4em 1em;
          font-size: 2em;
          background-color: rgba(0,0,0,0.7);
          border: 2px solid;
          border-radius: 0.2em;
          cursor: pointer;
          transition: all 0.5s;
        }
        .magnubbin-preexisting h5 strong:hover {
          color: #0f3;
        }
        .magnubbin-preexisting ol {
          display: inline-block;
          padding: 1rem 1rem 1rem 3rem;
          text-align: left; 
          background-color: rgba(0,0,0,0.7);
          border: 2px solid;
          border-radius: 0.2em;
        }
        a[title="GitHub"] {
          position: fixed;
          left: 0;
          right: 0;
          bottom: 0.5rem;
        }
        @media only screen and (max-width: 830px) {
          a[title="Visit the Loop.Coop homepage"] {
            margin-top: 5rem;
          }
          a[title="Visit the Loop.Coop homepage"] img {
            width: 38%;
            height: auto;
          }
          a[title="Refresh Magnubbin"] img {
            width: 80%;
            height: auto;
          }
        }
        @media only screen and (max-height: 850px) {
          a[title="Visit the Loop.Coop homepage"] {
            margin-top: 5rem;
          }
        }
        @media only screen and (max-height: 800px) {
          a[title="Visit the Loop.Coop homepage"] {
            margin-top: 2rem;
          }
          .magnubbin-preexisting ol {
            padding: 0.6rem 0.6rem 0.6rem 2rem;
            font-size: 0.8em;
          }
        }
        @media only screen and (max-height: 680px) {
          .magnubbin-preexisting ol {
            display: none;
          }
        }
        @media only screen and (max-height: 450px) {
          a[title="GitHub"] {
            display: none;
          }
        }


        /* PRESETS */
        /*@todo perhaps reinstate presets in a later version? */
        /*
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
          color: #9fc;
          cursor: pointer;
          transition: all 0.5s;
        }
        .magnubbin-presets >li:hover {
          color: #0f3;
        }
        */


        /* DISPLAY AND COMMAND */
        .magnubbin-control #ookonsole-display {
          flex-basis: 100%; /* override 1px */
          margin: 0;
          padding: 0;
          border-width: 0;
          border-radius: 0.4em 0.4em 0 0;
          font: 0.75rem "monaco", monospace;
        }
        .magnubbin-control.active #ookonsole-display {
          padding: 0.75em 0.8em;
          border: 2px solid;
        }
        #ookonsole-command {
          display: block;
          box-sizing: border-box;
          width: 100%;
          padding: 0;
          border-width: 0;
          border-radius: 0 0 0.4em 0.4em;
          font: 1em "monaco", monospace;
          color: #eee;
          background: transparent;
        }
        .magnubbin-control.active #ookonsole-command {
          padding: 0.5em;
          border: 2px solid #9fc;
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

        /* GRID9 */
        .magnubbin-grid9 {
          opacity: 1;
          transition: all 0.3s;
        }
        .magnubbin-grid9.active {
          opacity: 0.4;
        }
        .grid9 {
          position:    fixed;
          display:     block;
          padding:     0;
          width:       0;
          height:      0;
          left:        50%;
          margin-left: -145px;
          top:         50%;
          margin-top:  -125px;
          opacity:     0;  /* '1' when active */
          z-index:     -5; /* '10' when active */
          transition: opacity 0.4s, z-index 0.1s 0.5s;
        }
        .grid9.active {
          z-index: 10;
          opacity: 1;
          transition: opacity 0.4s;
        }
        .grid9 >li {
          position:    absolute;
          width:       90px;
          height:      90px;
          list-style:  none;
          text-align:  center;
          background:  rgba(0,0,0,0.85);
          cursor: default;
          transition:  all 0.4s;
        }
        .grid9 >li:hover {
          color:       #fff;
          background:  rgba(0,0,0,0.95);
        }
        .grid9.active >li { /* eg during transition */
          cursor: pointer;
        }
        .grid9 >li >b,
        .grid9 >li >i {
          display: block;
          -webkit-touch-callout: none; /* Android and iOS callouts*/
            -webkit-user-select: none; /* Chrome, Safari, Opera */
             -khtml-user-select: none; /* Konqueror */
               -moz-user-select: none; /* Firefox */
                -ms-user-select: none; /* IE */
                    user-select: none;
        }
        .grid9 >li >b {
          padding: 10px 0;
        }
        .grid9 >li >i {
          font: bold 1.25em/1 monaco, monospace;
        }
        .grid9-left {
          
        }
        .grid9-center {
          margin-left: 100px;
        }
        .grid9-right {
          margin-left: 200px;
        }
        .grid9-top {
          
        }
        .grid9-middle {
          margin-top: 100px;
        }
        .grid9-bottom {
          margin-top: 200px;
        }

        .grid9 i {
          font-style: normal;
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
            <!--<a href="http://loop.coop/" title="Created by Loop.Coop" class="magnubbin-logo">Loop.Coop</a>-->
            <div id="magnubbin-error" class="hidden"></div>
          </section>

          <section class="magnubbin-grid9">

            <!-- The Scene Grid9 appears when the background is clicked -->
            <ul id="grid9-scene" class="grid9">
              <li id="grid9-scene-add"    class="grid9-left   grid9-top"   ><b>Add</b   ><i>+</i></li>
              <li id="grid9-scene-save"   class="grid9-right  grid9-top"   ><b>Save</b  ><i>[]</i></li>
              <li id="grid9-scene-txy"    class="grid9-left   grid9-middle"><b>Move</b  ><i>x y</i></li>
              <li id="grid9-scene-scale"  class="grid9-center grid9-middle"><b>Zoom</b  ><i></i></li>
              <li id="grid9-scene-txz"    class="grid9-right  grid9-middle"><b>Move</b  ><i>x z</i></li>
              <li id="grid9-scene-rxy"    class="grid9-left   grid9-bottom"><b>Rotate</b><i>x y</i></li>
              <li id="grid9-scene-reset"  class="grid9-center grid9-bottom"><b>Reset</b ><i>/</i></li>
              <li id="grid9-scene-ryz"    class="grid9-right  grid9-bottom"><b>Rotate</b><i>y z</i></li>
            </ul>

            <!-- The Add Grid9 appears when the 'Add' button is clicked -->
            <ul id="grid9-add" class="grid9">
              <li id="grid9-add-back"    class="grid9-left   grid9-top"   ><b>Back</b><i>&lt;</i></li>
              <li id="grid9-add-shape-0" class="grid9-center grid9-top"   ><b>Add</b><i>Flatr</i></li>
              <li id="grid9-add-shape-1" class="grid9-right  grid9-top"   ><b>Add</b><i>Betr</i></li>
              <li id="grid9-add-shape-2" class="grid9-left   grid9-middle"><b>Add</b><i>Ocrex</i></li>
              <li id="grid9-add-shape-3" class="grid9-center grid9-middle"><b>Add</b><i>Icos</i></li>
              <li id="grid9-add-shape-4" class="grid9-right  grid9-middle"><b>Add</b><i>Decr</i></li>
              <li id="grid9-add-shape-5" class="grid9-left   grid9-bottom"><b>Add</b><i>Sqish</i></li>
              <li id="grid9-add-shape-6" class="grid9-center grid9-bottom"><b>Add</b><i>Slys</i></li>
              <li id="grid9-add-shape-7" class="grid9-right  grid9-bottom"><b>Add</b><i>Spyk</i></li>
            </ul>

            <!-- The Mesh Grid9 appears when a mesh in the 3D scene is clicked -->
            <ul id="grid9-mesh" class="grid9">
              <li id="grid9-mesh-delete" class="grid9-left   grid9-top   "><b>Delete</b><i>&times;</i></li>
              <li id="grid9-mesh-flip"   class="grid9-right  grid9-top   "><b>Flip</b  ><i>...</i></li>
              <li id="grid9-mesh-txy"    class="grid9-left   grid9-middle"><b>Move</b  ><i>x y</i></li>
              <li id="grid9-mesh-scale"  class="grid9-center grid9-middle"><b>Scale</b ><i></i></li>
              <li id="grid9-mesh-txz"    class="grid9-right  grid9-middle"><b>Move</b  ><i>x z</i></li>
              <li id="grid9-mesh-rxy"    class="grid9-left   grid9-bottom"><b>Rotate</b><i>x y</i></li>
              <li id="grid9-mesh-reset"  class="grid9-center grid9-bottom"><b>Reset</b ><i>/</i></li>
              <li id="grid9-mesh-ryz"    class="grid9-right  grid9-bottom"><b>Rotate</b><i>y z</i></li>
            </ul>

            <!-- The Flip Grid9 appears when the 'Flip' button is clicked -->
            <ul id="grid9-flip" class="grid9">
              <li id="grid9-flip-back"  class="grid9-left   grid9-top"   ><b>Back</b ><i>&lt;</i></li>
              <li id="grid9-flip-x"     class="grid9-left   grid9-middle"><b>Flip</b><i>x</i></li>
              <li id="grid9-flip-y"     class="grid9-center grid9-middle"><b>Flip</b><i>y</i></li>
              <li id="grid9-flip-z"     class="grid9-right  grid9-middle"><b>Flip</b><i>z</i></li>
            </ul>

          </section>

          <section class="magnubbin-panel-minmax">
            <a href="#/" title="Toggle info" class="magnubbin-toggle-preexisting">
              <span class="magnubbin-icon-info"></span>
            </a>
            <a href="#/" title="Toggle command" class="magnubbin-toggle-command">
              <span class="magnubbin-icon-control"></span>
            </a>
          </section>

          <section class="magnubbin-control">
            <!--@todo perhaps reinstate presets in a later version? -->
            <!--
            <ul class="magnubbin-presets">
              <li data-command="clear">Clear</li>
              <li data-command="add flatr">Add Flatr</li>
              <li data-command="add betr" >Add Betr</li>
              <li data-command="add ocrex">Add Ocrex</li>
              <li data-command="add icos" >Add Icos</li>
              <li data-command="add decr" >Add Decr</li>
              <li data-command="add sqish">Add Sqish</li>
              <li data-command="add slys" >Add Slys</li>
              <li data-command="add spyk" >Add Spyk</li>
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
            -->
            <h2>Type <tt>help</tt> to list commands:</h2>
            <pre id="ookonsole-display"></pre>
            <div><input id="ookonsole-command"></div>
          </section>
          <section class="magnubbin-preexisting">
            #{$htmlTarget.innerHTML}
          </section>
        </main>

      """

The ‘info’ icon toggles display of the preexisting HTML. 

      $('.magnubbin-toggle-preexisting').addEventListener 'click', ->
        $preexisting = $ '.magnubbin-preexisting'
        $icon        = $ '.magnubbin-icon-info'
        if /active/.test $preexisting.className
          $preexisting.className = 'magnubbin-preexisting'
          $icon.className        = 'magnubbin-icon-info'
        else
          $preexisting.className = 'magnubbin-preexisting active'
          $icon.className        = 'magnubbin-icon-info active'
          $('.magnubbin-control').className      = 'magnubbin-control'
          $('.magnubbin-icon-control').className = 'magnubbin-icon-control'
          grid9OnlyShow()

The ‘command’ icon toggles display of the command-line interface. 

      $('.magnubbin-toggle-command').addEventListener 'click', ->
        $control     = $ '.magnubbin-control'
        $icon        = $ '.magnubbin-icon-control'
        if /active/.test $control.className
          $control.className     = 'magnubbin-control'
          $icon.className        = 'magnubbin-icon-control'
        else
          $control.className     = 'magnubbin-control active'
          $icon.className        = 'magnubbin-icon-control active'
          $('.magnubbin-preexisting').className  = 'magnubbin-preexisting'
          $('.magnubbin-icon-info').className    = 'magnubbin-icon-info'
          grid9OnlyShow()
          $('#ookonsole-command').focus()

The ‘Get Started’ button hides the preexisting HTML. 

      $('.magnubbin-preexisting h5 strong').addEventListener 'click', ->
        $('.magnubbin-preexisting').className = 'magnubbin-preexisting'
        $('.magnubbin-icon-info').className   = 'magnubbin-icon-info'
        grid9OnlyShow()




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




#### `grid9OnlyShow()`
- `$el <HTMLElement>`  (optional) the grid9 `<UL>` element to show

Removes the 'active' class from all grid9 `<UL>` elements, except `$el`.  
If the optional `$el` arguemnt is not set, all `<UL>` elements are hidden. 

    grid9OnlyShow = ($el) ->
      for $grid9 in $$ '.grid9'
        $grid9.setAttribute 'class', 'grid9' # remove 'active'
      if $el then $el.setAttribute 'class', 'grid9 active'




#### `grid9IsActive()`
- `id <string>`  xx @todo describe

@todo describe

    grid9IsActive = (id) ->
      'gui active' == $('#' + id).getAttribute 'class'




#### `onMousedown()` and `onTouchstart()`

@todo describe

    onMousedown = (event, $el, deltaCalc) ->
      event.preventDefault()
      main = window.magnubbin
      main.deltaCalc = deltaCalc
      main.downPos = [event.clientX, event.clientY]
      main.snapshot = main.oo3d.read(main.focusI or main.cameraI)
      main.delta = null
      $('.magnubbin-grid9').className = 'magnubbin-grid9 active'
      window.addEventListener 'mousemove', onMousemove
      window.addEventListener 'mouseup'  , onMouseup

    onTouchstart = (event, $el, deltaCalc) ->
      event.preventDefault()
      main = window.magnubbin
      main.deltaCalc = deltaCalc
      touches = event.changedTouches
      main.downPos = [touches[0].pageX, touches[0].pageY]
      main.snapshot = main.oo3d.read(main.focusI or main.cameraI)
      main.delta = null
      $('.magnubbin-grid9').className = 'magnubbin-grid9 active'
      window.addEventListener 'touchmove', onTouchmove
      window.addEventListener 'touchend' , onTouchend




#### `onMousemove()` and `onTouchmove()`

@todo describe

    onMousemove = (event) ->
      main = window.magnubbin
      if main.downPos
        oo3d    = main.oo3d
        x       = event.clientX - main.downPos[0]
        y       = event.clientY - main.downPos[1]
        main.delta = main.deltaCalc x, y
        oo3d.edit main.focusI or main.cameraI, main.snapshot, main.delta
        if ! main.focusI then oo3d._all[main.cameraI].updateCamera()
        oo3d.render()
        main.updateMeshInfo()

    onTouchmove = (event) ->
      main = window.magnubbin
      if main.downPos
        oo3d    = main.oo3d
        touches = event.changedTouches
        x       = touches[0].pageX - main.downPos[0]
        y       = touches[0].pageY - main.downPos[1]
        main.delta = main.deltaCalc x, y
        oo3d.edit main.focusI or main.cameraI, main.snapshot, main.delta
        if ! main.focusI then oo3d._all[main.cameraI].updateCamera()
        oo3d.render()
        main.updateMeshInfo()




#### `onMouseup()` and `onTouchend()`

@todo describe

    onMouseup = (event) ->
      window.removeEventListener 'mousemove', onMousemove
      window.removeEventListener 'mouseup'  , onMouseup
      afterInteraction()

    onTouchend = (event) ->
      window.removeEventListener 'touchmove', onTouchmove
      window.removeEventListener 'touchend' , onTouchend
      afterInteraction()




#### `afterInteraction()`

@todo describe

    afterInteraction = ->
      main = window.magnubbin

      $('.magnubbin-grid9').className = 'magnubbin-grid9'

If the user has just completed a UI edit, convert `delta` to an 'edit' command. 

      if main.delta
        command = '§ edit'
        for option in ['rX','rY','rZ','sX','sY','sZ','tX','tY','tZ']
          if ªN == typeof main.delta[option]
            command += ' d' + option.toLowerCase() + ' ' + main.delta[option]

Append the 'edit' command to the log-display. Note that it isn’t executed. 

        $display = main.ookonsole.$display
        hasScrolledToEnd =
          $display.scrollTop > $display.scrollHeight - $display.offsetHeight
        $display.innerHTML += command + '\n'
        if hasScrolledToEnd
          $display.scrollTop = $display.scrollHeight

Reset Magnubbin state. 

      main.downPos   = null
      main.deltaCalc = (x, y) -> {}
      main.snapshot  = null;
      main.delta     = null;




#### `txy/txz/rxy/ryz/scaleDelta()`

@todo describe

    txyDelta = (x, y) ->
      tX: x /  500
      tY: y / -500

    txzDelta = (x, y) ->
      tX: x /  500
      tZ: y /  500

    rxyDelta = (x, y) ->
      rX: y /  500
      rY: x /  500

    ryzDelta = (x, y) ->
      rY: x /  500
      rZ: y / -500

    scaleDelta = (x, y) ->
      scale = Math.abs 1 + (x - y)/500
      sX: scale
      sY: scale
      sZ: scale




#### `parseQuery()`
- `query <string>`  eg from `window.location.search.slice 1`

Based on a [Stack Overflow answer](http://stackoverflow.com/a/2880929). 

    parseQuery = (query) ->
      search = /([^&=]+)=?([^&]*)/g
      decode = (s) -> decodeURIComponent s.replace(/\+/g, ' ')
      obj = {}
      while (match = search.exec query)
        obj[decode match[1]] = decode match[2]
      obj





