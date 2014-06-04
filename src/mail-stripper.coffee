class MailStripper
  constructor: (@opts) ->
    if @opts.patterns
      @patterns = @patterns.concat(@opts.patterns)

  patterns: [
    /^\s*--/
    /\d{4}-\d{2}-\d{2} \d{2}:\d{2} GMT\+\d{2}:\d{2}/
    /^—/
    /<[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}>/i
  ]

  lineShouldBeStripped: (line) ->
    for pattern in @patterns
      if pattern.test line
        return true
    false

  lineContainsName: (line, name) ->
    name_re = new RegExp("^\\s*#{name}\\s*$", 'i')
    name_re.test(line)

  parse: (body, name) ->
    lines = body.replace(/\r\n/g, '\n').split('\n')
    message_lines = []
    for line in lines
      type = @lineShouldBeStripped(line)
      type = type or @lineContainsName(line, name) if name
      if not type
        message_lines.push(line)
      else
        break
    while message_lines.length > 0 and message_lines[message_lines.length - 1] is ''
      message_lines.pop()
    message_lines.join('\n')


module.exports = MailStripper