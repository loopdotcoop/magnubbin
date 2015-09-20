tetraCoords()
=============

#### Calculates the coordinates of a tetrahedron’s vertices from 6 edge lengths

- __G__ The point on the tabletop furthest away from you
- __H__ The leftmost point touching the tabletop
- __I__ The rightmost point touching the tabletop
- __J__ The point in the middle, not touching the table


To watch and compile automatically: 
```bash
coffee --watch --compile supplemental/tetracoords/tetracoords.litcoffee
```


#### `tetraCoords()`
- `a <number>`  the edge joining __G — H__
- `b <number>`  the edge joining __H — I__
- `c <number>`  the edge joining __I — G__
- `d <number>`  the edge joining __G — J__
- `e <number>`  the edge joining __J — H__
- `f <number>`  the edge joining __J — I__
- `<array>`     twelve numbers, representing (x,y,z) coords of __G, H, I and J__  

    window.tetraCoords = (a, b, c, d, e, f) ->
      M = 'tetraCoords()\n  '

Run basic validation of the six arguments. 

      for name,arg of { a:a,b:b,c:c,d:d,e:e,f:f }
        if 'number' != typeof arg then throw TypeError "
          #{M}Argument `#{name}` is #{typeof arg} not number"
        if 9007199254740991 < arg or 0 > arg then throw RangeError "
          #{M}Argument `#{name}` is #{arg} not 0 or a +ve number < 2^53"

Initialize the output array, and place __G,__ (the point on the tabletop 
furthest away from you) at the origin. 

      out = [
        0 # [0] = Gx
        0 # [1] = Gy
        0 # [2] = Gz
      ]

Use the [law of cosines](https://goo.gl/8djIju) to find the angle (in radians) 
of the corner opposite `b` on the tabletop. `cos B = (a² + c² − b²) / 2ac`  

      oppB = Math.acos( (a*a + c*c - b*b) / (2*a*c) )

Calculate __H,__ the leftmost point touching the tabletop. 

      out.push(
        Math.sin(oppB/2) * -a, # [3] = Hx
        0,                     # [4] = Hy
        Math.cos(oppB/2) * -a  # [5] = Hz
      )

Calculate __I,__ the rightmost point touching the tabletop. 

      out.push(
        Math.sin(oppB/2) * c,  # [6] = Ix
        0,                     # [7] = Iy
        Math.cos(oppB/2) * -c  # [8] = Iz
      )

Use `trilaterate()` to calculate __J,__ the raised point in the middle. 

      result = trilaterate(
        { x:0     , y:0, z:0     , r:d }, # p1
        { x:out[3], y:0, z:out[5], r:e }, # p2
        { x:out[6], y:0, z:out[8], r:f }  # p3
      )

Deal with an impossible tetrahedron. 

      if null == result then throw RangeError "
        #{M}`#{a},#{b},#{c},#{d},#{e},#{f}` cannot be tetrahedron edges"

`trilaterate()` usually returns coords for __J__ above _and_ below the tabletop. 

      if 2 == result.length
        out.push(
          result[1].x, #  [9] = Jx
          result[1].y, # [10] = Jy (`result[1]` is always +ve)
          result[1].z  # [11] = Jz
        )

If `trilaterate()` returns an object, we have a ‘flat’ tetrahedron

      else
        out.push(
          result.x,    #  [9] = Jx
          result.y,    # [10] = Jy (always 0)
          result.z     # [11] = Jz
        )

Move the tetrahedron coords so that the origin is roughly in the center. 

      dy = -out[10] / 3 # third of height, `-Jy / 3`
      out[y] += dy for y in [1,4,7,10]
      dz = -(out[5] + out[8]) / 4 # half of average depth, `(Hz + Iz) / 2 / 2`
      out[z] += dz for z in [2,5,8,11]

Round results to 3 decimal places. 

      out = (Math.round(coord * 1000) / 1000 for coord in out)

Convert to a neat string. @todo pass tetraCoords()` an argument to enable this

      out = (for coord in out
        coord  = (if 0 <= coord then ' ' else '') + coord
        pos = coord.indexOf '.'
        coord += (if -1 == pos then '.000' else '00')
        pos = coord.indexOf '.'
        coord = coord.slice 0, pos + 4
      )

Return the output array. 

      out



