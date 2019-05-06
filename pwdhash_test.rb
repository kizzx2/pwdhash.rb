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

class PwdHash2Test < Minitest::Test
  def test_passwords_with_complete_urls
    # expected results calculated with https://gwuk.github.io/PwdHash2/pwdhash2/
    [
      ['5YrAI', 'foo', 10000, 'SomeSalt', 'https://www.skype.com/en/'],
      ['r8oIM4CR', 'foobar', 1, 'ChangeMe', 'https://google.com'],
      ['3PvCifzNoYaTNBMcJzVvDfDBeVK', 'correcthorsebatterystaple', 50000, 'COVwVNWVhwCsd7vlQ2T5BuIJBccYCu1RzR8rQFVHYVkGVQkZXHLkglnttWFQJYIN', 'https://about.google/intl/en/?fg=1&utm_source=google-EN&utm_medium=referral&utm_campaign=hp-header'],
      ['APC8mNJI', 'foobar', 1000, 'ChangeMe', 'https://google.com'],
    ].each do |expected, password, iterations, salt, url|
      assert_equal expected, get_hashed_password2(password, extract_domain(url), salt, iterations)
    end
  end

  def test_edge_cases
    # For testing only! Please always define salt and password. Number of iterations shouldn't be too low.
    [
      ['WWNEC9x1', 'foobar', 1000, '', 'https://google.com'],
      ['EBr2', '', 1000, '', 'https://google.com'],
      ['w0WD', '', 1, '', 'https://google.com'],
      ['w0WD', '', 0, '', 'https://google.com'],
      ['w0WD', '', -1, '', 'https://google.com'],
    ].each do |expected, password, iterations, salt, url|
      assert_equal expected, get_hashed_password2(password, extract_domain(url), salt, iterations)
    end
  end
end
