require 'testml/runtime'
require 'testml/util'

class TestML::Runtime::Lang < TestML::Runtime
  include TestML::Util

  def assert_EQ(got, want)
    return bool got.value == want.value
  end

  def assert_HAS(got, has)
    return bool got.value.index(has.value) != -1
  end

  def assert_OK(got)
    return bool !! got.value
  end
end
