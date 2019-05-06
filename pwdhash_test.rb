require 'minitest'
require 'minitest/unit'
require 'minitest/pride'
require 'minitest/autorun'

require './lib/pwdhash/pwdhash'
require './lib/pwdhash/extract_domain'

class PwdHashTest < Minitest::Test
  def test_passwords_with_domains
    [
      ['v0F0B', 'foo', 'skype.com'],
      ['paZTVGZwtewiq1+uCk', 'a l0ng p4assw0rd', 'google.com'],
      ['nRDL7WNyFODhF29gAkNmpA', 'qwertyuiop0987654321', 'google.com'],
      ['edi6wHWRQVA1rK8o9zaluwAAAA', 'qwertyuiop0987654321bingo', 'google.com'],
      ['8JyURsRs', 'foobar', 'thetimes.co.uk'],
    ].each do |expected, password, realm|
      assert_equal expected, get_hashed_password(password, realm)
    end
  end

  def test_passwords_with_complete_urls
    [
      ['v0F0B', 'foo', 'https://www.whatever.skype.com'],
      ['paZTVGZwtewiq1+uCk', 'a l0ng p4assw0rd', 'https://images.google.com'],
      ['nRDL7WNyFODhF29gAkNmpA', 'qwertyuiop0987654321', 'http://google.com'],
      ['edi6wHWRQVA1rK8o9zaluwAAAA', 'qwertyuiop0987654321bingo', 'https://news.google.com'],
      ['8JyURsRs', 'foobar', 'https://www.thetimes.co.uk/'],
    ].each do |expected, password, url|
      assert_equal expected, get_hashed_password(password, extract_domain(url))
    end
  end
end
