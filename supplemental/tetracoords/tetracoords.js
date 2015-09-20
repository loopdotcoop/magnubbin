// Generated by CoffeeScript 1.9.2
(function() {
  window.tetraCoords = function(a, b, c, d, e, f) {
    var M, arg, coord, dy, dz, i, j, len, len1, name, oppB, out, pos, ref, ref1, ref2, result, y, z;
    M = 'tetraCoords()\n  ';
    ref = {
      a: a,
      b: b,
      c: c,
      d: d,
      e: e,
      f: f
    };
    for (name in ref) {
      arg = ref[name];
      if ('number' !== typeof arg) {
        throw TypeError(M + "Argument `" + name + "` is " + (typeof arg) + " not number");
      }
      if (9007199254740991 < arg || 0 > arg) {
        throw RangeError(M + "Argument `" + name + "` is " + arg + " not 0 or a +ve number < 2^53");
      }
    }
    out = [0, 0, 0];
    oppB = Math.acos((a * a + c * c - b * b) / (2 * a * c));
    out.push(Math.sin(oppB / 2) * -a, 0, Math.cos(oppB / 2) * -a);
    out.push(Math.sin(oppB / 2) * c, 0, Math.cos(oppB / 2) * -c);
    result = trilaterate({
      x: 0,
      y: 0,
      z: 0,
      r: d
    }, {
      x: out[3],
      y: 0,
      z: out[5],
      r: e
    }, {
      x: out[6],
      y: 0,
      z: out[8],
      r: f
    });
    if (null === result) {
      throw RangeError(M + "`" + a + "," + b + "," + c + "," + d + "," + e + "," + f + "` cannot be tetrahedron edges");
    }
    console.log(result, typeof result);
    if (2 === result.length) {
      out.push(result[1].x, result[1].y, result[1].z);
    } else {
      out.push(result.x, result.y, result.z);
    }
    dy = -out[10] / 3;
    ref1 = [1, 4, 7, 10];
    for (i = 0, len = ref1.length; i < len; i++) {
      y = ref1[i];
      out[y] += dy;
    }
    dz = -(out[5] + out[8]) / 4;
    ref2 = [2, 5, 8, 11];
    for (j = 0, len1 = ref2.length; j < len1; j++) {
      z = ref2[j];
      out[z] += dz;
    }
    out = (function() {
      var k, len2, results;
      results = [];
      for (k = 0, len2 = out.length; k < len2; k++) {
        coord = out[k];
        results.push(Math.round(coord * 1000) / 1000);
      }
      return results;
    })();
    out = (function() {
      var k, len2, results;
      results = [];
      for (k = 0, len2 = out.length; k < len2; k++) {
        coord = out[k];
        coord = (0 <= coord ? ' ' : '') + coord;
        pos = coord.indexOf('.');
        coord += (-1 === pos ? '.000' : '00');
        pos = coord.indexOf('.');
        results.push(coord = coord.slice(0, pos + 4));
      }
      return results;
    })();
    return out;
  };

}).call(this);