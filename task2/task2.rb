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
    raise ''
  end

  def even_reduce(acc)
    raise ''
  end

  def even_reduce_arg(acc, func)
    raise ''
  end

  def map_with_siblings
    raise ''
  end

end
