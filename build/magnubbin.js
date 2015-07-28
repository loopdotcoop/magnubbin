// Generated by CoffeeScript 1.9.2

/*! Magnubbin 0.0.7 //// MIT Licence //// http://magnubbin.loop.coop/ */

(function() {
  var Main, Ookonsole, injectCSS, injectHTML, main, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªex, ªhas, ªredefine, ªtype, ªuid;

  ªC = 'Magnubbin';

  ªV = '0.0.7';

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
      var $preset, error, i, k, len, ref, v;
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
      this.focus = void 0;
      if (this.$cssTarget) {
        injectCSS(this.$cssTarget, "Injected by " + ªC + " " + ªV);
      }
      if (this.$htmlTarget) {
        injectHTML(this.$htmlTarget, "Injected by " + ªC + " " + ªV);
      }
      this.$$presets = $$('.magnubbin-presets >li');
      ref = this.$$presets;
      for (i = 0, len = ref.length; i < len; i++) {
        $preset = ref[i];
        $preset.addEventListener('click', (function(_this) {
          return function(event) {
            return _this.ookonsole.execute(event.target.getAttribute('data-command'));
          };
        })(this));
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
        this.oo3d = new Oo3d({
          $main: $('#oo3d-main')
        });
        this.oo3d.render();
      } catch (_error) {
        error = _error;
        $('#magnubbin-error').innerHTML = error;
        $('#magnubbin-error').className = '';
      }
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
              index = oo3d.addBuffer({
                positions: [-2.0, 0.3, -1.84, 2.0, 0.3, -1.84, 0.0, 0.0, 2.742566667, 0.0, 0.0, 2.742566667, 0.0, 2.2678, 0.77866667, -2.0, 0.3, -1.84, -2.0, 0.3, -1.84, 0.0, 2.2678, 0.77866667, 2.0, 0.3, -1.84, 2.0, 0.3, -1.84, 0.0, 2.2678, 0.77866667, 0.0, 0.0, 2.742566667],
                colors: [1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0]
              });
              context.focus = index;
              oo3d.render();
              return "Added slyce. Focused on index " + index;
            case 'slyce':
              index = oo3d.addBuffer({
                positions: [0.0, 0.3, 1.0, -0.4, -0.5, 1.0, 0.8, -0.3, 1.0],
                colors: [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0]
              });
              context.focus = index;
              oo3d.render();
              return "Added slyce. Focused on index " + index;
            case 'betr':
              index = oo3d.addBuffer({
                positions: [1.0, 0.3, -1.0, -0.4, -0.5, 0.0, 0.8, 0.3, -1.0],
                colors: [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0]
              });
              context.focus = index;
              oo3d.render();
              return "Added betr. Focused on index " + index;
            default:
              return "'" + options[0] + "' not recognised";
          }
        }
      });
      this.ookonsole.addTask('focus', {
        summary: "Focus on one of the magnubbins",
        completions: ['focus '],
        details: "focus\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var index, target;
          index = options[0];
          if (!/^\d+$/.test(index)) {
            return "'" + index + "' is not a valid index - must be an integer";
          } else if (!(target = context.oo3d.buffers[+index])) {
            return "Index '" + index + "' does not exist";
          } else {
            context.focus = +index;
            return "Focused on index '" + index + "'";
          }
        }
      });
      this.ookonsole.addTask('blur', {
        summary: "Focus on the camera",
        completions: ['blur'],
        details: "blur\n-----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          context.focus = void 0;
          return "Focused on the camera";
        }
      });
      this.ookonsole.addTask('move', {
        summary: "Move the Focused magnubbin",
        completions: ['move ', 'move x ', 'move y ', 'move z '],
        details: "move\n----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var axis, config, distance;
          axis = options[0];
          distance = options[1];
          if (!/^[xyz]$/.test(axis)) {
            return "Axis " + axis + " is not valid - use x, y, or z";
          } else if (!/^-?\d+(.\d+)?$/.test(distance)) {
            return "Distance " + distance + " is not valid - must be numeric";
          } else {
            config = {
              target: context.focus,
              type: 'translate'
            };
            config[axis] = +distance;
            context.oo3d.transform(config);
            context.oo3d.render();
            if (ªN === ªtype(context.focus)) {
              return "Moved index '" + context.focus + "'";
            } else {
              return "Moved the camera";
            }
          }
        }
      });
      return this.ookonsole.addTask('rotate', {
        summary: "Move the Focused magnubbin",
        completions: ['rotate ', 'rotate x ', 'rotate y ', 'rotate z '],
        details: "rotate\n----\n@todo describe. \n\n@todo usage\n",
        runner: function(context, options) {
          var axis, config, degrees;
          axis = options[0];
          degrees = options[1];
          if (!/^[xyz]$/.test(axis)) {
            return "Axis " + axis + " is not valid - use x, y, or z";
          } else if (!/^-?\d+(.\d+)?$/.test(degrees)) {
            return "Degrees " + degrees + " is not valid - must be numeric";
          } else {
            config = {
              target: context.focus,
              type: 'rotate' + axis.toUpperCase(),
              rad: degrees * Math.PI / 180
            };
            context.oo3d.transform(config);
            context.oo3d.render();
            if (ªN === ªtype(context.focus)) {
              return "Rotated index '" + context.focus + "' " + degrees + "º on axis " + axis;
            } else {
              return "Rotated the camera " + degrees + "º on axis " + axis;
            }
          }
        }
      });
    };

    Main.prototype.yy = function(xx) {};

    return Main;

  })();

  injectCSS = function($cssTarget, title) {
    return $cssTarget.innerHTML = "/* `@import` must go first */\n@import url(http://fonts.googleapis.com/css?family=Podkova);\n\n" + $cssTarget.innerHTML + "\n\n/* " + title + " */\n\n\n/* MAIN SECTIONS */\n.magnubbin-main {\n  color: #acb;\n}\n.magnubbin-main >* {\n  position: absolute;\n  box-sizing: border-box;\n  top:    0;\n  bottom: 0;\n  padding: 1rem;\n}\n.magnubbin-view {\n  left:   0;\n  right:  0;\n  background: rgba(30,50,40,0.7);\n}\n.magnubbin-control {\n  display: flex;\n  flex-direction: column;\n  justify-content: flex-end;\n  right:  0;\n  width:  25%;\n  height: 100%;\n  min-width: 35rem; /* usual maximum ookonsole-display lines */\n  background: rgba(30,30,30,0.7);\n}\n.magnubbin-control >* {\n  flex-basis: 0%; /* log is '100%', so expands to fill */\n}\n.magnubbin-control h4 { /* @todo remove if not used */\n  margin: 0;\n  padding: 0.3em 0;\n}\n.magnubbin-control ul,\n.magnubbin-control pre {\n  margin-top: 0.5em;\n}\n.magnubbin-main a {\n  color: #eee;\n  text-decoration: none;\n  transition: all 0.5s;\n}\n.magnubbin-main a:hover {\n  color: #0f3;\n}\n\n\n/* 3D CONTEXT */\n#oo3d-main {\n  position: absolute;\n  top:     0;\n  left:    0;\n  width:   100%;\n  height:  100%;\n  z-index: -1;\n}\n\n\n/* INFO PANEL */\n.magnubbin-preexisting {\n  left:   -76%;\n  width:  75%;\n  background: rgba(10,10,10,0);\n  transition: all 1s;\n}\n.magnubbin-preexisting.active {\n  left:   0;\n  background: rgba(10,10,10,1);\n}\n\n\n/* TOGGLE */\n.magnubbin-toggle-preexisting {\n  display: block;\n  height: 3em;\n  margin: 0 0 0.3em 0;\n}\n.magnubbin-icon-info {\n  display: block;\n  float: left;\n  margin: -0.2em 0 0.2em 0;\n  padding: 0;\n  width:      1em;\n  height:     1em;\n  max-width:  1em;\n  max-height: 1em;\n  border: 2px solid; /* same as text color */\n  border-radius: 2em;\n  font: bold italic 2em serif;\n}\n.magnubbin-icon-info:before {\n  content: \"i\";\n  display: inline-block;\n  margin-left: 0.35em;\n}\n.magnubbin-logo {\n  font: bold 1.5em Podkova;\n}\n.magnubbin-control .magnubbin-logo {\n  float: right;\n}\n\n\n/* PRESETS */\nul.magnubbin-presets {\n  clear: both;\n  margin: 0 0 0.2em 0;\n  padding: 0;\n}\n.magnubbin-presets >li {\n  display: inline-block;\n  padding: 0.5em 0.8em;\n  margin: 0 0.2em 0.5em 0;\n  list-style-type: none;\n  border: 2px solid;\n  border-radius: 0.2em;\n  color: #eee;\n  cursor: pointer;\n  transition: all 0.5s;\n}\n.magnubbin-presets >li:hover {\n  color: #0f3;\n}\n\n\n/* DISPLAY AND COMMAND */\n.magnubbin-control #ookonsole-display {\n  flex-basis: 100%; /* override 1px */\n  margin: 0;\n  padding: 0.75em 0.8em;\n  border: 2px solid;\n  border-radius: 0.4em 0.4em 0 0;\n  font: 0.75rem \"monaco\", monospace;\n}\n#ookonsole-command {\n  display: block;\n  box-sizing: border-box;\n  padding: 0.5em;\n  width: 100%;\n  border: 2px solid #acb;\n  border-radius: 0 0 0.4em 0.4em;\n  font: 1em \"monaco\", monospace;\n  color: #eee;\n  background: transparent;\n}\n\n\n/* ERROR */\n#magnubbin-error {\n  position: absolute;\n  box-sizing: border-box;\n  bottom:  0;\n  left:    5%;\n  width:  90%;\n  padding: 1rem;\n  font-family: monaco, monospace;\n  background-color: #933;\n  color: #fff;\n  transition: all 0.5s;\n  opacity: 1;\n}\n#magnubbin-error.hidden {\n  padding-bottom: 0;\n  opacity: 0;\n}\n";
  };

  injectHTML = function($htmlTarget, title) {
    $htmlTarget.className += ' magnubbin-wrap';
    $htmlTarget.innerHTML = "\n\n\n<!-- " + title + " -->\n\n<!-- The main Magnubbin elements -->\n<main class=\"magnubbin-main\">\n  <section class=\"magnubbin-view\">\n    <canvas id=\"oo3d-main\" width=\"600\" height=\"450\"></canvas><!-- @todo resize with window -->\n    <a href=\"http://loop.coop/\" title=\"Created by Loop.Coop\" class=\"magnubbin-logo\">Loop.Coop</a>\n    <div id=\"magnubbin-error\" class=\"hidden\"></div>\n  </section>\n  <section class=\"magnubbin-control\">\n    <a href=\"#/\" title=\"Toggle info\" class=\"magnubbin-toggle-preexisting\">\n      <span class=\"magnubbin-icon-info\"></span>\n      <span class=\"magnubbin-logo\">Magnubbin</span>\n    </a>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"clear\">Clear</li>\n      <li data-command=\"add ocrex\">Add Ocrex</li>\n      <li data-command=\"add slyce\">Add Slyce</li>\n      <li data-command=\"add betr\">Add Betr</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"move x -0.2\">x-</li>\n      <li data-command=\"move x 0.2\" >x+</li>\n      <li data-command=\"move y -0.2\">y-</li>\n      <li data-command=\"move y 0.2\" >y+</li>\n      <li data-command=\"move z -0.2\">z-</li>\n      <li data-command=\"move z 0.2\" >z+</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"rotate x -20\">rx-</li>\n      <li data-command=\"rotate x 20\" >rx+</li>\n      <li data-command=\"rotate y -20\">ry-</li>\n      <li data-command=\"rotate y 20\" >ry+</li>\n      <li data-command=\"rotate z -20\">rz-</li>\n      <li data-command=\"rotate z 20\" >rz+</li>\n    </ul>\n    <ul class=\"magnubbin-presets\">\n      <li data-command=\"blur\">Focus Camera</li>\n      <li data-command=\"focus 0\">0</li>\n      <li data-command=\"focus 1\">1</li>\n      <li data-command=\"focus 2\">2</li>\n      <li data-command=\"focus 3\">3</li>\n      <li data-command=\"focus 4\">4</li>\n    </ul>\n    <pre id=\"ookonsole-display\"></pre>\n    <div><input id=\"ookonsole-command\"></div>\n  </section>\n  <section class=\"magnubbin-preexisting\">\n    " + $htmlTarget.innerHTML + "\n  </section>\n</main>\n";
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
    main = new Main({
      $cssTarget: $('style'),
      $htmlTarget: $('article')
    });
  }

}).call(this);
