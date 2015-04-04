require "minitest/autorun"
require "debride/haml"
require "tempfile"

module TestDebride; end

class TestDebride::TestHaml < Minitest::Test
  def test_process_haml
    file = Tempfile.new ['debride-haml-test', '.haml']

    file.write(<<-HAML.strip)
%p
= 1/0
- "foo"
    HAML

    file.flush

    sexp = Debride.new.process_haml file.path

    # Output from Haml 4.0.6
    expected = s(:block, s(:call, s(:call, s(:call, nil, :_hamlout), :buffer), :<<, s(:dstr, "<p></p>\n", s(:evstr, s(:call, s(:lit, 1), :/, s(:lit, 0))), s(:str, "\n"))), s(:str, "foo"))

    assert_equal expected, sexp
  end
end
