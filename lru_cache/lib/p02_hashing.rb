class Fixnum

  # Fixnum#hash already implemented for you
end

class Array
  # this doesn't type check, but needs the array to be only integer values.
  # XOR and converting to binary produces a unique binary digit, which is then
  # hashed with Ruby's built in Fixnum#hash

  def hash
    output = []
    each_with_index do |el, idx|
      el = el.hash unless el.is_a?(Numeric)
      output << (el ^ idx).to_s(2).to_i
    end
    output.join.to_i.hash
  end
end

class String
  def hash
    characters = chars.map { |let| let.ord }
    characters.hash
  end
end

class Hash
  def hash
    values.sort.map{ |el| el.hash }.hash
  end
end
