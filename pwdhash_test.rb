require 'test/unit'
require File.dirname(__FILE__) + '/pwdhash'

class PwdHashTest < Test::Unit::TestCase
  
  def test_should_hash_password_and_domain
    expected = '1JMstxYHYz'
    actual = get_hashed_password('password', 'realm')
    assert_equal expected, actual
  end

  def test_should_apply_constraints
    expected = '1JMstxYHYz'
    actual = apply_constraints(hash='MstxYHYzGq0jEjzfTbaFrQ', size=10, nonalphanumeric=false)
    assert_equal expected, actual
  end

end
