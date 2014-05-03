require 'rubygems'

def next_extra_character(extras)
  next_extra(extras).chr
end

def next_extra(extras)
  extras.empty? ? 0 : extras.shift[0]
end

def rotate(array, amount)
  amount.ord.downto(1) { array.push(array.shift) }
end

def between(min, interval, offset)
  (min.ord + offset.ord % interval).chr
end

def next_between(base, interval, extras)
  char_code = between(base[0], interval, next_extra(extras))
  char_code.chr
end

def contains(result, regex)
  result.match(regex)
end

def apply_constraints(hash, size, nonalphanumeric)
  startingSize = size - 4 # Leave room for some extra characters
  result = hash[0, startingSize]
  extras = (hash[startingSize, hash.length] || "").split('')
  
  # Add the extra characters
  result += (contains(result, /[A-Z]/) ? next_extra_character(extras) : next_between('A', 26, extras))
  result += (contains(result, /[a-z]/) ? next_extra_character(extras) : next_between('a', 26, extras))
  result += (contains(result, /[0-9]/) ? next_extra_character(extras) : next_between('0', 10, extras))
  result += (contains(result, /\W/) && nonalphanumeric ? next_extra_character(extras) : '+')
  while (contains(result, /\W/) && !nonalphanumeric) do
    result = result.sub(/\W/, next_between('A', 26, extras))
  end
  
  
  # Rotate the result to make it harder to guess the inserted locations
  result = result.split('')
  rotate(result, next_extra(extras))
  return result.join('')
end

require 'hmac-md5'
require 'base64'

module PwdHash
  class Hash
    attr_reader :hash
    def initialize(realm, password)
      @realm, @password = realm, password
      hash!
      remove_base64_pad_character
    end
    def size
      @password.length + '@@'.length
    end
    def contains_non_alphanumeric?
      @password =~ /\W/
    end
  private
    def hash!
      @hash = Base64.encode64(HMAC::MD5.digest(@password, @realm)).strip
    end
    def remove_base64_pad_character
      @hash.sub!(/=+$/, '')
    end
  end
end

def get_hashed_password(password, realm)
  hash = PwdHash::Hash.new(realm, password)
  apply_constraints(hash.hash, hash.size, hash.contains_non_alphanumeric?)
end

