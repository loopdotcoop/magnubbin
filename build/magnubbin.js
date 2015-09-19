// Generated by CoffeeScript 1.9.2

/*! Magnubbin 0.0.12 //// MIT Licence //// http://magnubbin.loop.coop/ */

(function() {
  var Main, Ookonsole, afterInteraction, grid9IsActive, grid9OnlyShow, injectCSS, injectHTML, onMousedown, onMousemove, onMouseup, onPresetClick, onTouchend, onTouchmove, onTouchstart, rxyDelta, ryzDelta, scaleDelta, txyDelta, txzDelta, vpSize, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªex, ªhas, ªredefine, ªtype, ªuid;

  ªC = 'Magnubbin';

  ªV = '0.0.12';

  ªA = 'array';

  ªB = 'boolean';

  ªE = 'error';

  ªF = 'function';

  ªN = 'number';

  ªO = 'object';

  ªR = 'regexp';

  ªS = 'string';

  ªU = 'undefined';

  ªX = this;

  ª = console.log.bind(console);

  ªex = function(x, a, b) {
    var pos;
    if (-1 === (pos = a.indexOf(x))) {
      return x;
    } else {
      return b.charAt(pos);
    }
  };

  ªhas = function(h, n, t, f) {
    if (t == null) {
      t = true;
    }
    if (f == null) {
      f = false;
    }
    if (-1 !== h.indexOf(n)) {
      return t;
    } else {
      return f;
    }
  };

  ªtype = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  ªuid = function(p) {
    return p + '_' + (Math.random() + '1111111111111111').slice(2, 18);
  };

  ªredefine = function(obj, name, value, kind) {
    switch (kind) {
      case 'constant':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: true
        });
      case 'private':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: false
        });
    }
  };

  Main = (function() {
    Main.prototype.C = ªC;

    Main.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Main(config) {
      var error, k, v;
      if (config == null) {
        config = {};
      }
      for (k in config) {
        v = config[k];
        this[k] = v;
      }
      this.ookonsole = null;
      this.oo3d = null;
      this.$$presets = null;
      this.focusI = void 0;
      this.downPos = null;
      this.deltaCalc = function(x, y) {
        return {};
      };
      this.snapshot = null;
      this.delta = null;
      if (this.$cssTarget) {
        injectCSS(this.$cssTarget, "Injected by " + ªC + " " + ªV);
      }
      if (this.$htmlTarget) {
        injectHTML(this.$htmlTarget, "Injected by " + ªC + " " + ªV);
      }
      try {
        this.ookonsole = new Ookonsole({
          $display: $('#ookonsole-display'),
          $command: $('#ookonsole-command'),
          context: this
        });
        this.initTasks();
        this.ookonsole.show();
        this.ookonsole.start();
      } catch (_error) {
        error = _error;
        $('#magnubbin-error').innerHTML = error;
        $('#magnubbin-error').className = '';
        return;
      }
      try {
        this.$main = $('#oo3d-main');
        this.oo3d = new Oo3d({
          $main: this.$main,
          bkgnd: new Float32Array([1, 1, 1, 1])
        });
        this.pyramidPositionI = this.oo3d.add('Buffer.Position', {
          data: [0.0, 1.0, 0.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 0.0, 1.0, 0.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 0.0, 1.0, 0.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0]
        });
        this.pyramidColorI = this.oo3d.add('Buffer.Color', {
          data: [0.3, 0.0, 0.0, 0.95, 0.3, 0.0, 0.0, 0.95, 0.3, 0.0, 0.0, 0.95, 0.0, 0.25, 0.0, 0.75, 0.0, 0.25, 0.0, 0.75, 0.0, 0.25, 0.0, 0.75, 1.0, 0.25, 0.0, 0.10, 1.0, 0.25, 0.0, 0.10, 1.0, 0.25, 0.0, 0.10, 0.25, 0.5, 1.0, 0.05, 0.25, 0.5, 1.0, 0.05, 0.25, 0.5, 1.0, 0.05]
        });
        this.cameraI = this.oo3d.add('Item.Camera', {
          fovy: 0.785398163,
          aspect: this.$main.width / this.$main.height
        });
        this.flatItemProgramI = this.oo3d.add('Program.FlatItem', {
          subclass: 'Flat'
        });
        this.rendererI = this.oo3d.add('Renderer.Wireframe', {
          cameraI: this.cameraI,
          programI: this.flatItemProgramI,
          meshIs: []
        });
        this.layerI = this.oo3d.add('Layer.Simple', {
          rendererIs: [this.rendererI],
          scissor: [0, 0, 1, 1]
        });
        this.oo3d.render();
      } catch (_error) {
        error = _error;
        $('#magnubbin-error').innerHTML = error;
        $('#magnubbin-error').className = '';
        return;
      }
      this.initPresets();
      this.initGrid9();
    }

    Main.prototype.initTasks = function() {
      this.ookonsole.addTask('add', {
        summary: "Add a new magnubbin to the scene",
        completions: ['add ocrex', 'add slyce', 'add betr'],
        details: "add\n---\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var index, oo3d;
          oo3d = context.oo3d;
          switch (options[0]) {
            case 'ocrex':
              index = oo3d.add('Item.Mesh', {
                positionI: context.pyramidPositionI,
                colorI: context.pyramidColorI
              });
              oo3d._all[context.rendererI].meshes.push(oo3d._all[index]);
              context.changeFocus(index);
              oo3d.render();
              $('.magnubbin-focus-presets').innerHTML += "<li id=\"magnubbin-focus-preset-" + index + "\" \ndata-command=\"focus " + index + "\">Ocrex#" + index + "</li>";
              context.initPresets();
              return "Added ocrex. Focused on index " + index;
            default:
              return "'" + options[0] + "' not recognised";
          }
        }
      });
      this.ookonsole.addTask('delete', {
        summary: "Remove the focused Item.Mesh from the scene",
        completions: ['delete'],
        details: "delete\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          if (context.focusI) {
            context.oo3d["delete"](context.focusI);
            context.oo3d.render();
            return "Deleted index '" + context.focusI + "'";
          } else {
            return "Cannot delete the camera";
          }
        }
      });
      this.ookonsole.addTask('focus', {
        summary: "Focus on one of the magnubbins",
        completions: ['focus '],
        details: "focus\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var index, ref;
          index = options[0];
          if (!/^\d+$/.test(index)) {
            return "'" + index + "' is not a valid index - must be an integer";
          } else if ('Item.Mesh' !== ((ref = context.oo3d._all[+index]) != null ? ref.C : void 0)) {
            return "'" + index + "' is not the index of an Item.Mesh";
          } else {
            context.changeFocus(+index);
            context.oo3d.render();
            return "Focused on index '" + index + "'";
          }
        }
      });
      this.ookonsole.addTask('blur', {
        summary: "Focus on the camera",
        completions: ['blur'],
        details: "blur\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          context.changeFocus();
          context.oo3d.render();
          return "Focused on the camera";
        }
      });
      this.ookonsole.addTask('edit', {
        summary: "Edit the focused Item.Mesh, or the camera",
        completions: ['edit '],
        details: "edit\n----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var delta, i, l, option, set, value;
          set = {};
          delta = {};
          i = 0;
          l = options.length;
          while (i < l) {
            option = options[i++];
            value = +options[i++];
            if (!/^d?[rst][xyz]$/.test(option)) {
              return "`options[" + (i - 2) + "]` is invalid, use 'dtx', 'sz', etc";
            }
            if (isNaN(value)) {
              return "`options[" + (i - 1) + "]` is invalid, must be numeric";
            }
            if ('d' !== option.charAt(0)) {
              set[option[0] + option[1].toUpperCase()] = value;
            } else {
              delta[option[1] + option[2].toUpperCase()] = value;
            }
          }
          if (context.focusI) {
            context.oo3d.edit(context.focusI, set, delta);
            context.oo3d.render();
            return "Edited index '" + context.focusI + "'";
          } else {
            context.oo3d.edit(context.cameraI, set, delta);
            context.oo3d._all[context.cameraI].updateCamera();
            context.oo3d.render();
            return "Edited the camera";
          }
        }
      });
      return this.ookonsole.addTask('reset', {
        summary: "Reset the focused Item.Mesh, or the camera",
        completions: ['reset'],
        details: "reset\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          if (context.focusI) {
            context.oo3d.edit(context.focusI, 'reset');
            context.oo3d.render();
            return "Reset index '" + context.focusI + "'";
          } else {
            context.oo3d.edit(context.cameraI, 'reset');
            context.oo3d._all[context.cameraI].updateCamera();
            context.oo3d.render();
            return "Reset the camera";
          }
        }
      });
    };

    Main.prototype.initPresets = function() {
      var $preset, j, len, ref, results;
      this.$$presets = $$('.magnubbin-presets >li');
      ref = this.$$presets;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        $preset = ref[j];
        $preset.removeEventListener('click', onPresetClick);
        results.push($preset.addEventListener('click', onPresetClick));
      }
      return results;
    };

    Main.prototype.initGrid9 = function() {
      var deltaCalc, fn, fn1, fn2, id, main, meshName, meshNames, meshdeltaCalcs, scenedeltaCalcs;
      $('.magnubbin-view').addEventListener('mousedown', (function(_this) {
        return function(event) {
          var color, h, hRatio, meshI, w, wRatio, wh, x, y;
          wh = vpSize();
          w = wh[0];
          h = wh[1];
          wRatio = _this.$main.width / w;
          hRatio = _this.$main.height / h;
          x = Math.round(wRatio * event.clientX);
          y = Math.round(hRatio * event.clientY);
          color = _this.oo3d.getColorAt(x, _this.$main.height - y);
          meshI = _this.oo3d.getMeshIByColor(color);
          if (16777215 === meshI) {
            return _this.ookonsole.execute('blur');
          } else {
            return _this.ookonsole.execute('focus ' + meshI);
          }
        };
      })(this));
      $('#grid9-scene-add').addEventListener('mousedown', function(event) {
        return grid9OnlyShow($('#grid9-add'));
      });
      $('#grid9-scene-save').addEventListener('mousedown', (function(_this) {
        return function(event) {
          var instance, j, len, ref, saveURI;
          saveURI = '';
          ref = _this.oo3d._all;
          for (j = 0, len = ref.length; j < len; j++) {
            instance = ref[j];
            if ('Item.Mesh' === (instance != null ? instance.C : void 0)) {
              saveURI += _this.oo3d.read(instance.index, 'nwang') + ';';
            }
          }
          return prompt('Save URI:', 'http://magnubbin.loop.coop/#' + saveURI.slice(0, -1));
        };
      })(this));
      $('#grid9-scene-reset').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('reset');
        };
      })(this));
      scenedeltaCalcs = {
        'grid9-scene-txy': txyDelta,
        'grid9-scene-txz': txzDelta,
        'grid9-scene-rxy': rxyDelta,
        'grid9-scene-ryz': ryzDelta,
        'grid9-scene-scale': scaleDelta
      };
      fn = function(id, deltaCalc) {
        $('#' + id).addEventListener('mousedown', function(event) {
          return onMousedown(event, $('#grid9-scene'), deltaCalc);
        });
        return $('#' + id).addEventListener('touchstart', function(event) {
          return onTouchstart(event, $('#grid9-scene'), deltaCalc);
        });
      };
      for (id in scenedeltaCalcs) {
        deltaCalc = scenedeltaCalcs[id];
        fn(id, deltaCalc);
        void 0;
      }
      $('#grid9-add-back').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return grid9OnlyShow($('#grid9-mesh'));
        };
      })(this));
      meshNames = {
        'grid9-add-shape-0': 'ocrex',
        'grid9-add-shape-1': 'slyce'
      };
      fn1 = function(id, meshName) {
        return $('#' + id).addEventListener('mousedown', function(event) {
          return main.ookonsole.execute('add ' + meshName);
        });
      };
      for (id in meshNames) {
        meshName = meshNames[id];
        main = this;
        fn1(id, meshName);
        void 0;
      }
      $('#grid9-mesh-delete').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('delete');
        };
      })(this));
      $('#grid9-mesh-flip').addEventListener('mousedown', function(event) {
        return grid9OnlyShow($('#grid9-flip'));
      });
      $('#grid9-mesh-reset').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('reset');
        };
      })(this));
      meshdeltaCalcs = {
        'grid9-mesh-txy': txyDelta,
        'grid9-mesh-txz': txzDelta,
        'grid9-mesh-rxy': rxyDelta,
        'grid9-mesh-ryz': ryzDelta,
        'grid9-mesh-scale': scaleDelta
      };
      fn2 = function(id, deltaCalc) {
        $('#' + id).addEventListener('mousedown', function(event) {
          return onMousedown(event, $('#grid9-mesh'), deltaCalc);
        });
        return $('#' + id).addEventListener('touchstart', function(event) {
          return onTouchstart(event, $('#grid9-mesh'), deltaCalc);
        });
      };
      for (id in meshdeltaCalcs) {
        deltaCalc = meshdeltaCalcs[id];
        fn2(id, deltaCalc);
        void 0;
      }
      $('#grid9-flip-back').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return grid9OnlyShow($('#grid9-mesh'));
        };
      })(this));
      $('#grid9-flip-x').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('edit dsx -1');
        };
      })(this));
      $('#grid9-flip-y').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('edit dsy -1');
        };
      })(this));
      return $('#grid9-flip-z').addEventListener('mousedown', (function(_this) {
        return function(event) {
          return _this.ookonsole.execute('edit dsz -1');
        };
      })(this));
    };

    Main.prototype.changeFocus = function(focusI) {
      var $grid9Mesh, instance, j, len, ref;
      this.focusI = focusI;
      ref = this.oo3d._all;
      for (j = 0, len = ref.length; j < len; j++) {
        instance = ref[j];
        if ('Item.Mesh' === instance.C) {
          this.oo3d.setRenderMode('TRIANGLES', instance.index);
        }
      }
      if (ªN === typeof focusI) {
        this.oo3d.setRenderMode('LINE_LOOP', focusI);
        return grid9OnlyShow($('#grid9-mesh'));
      } else {
        $grid9Mesh = $('#grid9-scene');
        if ('grid9 active' === $grid9Mesh.getAttribute('class')) {
          return grid9OnlyShow();
        } else {
          return grid9OnlyShow($grid9Mesh);
        }
      }
    };

    Main.prototype.updateMeshInfo = function() {
      return ª('do updateMeshInfo!');
    };

    return Main;

  })();

  injectCSS = function($cssTarget, title) {
    return $cssTarget.innerHTML = "/* `@import` must go first */\n@import url(http://fonts.googleapis.com/css?family=Podkova);\n\n" + $cssTarget.innerHTML + "\n\n/* " + title + " */\n\n\n/* MAIN SECTIONS */\n.magnubbin-main {\n  color: #acb;\n}\n.magnubbin-main >* {\n  position: absolute;\n  box-sizing: border-box;\n  top:    0;\n  bottom: 0;\n  padding: 1rem;\n}\n.magnubbin-view {\n  left:   0;\n  right:  0;\n  padding: 0;\n  background: transparent; /* was rgba(30,50,40,0.7) */\n}\n.magnubbin-control {\n  display: flex;\n  flex-direction: column;\n  justify-content: flex-end;\n  right:  0;\n  width:  25%;\n  height: 100%;\n  min-width: 35rem; /* usual maximum ookonsole-display lines */\n  background: rgba(30,30,30,0.7);\n}\n.magnubbin-control >* {\n  flex-basis: 0%; /* log is '100%', so expands to fill */\n}\n.magnubbin-control h4 { /* @todo remove if not used */\n  margin: 0;\n  padding: 0.3em 0;\n}\n.magnubbin-control ul,\n.magnubbin-control pre {\n  margin-top: 0.5em;\n}\n.magnubbin-main a {\n  color: #eee;\n  text-decoration: none;\n  transition: all 0.5s;\n}\n.magnubbin-main a:hover {\n  color: #0f3;\n}\n\n\n/* 3D CONTEXT */\n#oo3d-main {\n  position: absolute;\n  top:     0;\n  left:    0;\n  width:   100%;\n  height:  100%;\n  z-index: -1;\n}\n\n\n/* INFO PANEL */\n.magnubbin-preexisting {\n  left:   -76%;\n  width:  75%;\n  background: rgba(10,10,10,0);\n  transition: all 1s;\n}\n.magnubbin-preexisting.active {\n  left:   0;\n  background: rgba(10,10,10,1);\n}\n\n\n/* TOGGLE */\n.magnubbin-toggle-preexisting {\n  display: block;\n  height: 3em;\n  margin: 0 0 0.3em 0;\n}\n.magnubbin-icon-info {\n  display: block;\n  float: left;\n  margin: -0.2em 0 0.2em 0;\n  padding: 0;\n  width:      1em;\n  height:     1em;\n  max-width:  1em;\n  max-height: 1em;\n  border: 2px solid; /* same as text color */\n  border-radius: 2em;\n  font: bold italic 2em serif;\n}\n.magnubbin-icon-info:before {\n  content: \"i\";\n  display: inline-block;\n  margin-left: 0.35em;\n}\n.magnubbin-logo {\n  font: bold 1.5em Podkova;\n}\n.magnubbin-control .magnubbin-logo {\n  float: right;\n}\n\n\n/* PRESETS */\nul.magnubbin-presets {\n  clear: both;\n  margin: 0 0 0.2em 0;\n  padding: 0;\n}\n.magnubbin-presets >li {\n  display: inline-block;\n  padding: 0.5em 0.8em;\n  margin: 0 0.2em 0.5em 0;\n  list-style-type: none;\n  border: 2px solid;\n  border-radius: 0.2em;\n  color: #eee;\n  cursor: pointer;\n  transition: all 0.5s;\n}\n.magnubbin-presets >li:hover {\n  color: #0f3;\n}\n\n\n/* DISPLAY AND COMMAND */\n.magnubbin-control #ookonsole-display {\n  flex-basis: 100%; /* override 1px */\n  margin: 0;\n  padding: 0.75em 0.8em;\n  border: 2px solid;\n  border-radius: 0.4em 0.4em 0 0;\n  font: 0.75rem \"monaco\", monospace;\n}\n#ookonsole-command {\n  display: block;\n  box-sizing: border-box;\n  padding: 0.5em;\n  width: 100%;\n  border: 2px solid #acb;\n  border-radius: 0 0 0.4em 0.4em;\n  font: 1em \"monaco\", monospace;\n  color: #eee;\n  background: transparent;\n}\n\n\n/* ERROR */\n#magnubbin-error {\n  position: absolute;\n  box-sizing: border-box;\n  bottom:  0;\n  left:    5%;\n  width:  90%;\n  padding: 1rem;\n  font-family: monaco, monospace;\n  background-color: #933;\n  color: #fff;\n  transition: all 0.5s;\n  opacity: 1;\n}\n#magnubbin-error.hidden {\n  padding-bottom: 0;\n  opacity: 0;\n}\n\n/* GRID9 */\n.magnubbin-grid {\n\n}\n.grid9 {\n  position:    fixed;\n  display:     block;\n  padding:     0;\n  width:       0;\n  height:      0;\n  left:        50%;\n  margin-left: -145px;\n  top:         50%;\n  margin-top:  -125px;\n  opacity:     0;  /* '1' when active */\n  z-index:     -5; /* '10' when active */\n  transition: opacity 0.4s, z-index 0.1s 0.5s;\n}\n.grid9.active {\n  z-index: 10;\n  opacity: 1;\n  transition: opacity 0.4s;\n}\n.grid9 >li {\n  position:    absolute;\n  width:       90px;\n  height:      90px;\n  list-style:  none;\n  text-align:  center;\n  color: #ccc;\n  background:  rgba(16,16,16,0.9);\n  cursor: default;\n  transition:  all 0.4s;\n}\n.grid9 >li:hover {\n  color:       #fff;\n  background:  rgba(0,0,0,0.95);\n}\n.grid9.active >li { /* eg during transition */\n  cursor: pointer;\n}\n.grid9 >li >b,\n.grid9 >li >i {\n  display: block;\n  -webkit-touch-callout: none; /* Android and iOS callouts*/\n    -webkit-user-select: none; /* Chrome, Safari, Opera */\n     -khtml-user-select: none; /* Konqueror */\n       -moz-user-select: none; /* Firefox */\n        -ms-user-select: none; /* IE */\n            user-select: none;\n}\n.grid9 >li >b {\n  padding: 10px 0;\n}\n.grid9 >li >i {\n  font-family: monospace;\n  line-height: 1;\n}\n.grid9-left {\n  \n}\n.grid9-center {\n  margin-left: 100px;\n}\n.grid9-right {\n  margin-left: 200px;\n}\n.grid9-top {\n  \n}\n.grid9-middle {\n  margin-top: 100px;\n}\n.grid9-bottom {\n  margin-top: 200px;\n}\n\n.grid9 i {\n  font-style: normal;\n}\n";
  };

  injectHTML = function($htmlTarget, title) {
    $htmlTarget.className += ' magnubbin-wrap';
    $htmlTarget.innerHTML = "\n\n\n<!-- " + title + " -->\n\n<!-- The main Magnubbin elements -->\n<main class=\"magnubbin-main\">\n  <section class=\"magnubbin-view\">\n    <canvas id=\"oo3d-main\" width=\"600\" height=\"450\"></canvas><!-- @todo resize with window -->\n    <a href=\"http://loop.coop/\" title=\"Created by Loop.Coop\" class=\"magnubbin-logo\">Loop.Coop</a>\n    <div id=\"magnubbin-error\" class=\"hidden\"></div>\n  </section>\n\n  <section class=\"magnubbin-grid9\">\n\n    <!-- The Scene Grid9 appears when the background is clicked -->\n    <ul id=\"grid9-scene\" class=\"grid9\">\n      <li id=\"grid9-scene-add\"    class=\"grid9-left   grid9-top\"   ><b>Add</b ><i>+</i></li>\n      <li id=\"grid9-scene-save\"   class=\"grid9-right  grid9-top\"   ><b>Save</b ><i>[]</i></li>\n      <li id=\"grid9-scene-txy\"    class=\"grid9-left   grid9-middle\"><b>Txy</b ><i></i></li>\n      <li id=\"grid9-scene-scale\"  class=\"grid9-center grid9-middle\"><b>Zoom</b><i></i></li>\n      <li id=\"grid9-scene-txz\"    class=\"grid9-right  grid9-middle\"><b>Txz</b ><i></i></li>\n      <li id=\"grid9-scene-rxy\"    class=\"grid9-left   grid9-bottom\"><b>Rxy</b ><i></i></li>\n      <li id=\"grid9-scene-reset\"  class=\"grid9-center grid9-bottom\"><b>Reset</b><i>/</i></li>\n      <li id=\"grid9-scene-ryz\"    class=\"grid9-right  grid9-bottom\"><b>Ryz</b ><i></i></li>\n    </ul>\n\n    <!-- The Add Grid9 appears when the 'Add' button is clicked -->\n    <ul id=\"grid9-add\" class=\"grid9\">\n      <li id=\"grid9-add-back\"    class=\"grid9-left   grid9-top\"   ><b>Back</b><i>&lt;</i></li>\n      <li id=\"grid9-add-shape-0\" class=\"grid9-center grid9-top\"   ><b>Add</b><i>0</i></li>\n      <li id=\"grid9-add-shape-1\" class=\"grid9-right  grid9-top\"   ><b>Add</b><i>1</i></li>\n      <li id=\"grid9-add-shape-2\" class=\"grid9-left   grid9-middle\"><b>Add</b><i>2</i></li>\n      <li id=\"grid9-add-shape-3\" class=\"grid9-center grid9-middle\"><b>Add</b><i>3</i></li>\n      <li id=\"grid9-add-shape-4\" class=\"grid9-right  grid9-middle\"><b>Add</b><i>4</i></li>\n      <li id=\"grid9-add-shape-5\" class=\"grid9-left   grid9-bottom\"><b>Add</b><i>5</i></li>\n      <li id=\"grid9-add-shape-6\" class=\"grid9-center grid9-bottom\"><b>Add</b><i>6</i></li>\n      <li id=\"grid9-add-shape-7\" class=\"grid9-right  grid9-bottom\"><b>Add</b><i>7</i></li>\n    </ul>\n\n    <!-- The Mesh Grid9 appears when a mesh in the 3D scene is clicked -->\n    <ul id=\"grid9-mesh\" class=\"grid9\">\n      <li id=\"grid9-mesh-delete\" class=\"grid9-left   grid9-top   \"><b>Delete</b><i>&times;</i></li>\n      <li id=\"grid9-mesh-flip\"   class=\"grid9-right  grid9-top   \"><b>Flip</b  ><i></i></li>\n      <li id=\"grid9-mesh-txy\"    class=\"grid9-left   grid9-middle\"><b>Txy</b   ><i></i></li>\n      <li id=\"grid9-mesh-txz\"    class=\"grid9-right  grid9-middle\"><b>Txz</b   ><i></i></li>\n      <li id=\"grid9-mesh-scale\"  class=\"grid9-center grid9-middle\"><b>Scale</b ><i></i></li>\n      <li id=\"grid9-mesh-rxy\"    class=\"grid9-left   grid9-bottom\"><b>Ryx</b   ><i></i></li>\n      <li id=\"grid9-mesh-reset\"  class=\"grid9-center grid9-bottom\"><b>Reset</b ><i>/</i></li>\n      <li id=\"grid9-mesh-ryz\"    class=\"grid9-right  grid9-bottom\"><b>Ryz</b   ><i></i></li>\n    </ul>\n\n    <!-- The Flip Grid9 appears when the 'Flip' button is clicked -->\n    <ul id=\"grid9-flip\" class=\"grid9\">\n      <li id=\"grid9-flip-back\"  class=\"grid9-left   grid9-top\"   ><b>Back</b ><i>&lt;</i></li>\n      <li id=\"grid9-flip-x\"     class=\"grid9-left   grid9-middle\"><b>FlipX</b><i></i></li>\n      <li id=\"grid9-flip-y\"     class=\"grid9-center grid9-middle\"><b>FlipY</b><i></i></li>\n      <li id=\"grid9-flip-z\"     class=\"grid9-right  grid9-middle\"><b>FlipZ</b><i></i></li>\n    </ul>\n\n  </section>\n\n  <section class=\"magnubbin-control\">\n    <a href=\"#/\" title=\"Toggle info\" class=\"magnubbin-toggle-preexisting\">\n      <span class=\"magnubbin-icon-info\"></span>\n      <span class=\"magnubbin-logo\">Magnubbin</span>\n    </a>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"clear\">Clear</li>\n      <li data-command=\"add ocrex\">Add Ocrex</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"edit drx -20\">rx-</li>\n      <li data-command=\"edit drx 20\" >rx+</li>\n      <li data-command=\"edit dry -20\">ry-</li>\n      <li data-command=\"edit dry 20\" >ry+</li>\n      <li data-command=\"edit drz -20\">rz-</li>\n      <li data-command=\"edit drz 20\" >rz+</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"edit dsx 2.0 dsy 2.0 dsz 2.0\">&times;2</li>\n      <li data-command=\"edit dsx 0.5 dsy 0.5 dsz 0.5\" >&divide2</li>\n      <li data-command=\"edit dsx -1\">fx</li>\n      <li data-command=\"edit dsy -1\">fy</li>\n      <li data-command=\"edit dsz -1\">fz</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"edit dtx -0.2\">x-</li>\n      <li data-command=\"edit dtx 0.2\" >x+</li>\n      <li data-command=\"edit dty -0.2\">y-</li>\n      <li data-command=\"edit dty 0.2\" >y+</li>\n      <li data-command=\"edit dtz -0.2\">z-</li>\n      <li data-command=\"edit dtz 0.2\" >z+</li>\n    </ul>\n    <ul class=\"magnubbin-presets magnubbin-focus-presets\">\n      <li data-command=\"blur\">Focus Camera</li>\n    </ul>\n    <pre id=\"ookonsole-display\"></pre>\n    <div><input id=\"ookonsole-command\"></div>\n  </section>\n  <section class=\"magnubbin-preexisting\">\n    " + $htmlTarget.innerHTML + "\n  </section>\n</main>\n";
    return $('.magnubbin-toggle-preexisting').addEventListener('click', function() {
      var $preexisting;
      $preexisting = $('.magnubbin-preexisting');
      if (/active/.test($preexisting.className)) {
        return $preexisting.className = 'magnubbin-preexisting';
      } else {
        return $preexisting.className = 'magnubbin-preexisting active';
      }
    });
  };

  onPresetClick = function(event) {
    var error;
    try {
      return window.magnubbin.ookonsole.execute(event.target.getAttribute('data-command'));
    } catch (_error) {
      error = _error;
      $('#magnubbin-error').innerHTML = error;
      return $('#magnubbin-error').className = '';
    }
  };

  vpSize = function(event) {
    var b, d, e, h, w;
    d = document;
    e = d.documentElement;
    b = d.getElementsByTagName('body')[0];
    w = window.innerWidth || e.clientWidth || b.clientWidth;
    h = window.innerHeight || e.clientHeight || b.clientHeight;
    return [w, h];
  };

  grid9OnlyShow = function($el) {
    var $grid9, j, len, ref;
    ref = $$('.grid9');
    for (j = 0, len = ref.length; j < len; j++) {
      $grid9 = ref[j];
      $grid9.setAttribute('class', 'grid9');
    }
    if ($el) {
      return $el.setAttribute('class', 'grid9 active');
    }
  };

  grid9IsActive = function(id) {
    return 'gui active' === $('#' + id).getAttribute('class');
  };

  onMousedown = function(event, $el, deltaCalc) {
    var main;
    event.preventDefault();
    main = window.magnubbin;
    main.deltaCalc = deltaCalc;
    main.downPos = [event.clientX, event.clientY];
    main.snapshot = main.oo3d.read(main.focusI || main.cameraI);
    main.delta = null;
    window.addEventListener('mousemove', onMousemove);
    return window.addEventListener('mouseup', onMouseup);
  };

  onTouchstart = function(event, $el, deltaCalc) {
    var main, touches;
    event.preventDefault();
    main = window.magnubbin;
    main.deltaCalc = deltaCalc;
    touches = event.changedTouches;
    main.downPos = [touches[0].pageX, touches[0].pageY];
    main.snapshot = main.oo3d.read(main.focusI || main.cameraI);
    main.delta = null;
    window.addEventListener('touchmove', onTouchmove);
    return window.addEventListener('touchend', onTouchend);
  };

  onMousemove = function(event) {
    var main, oo3d, x, y;
    main = window.magnubbin;
    if (main.downPos) {
      oo3d = main.oo3d;
      x = event.clientX - main.downPos[0];
      y = event.clientY - main.downPos[1];
      main.delta = main.deltaCalc(x, y);
      oo3d.edit(main.focusI || main.cameraI, main.snapshot, main.delta);
      if (!main.focusI) {
        oo3d._all[main.cameraI].updateCamera();
      }
      oo3d.render();
      return main.updateMeshInfo();
    }
  };

  onTouchmove = function(event) {
    var main, oo3d, touches, x, y;
    main = window.magnubbin;
    if (main.downPos) {
      oo3d = main.oo3d;
      touches = event.changedTouches;
      x = touches[0].pageX - main.downPos[0];
      y = touches[0].pageY - main.downPos[1];
      main.delta = main.deltaCalc(x, y);
      oo3d.edit(main.focusI || main.cameraI, main.snapshot, main.delta);
      if (!main.focusI) {
        oo3d._all[main.cameraI].updateCamera();
      }
      oo3d.render();
      return main.updateMeshInfo();
    }
  };

  onMouseup = function(event) {
    window.removeEventListener('mousemove', onMousemove);
    window.removeEventListener('mouseup', onMouseup);
    return afterInteraction();
  };

  onTouchend = function(event) {
    window.removeEventListener('touchmove', onTouchmove);
    window.removeEventListener('touchend', onTouchend);
    return afterInteraction();
  };

  afterInteraction = function() {
    var $display, command, hasScrolledToEnd, j, len, main, option, ref;
    main = window.magnubbin;
    if (main.delta) {
      command = '§ edit';
      ref = ['rX', 'rY', 'rZ', 'sX', 'sY', 'sZ', 'tX', 'tY', 'tZ'];
      for (j = 0, len = ref.length; j < len; j++) {
        option = ref[j];
        if (ªN === typeof main.delta[option]) {
          command += ' d' + option.toLowerCase() + ' ' + main.delta[option];
        }
      }
      $display = main.ookonsole.$display;
      hasScrolledToEnd = $display.scrollTop > $display.scrollHeight - $display.offsetHeight;
      $display.innerHTML += command + '\n';
      if (hasScrolledToEnd) {
        $display.scrollTop = $display.scrollHeight;
      }
    }
    main.downPos = null;
    main.deltaCalc = function(x, y) {
      return {};
    };
    main.snapshot = null;
    return main.delta = null;
  };

  txyDelta = function(x, y) {
    return {
      tX: x / 500,
      tY: y / -500
    };
  };

  txzDelta = function(x, y) {
    return {
      tX: x / 500,
      tZ: y / 500
    };
  };

  rxyDelta = function(x, y) {
    return {
      rX: y / 500,
      rY: x / 500
    };
  };

  ryzDelta = function(x, y) {
    return {
      rY: x / 500,
      rZ: y / -500
    };
  };

  scaleDelta = function(x, y) {
    var scale;
    scale = Math.abs(1 + (x - y) / 500);
    return {
      sX: scale,
      sY: scale,
      sZ: scale
    };
  };

  if (ªF === typeof define && define.amd) {
    define(function() {
      return Main;
    });
  } else if (ªO === typeof module && module && module.exports) {
    module.exports = Main;
  } else {
    this[ªC] = Main;
  }

  if (ªF === typeof define && define.amd) {

  } else if (ªO === typeof module && module && module.exports) {
    Ookonsole = require('ookonsole');
  } else if (this.Ookonsole) {
    Ookonsole = this.Ookonsole;
  } else {
    Ookonsole = window.Ookonsole;
  }

  if ((ªU !== typeof arts) && (ªU !== typeof resolvers) && (ªU !== typeof updaters)) {
    window.magnubbin = new Main({
      $cssTarget: $('style'),
      $htmlTarget: $('article')
    });
  }

}).call(this);
