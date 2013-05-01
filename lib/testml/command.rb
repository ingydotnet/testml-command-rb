require 'testml/runtime/lang'
require 'testml/compiler/pegex'
require 'testml/library/standard'
require 'testml/library/debug'

class TestML::Command
  VERSION = '0.0.1'

  def usage
    <<'...'
Usage:
  testml [testml-options] (<testml-file> | -) [runtime arguments]

TestML Options:
  -b, --bridge= <bridge-class[,bridge-class-list]>
...
  end

  def initialize(args)
    @args = args
    @file = nil
    @testml = nil
    @bridge = []
    @argv = []
    get_options(args)
  end

  def get_options(args)
    while arg = args.shift
      if arg =~ /^(?:-b|--bridge(?:=(.*))?)$/
        b = $1 || args.shift or error '-b|--bridge requires a value'
        @bridge.concat(b.split(','))
      elsif File.exists?(arg)
        @file = arg
        break
      elsif arg =~ /^--?$/
        break
      elsif arg !~ /^-/
        error "Input file '#{arg}' does not exist"
      else
        error "Unrecognized argument '#{arg}'"
      end
    end

    @testml = @file ? File.read(@file) : STDIN.read
    @argv = TestML::List.new(args.map {|a| TestML::String.new(a)})
  end

  def run
    @runtime = TestML::Runtime::Lang.new(
      testml: @testml,
      bridge: @bridge,
      compiler: TestML::Compiler::Pegex,
      library: [
        TestML::Library::Standard,
        TestML::Library::Debug,
      ],
    )
    @runtime.compile_testml
    @runtime.initialize_runtime
    #XXX @runtime
    @runtime.global.setvar('ARGV', @argv)
    @runtime.run_function(@runtime.function, [])
  end

  def error(msg)
    fail "Error: #{msg}\n\n#{usage}\n"
  end
end
