require 'parslet'

module Scion
  module Parsers

    module BasicRules
      include Parslet

      # http://tools.ietf.org/html/rfc5234#appendix-B.1
      rule(:alpha) { match(/[a-z]/i) }
      rule(:bit) { match(/[01]/) }
      rule(:char) { match(/[\u0001-\u007f]/) }
      rule(:digit) { match(/[0-9]/) }
      rule(:hexdig) { match(/[a-f0-9]/i)}
      rule(:vchar) { match(/[\u0021-\u007e]/) }

      rule(:sp) { str(' ') }
      rule(:sp?) { sp.repeat }
      rule(:htab) { str("\t") }
      rule(:wsp) { sp | htab }
      rule(:lwsp?) { (crlf.maybe >> wsp).repeat }

      rule(:cr) { str("\r") }
      rule(:lf) { str("\n") }
      rule(:crlf) { cr >> lf }
      rule(:dquote) { str('"') }

      # http://tools.ietf.org/html/rfc7230#section-3.2.6
      rule(:tchar) { alpha | digit | match(/[!#\$%&'\*\+\-\.\^_`\|~]/) }
      rule(:token) { tchar.repeat(1) }
    end
    
  end
end