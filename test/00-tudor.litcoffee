Tudor
=====

The easy-to-write, easy-to-read test framework. 




Define the `Tudor` class
------------------------

    class Tudor
      I: 'Tudor'
      toString: -> "[object #{I}]"

      articles: []




Define the constructor
----------------------

      constructor: (@opt={}) ->
        switch @opt.format
          when 'html'
            @pageHead = (summary) -> """
              <style>
                body     { font-family: sans-serif; }
                a        { outline: 0; }
                b        { display: inline-block; width: .7em }

                b.pass              { color: #393 }
                b.fail              { color: #bbb }
                article.fail b.pass { color: #bbb }
                section.fail b.pass { color: #bbb }

                pre      { padding: .5em; margin: .2em 0; border-radius: 4px; }
                pre.fn   { background-color: #fde }
                pre.pass { background-color: #cfc }
                pre.fail { background-color: #d8e0e8 }

                article  { margin-bottom: .5rem }
                article h2 { padding-left:.5rem; margin:0; font-weight:normal }
                article.pass { border-left: 5px solid #9c9 }
                article.fail { border-left: 5px solid #9bf }
                article.fail h2 { margin-bottom: .5rem }
                article.pass >div { display: none }

                section  { margin-bottom: .5rem }
                section h3   { padding-left: .5rem; margin: 0; }
                section.pass { border-left: 3px solid #9c9 }
                section.fail { border-left: 3px solid #9bf }
                section.fail h3 { margin-bottom: .5rem }
                section.pass >div { display: none }

                article.fail section.pass { border-left-color: #ccc }

                div      { padding-left: .5em; }
                div.fail { border-left: 3px solid #9bf; font-size: .8rem }
                div h4   { margin: 0 }
                div h4 { font: normal .8rem/1.2rem monaco, monospace }
                div.fail, div.fail h4 { margin: .5rem 0 }

              </style>
              <h4><a href="#end" id="top">\u2b07</a>  #{summary}</h4>
              """
            @pageFoot = (summary) -> """
              <h4><a href="#top" id="end">\u2b06</a>  #{summary}</h4>
              <script>
                document.title='#{summary.replace /<\/?[^>]+>/g,''}';
              </script>
              """
            @articleHead = (heading, fail) ->
                "<article class=\"#{if fail then 'fail' else 'pass'}\">" +
                "<h2>#{if fail then @cross else @tick}#{heading}</h2><div>"
            @articleFoot = '</div></article>'
            @sectionHead = (heading, fail) ->
                "<section class=\"#{if fail then 'fail' else 'pass'}\">" +
                "<h3>#{if fail then @cross else @tick}#{heading}</h3><div>"
            @sectionFoot = '</div></section>'
            @jobFormat = (heading, result) ->
                "<div class=\"#{if result then 'fail' else 'pass'}\">" +
                "<h4>#{if result then @cross else @tick}#{heading}</h4>" + 
                "#{if result then @formatError result else ''}" +
                "</div>"
            @tick   = '<b class="pass">\u2713</b> ' # Unicode CHECK MARK
            @cross  = '<b class="fail">\u2718</b> ' # Unicode HEAVY BALLOT X
          else
            @pageHead = (summary) ->   "#{summary}"
            @pageFoot = (summary) -> "\n#{summary}"
            @articleHead = (heading, fail) -> """
            
            #{if fail then @cross else @tick} #{heading}
            ===#{new Array(heading.length).join '='}

            """
            @articleFoot = ''
            @sectionHead = (heading, fail) -> """

            #{if fail then @cross else @tick} #{heading}
            ---#{new Array(heading.length).join '-'}

            """
            @sectionFoot = ''
            @jobFormat = (heading, result) ->
                "#{if result then @cross else @tick} #{heading}" +
                "#{if result then '\n' + @formatError result else ''}"
            @jobFoot = ''
            @tick   =   '\u2713' # Unicode CHECK MARK
            @cross  =   '\u2718' # Unicode HEAVY BALLOT X




Define public methods
---------------------

#### `add()`
Add a new article to the page. An article must contain at least one section. 

      add: (lines) ->

Create the `article` object and initialize `runner` and `section`. 

        article = { sections:[] }
        runner = null
        section = null

Run some basic validation on the `lines` array. 

        if ªA != ªtype lines then throw new Error "`lines` isn’t an array"
        if 0 == lines.length then throw new Error "`lines` has no elements"
        if ªS != ªtype lines[0] then throw new Error "`lines[0]` isn’t a string"

Add the article heading. 

        article.heading = lines.shift()

Step through each line, populating the `article` object as we go. 

        i = 0
        while i < lines.length
          line = lines[i]
          switch ªtype line

Change the current assertion-runner. 

            when ªO
              if ! line.runner then throw new Error "Errant object" #@todo better error message
              runner = line.runner

Record a mock-modifier. 

            when ªF
              section.jobs.push line

            when ªS

A string might signify a new assertion in the current section... 

              if @isAssertion lines[i+1], lines[i+2]
                if ! section then throw new Error "Cannot add an assertion here"
                section.jobs.push [
                  runner     # <function>  runner  Function to run the assertion
                  line       # <string>    name    A short description
                  lines[++i] # <mixed>     expect  Defines success
                  lines[++i] # <function>  actual  Produces the result to test
                ]

...or the beginning of a new section. 

              else
                section = {
                  heading: line
                  jobs: []
                }
                article.sections.push section

          i++

Append the article to the `articles` array.

        @articles.push article




#### `do()`
Run the test and return the result. 

      do: =>

Initialize the output array, as well as `mock` and the page pass/fail tallies. 

        pge = []
        mock = null
        pgePass = pgeFail = 0

        for article in @articles
          art = []
          artPass = artFail = 0

          for section in article.sections
            sec = []
            secPass = secFail = 0

            for job in section.jobs
              switch ªtype job
                when ªF # a mock-modifier
                  try mock = job.apply @, mock catch e then error = e.message
                  if error then sec.push @formatMockModifierError job, error
                when ªA # in the form `[ runner, heading, expect, actual ]`
                  [ runner, heading, expect, actual ] = job # dereference
                  result = runner expect, actual, mock # run the test
                  if ! result
                    sec.push @jobFormat "#{@sanitize heading}" 
                    pgePass++
                    artPass++
                    secPass++
                  else
                    sec.push @jobFormat "#{@sanitize heading}", result
                    pgeFail++
                    artFail++
                    secFail++

            sec.unshift @sectionHead "#{@sanitize section.heading}", secFail
            sec.push @sectionFoot
            art = art.concat sec

Xx. 

          art.unshift @articleHead "#{@sanitize article.heading}", artFail
          art.push @articleFoot
          pge = pge.concat art

Generate a page summary message. 

          summary = if pgeFail
            "#{@cross} FAILED #{pgeFail}/#{pgePass + pgeFail}"
          else
            "#{@tick} Passed #{pgePass}/#{pgePass + pgeFail}"

Return the result as a string, with summary at the start and end. 

        pge.unshift @pageHead summary
        pge.push    @pageFoot summary
        pge.join '\n'




#### `formatError()`
Format an exception or fail result. `result` should be an array with two, three 
or four elements. 

      formatError: (result) ->
        switch "#{result.length}-#{@opt.format}"

To format an exception, the elements are intro text and an error object. 

          when '2-html' then """
            #{result[0]}
            <pre class="fail">#{@sanitize result[1].message}</pre>
            """
          when '2-plain' then """
            #{result[0]}
            #{@sanitize result[1].message}
            """

To format an normal fail, the elements are 'actual', 'delivery' and 'expected'. 

          when '3-html' then """
            <pre class="fail">#{@sanitize @reveal result[0]}</pre>
            ...#{result[1]}...
            <pre class="pass">#{@sanitize @reveal result[2]}</pre>
            """
          when '3-plain' then """
            #{@sanitize @reveal result[0]}
            ...#{result[1]}...
            #{@sanitize @reveal result[2]}
            """

A fourth element (of any kind) signifies the fail is just a type-difference. 

          when '4-html' then """
            <pre class="fail">#{@sanitize @reveal result[0]} (#{ªtype result[0]})</pre>
            ...#{result[1]}...
            <pre class="pass">#{@sanitize @reveal result[2]} (#{ªtype result[2]})</pre>
            """
          when '4-plain' then """
            #{@sanitize @reveal result[0]} (#{ªtype result[0]})
            ...#{result[1]}...
            #{@sanitize @reveal result[2]} (#{ªtype result[2]})
            """

Any other number of elements is invalid. 

          else
            throw new Error "Cannot process '#{result.length}-#{@opt.format}'"




#### `formatMockModifierError()`
Format an exception message encountered by a mock-modifier function. 

      formatMockModifierError: (fn, error) ->
        switch @opt.format
          when 'html' then """
            <pre class="fn">#{@sanitize fn+''}</pre>
            ...encountered an exception:
            <pre class="fail">#{@sanitize error}</pre>
            """
          else """
            #{@sanitize fn+''}
            ...encountered an exception:
            #{@sanitize error}
            """




#### `reveal()`
Convert to string and reveal invisibles. @todo deal with very long strings, reveal [null] etc, ++more

      reveal: (value) ->
        value?.toString().replace /^\s+|\s+$/g, (match) ->
          '\u00b7' + (new Array match.length).join '\u00b7'




#### `sanitize()`
Escape a string for display, depending on the current `format` option.

      sanitize: (value) ->
        switch @opt.format
          when 'html'
            value?.toString().replace /</g, '&lt;'
          else
            value




#### `throw()`
An assertion-runner which expects `actual()` to throw an exception. 

      throw:
        runner: (expect, actual, mock) ->
          error = false
          try actual.apply @, mock catch e then error = e
          if ! error
            [ 'No exception thrown, expected', { message:expect } ]
          else if expect != error.message
            [ error.message, 'was thrown, but expected', expect ]




#### `equal()`
An assertion-runner which expects `actual()` and `expect` to be equal. 

      equal: 
        runner: (expect, actual, mock) ->
          error = false
          try result = actual.apply @, mock catch e then error = e
          if error
            [ 'Unexpected exception', error ]
          else if expect != result
            if result+'' == expect+''
              [ result, 'was returned, but expected', expect, true ]
            else
              [ result, 'was returned, but expected', expect ]




#### `is()`
An assertion-runner which expects `ªtype( actual() )` and `expect` to be equal. 

      is: 
        runner: (expect, actual, mock) ->
          error = false
          try result = actual.apply @, mock catch e then error = e
          if error
            [ 'Unexpected exception', error ]
          else if expect != ªtype result
            [ "type #{ªtype result}", 'was returned, but expected', "type #{expect}" ]




#### `match()`
An assertion-runner where `expect` is a regexp, or an object containing a 
`test()` method. 

      match: 
        runner: (expect, actual, mock) ->
          error = false
          try result = actual.apply @, mock catch e then error = e
          if error
            [ 'Unexpected exception', error ]
          else if ªF != typeof expect.test
            [ '`test()` is not a function', { message:expect } ]
          else if ! expect.test ''+result
            [ ''+result, 'failed test', expect ]




#### `isAssertion()`
Xx. @todo
Note brackets around `ªO == ªtype line1`, which makes this conditional behave 
as expected! 

      isAssertion: (line1, line2) ->
        if ªF != ªtype line2 then return false
        if (ªO == ªtype line1) && ªF == ªtype line1.runner then return false
        true




Instantiate the `tudor` object
------------------------------

Create an instance of `Tudor`, to add assertions to. 

    tudor = new Tudor
      format: if ªO == typeof window then 'html' else 'plain'


Expose `todor`’s `do()` function as a module method, so that any consumer of 
this module can run its assertions. In Node, for example:  
`require('foo').runTest();`

    Main.runTest = tudor.do



