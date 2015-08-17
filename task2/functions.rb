#!/usr/bin/env ruby

require 'minitest/autorun'


class BlocksTest < Minitest::Test

  def test_even_map
    input = [11, -2, 32, 14, -5, 26]
    expected = [22, 64, -10]
    assert_equal(expected, input.even_map{|item| item * 2})
  end

  def test_even_reduce
    input = [11, -2, 32, 14, -5, 26]
    expected = [22, 64, -10]
    assert_equal(expected, input.even_reduce(0){|acc, item| acc + item})
  end

  def test_even_reduce
    input = [11, -2, 32, 14, -5, 26]
    expected = 38
    assert_equal(expected, input.even_reduce_arg(0 ,lambda{|acc, item| acc + item}))
  end

  def test_map_with_siblings
    input = [1, 2, 3]
    expected = [[nil, 1, 2], [1, 2, 3], [2, 3, nil]]
    assert_equal(expected, input.map_with_siblings{|prev ,current, nextt|[prev, current, nextt]})
  end

end


class Array

  def even_map
    result = []
    self.each_with_index do |n, i|
      if i.even?
        result.push yield(n)
      end
    end
    return result
  end

  def even_reduce(acc)
    self.each_with_index do |n, i|
      if i.even?
        acc = yield(acc, n)
      end
    end
    return acc
  end

  def even_reduce_arg(acc, func)
    self.each_with_index do |n,i|
      if i.even?
        acc=func.call(acc, n)
      end
    end
    return acc
  end

  def map_with_siblings
    result = []
    self.each_with_index do |n, i|
      prev = self[i - 1]
      if i == 0
        prev = nil
      end
      current = self[i]
      nextt = self[i + 1]
#      if i >= self.size
#        nextt = nil
#      end
      result.push(yield(prev, current, nextt))
    end
    return result
  end

end
