require 'minitest'
require 'minitest/unit'
require 'minitest/pride'
require 'minitest/autorun'

require './lib/pwdhash/pwdhash'

class PwdHashTest < Minitest::Test
  def test_passwords
    [
      ['v0F0B', 'foo', 'skype.com'],
      ['paZTVGZwtewiq1+uCk', 'a l0ng p4assw0rd', 'google.com'],
      ['nRDL7WNyFODhF29gAkNmpA', 'qwertyuiop0987654321', 'google.com'],
      ['edi6wHWRQVA1rK8o9zaluwAAAA', 'qwertyuiop0987654321bingo', 'google.com'],
    ].each do |expected, password, realm|
      assert_equal expected, get_hashed_password(password, realm)
    end
  end
end
