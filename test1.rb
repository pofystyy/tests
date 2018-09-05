require "minitest/autorun"

class Rtest < Minitest::Test
  def setup
    @before = rand_str
    @after = rand_str
    @str = rand_str
  end

  def rand_str
    ('a'..'z').to_a.shuffle[0,8].join
  end

  def test_basic_params
    assert_equal @str, format(@str)
  end

  def test_before_params
    assert_equal "#{@before}-#{@str}", format(@str, before: @before)
  end

  def test_after_params
    assert_equal "#{@str}-#{@after}", format(@str, after: @after)
  end

  def test_before_and_after_params
    assert_equal "#{@before}-#{@str}-#{@after}", format(@str, before: @before, after: @after)
  end

  def test_reverse_basic_params
    assert_equal @str.reverse, format(@str, reverse: true)
  end

  def test_reverse_before_params
    assert_equal "#{@before}-#{@str}".reverse, format(@str, before: @before, reverse: true)
  end

  def test_reverse_after_params
    assert_equal "#{@str}-#{@after}".reverse, format(@str, after: @after, reverse: true)
  end

  def test_reverse_before_and_after_params
    assert_equal "#{@before}-#{@str}-#{@after}".reverse, format(@str, before: @before, after: @after, reverse: true)
  end

  def test_wrong_param_exception
    assert_raises(ArgumentError) { format(@str, wrong_arg: 'test') }
  end
end

# START HERE

def format(str, params = {})
  whitelist = [:after, :before, :reverse]
  raise ArgumentError unless [params.keys - whitelist].flatten!.empty?
  arr = [params[:before], @str, params[:after]].compact.join('-')

    return arr.reverse if params.include?(:reverse)
    arr
end

def format(str, after: nil, before: nil, reverse: false)
  	arr = [before, str, after].compact.join('-')

    return arr.reverse if reverse
    arr
end

